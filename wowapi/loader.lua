local data = require('wowapi.data')
local plprettywrite = require('pl.pretty').write
local util = require('wowless.util')

local function loadApis(product)
  local apis = {}
  for fn, yaml in pairs(data.apis) do
    local match = not yaml.products
    if yaml.products then
      for _, p in ipairs(yaml.products) do
        if product == p then
          match = true
        end
      end
    end
    if match and not yaml.debug then
      apis[fn] = yaml
    end
  end
  return apis
end

local getStub = (function()
  local defaultOutputs = {
    boolean = 'false',
    ['function'] = 'function() end',
    ['nil'] = 'nil',
    number = '1',
    oneornil = 'nil',
    string = '\'\'',
    table = '{}',
    unknown = 'nil',
  }
  local structureDefaults = {}
  local function ensureStructureDefault(name)
    if structureDefaults[name] == nil then
      structureDefaults[name] = true
      local st = data.structures[name]
      local t = {}
      for _, field in ipairs(st.fields) do
        local v
        if data.structures[field.type] then
          ensureStructureDefault(field.type)
          v = structureDefaults[field.type]
        elseif field.stub then
          assert(type(field.stub) == 'string', 'only string stubs supported in structures')
          v = string.format('%q', field.stub)
        else
          v = tostring(defaultOutputs[field.nilable and 'nil' or field.type])
        end
        if field.mixin then
          v = ('Mixin(%s,%s)'):format(v, field.mixin)
        end
        table.insert(t, ('[%q]=%s'):format(field.name, v))
      end
      structureDefaults[name] = '{' .. table.concat(t, ',') .. '}'
    else
      assert(structureDefaults[name] ~= true, 'loop in structure definitions')
    end
  end
  for name in pairs(data.structures) do
    ensureStructureDefault(name)
  end
  return function(sig)
    local rets = {}
    for _, out in ipairs(sig) do
      local v
      if out.stub or out.default then
        local value = out.stub or out.default
        local ty = type(value)
        if ty == 'number' or ty == 'boolean' then
          v = tostring(value)
        elseif ty == 'string' then
          v = string.format('%q', value)
        elseif ty == 'table' then
          v = plprettywrite(value)
        else
          error('unsupported stub value type ' .. ty)
        end
      elseif out.nilable then
        v = 'nil'
      else
        v = defaultOutputs[out.type] or structureDefaults[out.type]
      end
      assert(v, ('invalid output type %q'):format(out.type))
      table.insert(rets, v)
    end
    return loadstring('return ' .. table.concat(rets, ', '))
  end
end)()

local function mkdb2s(loader)
  return setmetatable({}, {
    __index = function(dbs, db)
      local t = {}
      for row in loader.db2rows(db) do
        table.insert(t, row)
      end
      dbs[db] = {
        data = t,
        indices = {},
      }
      return dbs[db]
    end,
  })
end

local function doGetFn(api, loader, apicfg, db2s)
  if apicfg.status == 'autogenerated' or apicfg.status == 'unimplemented' then
    return setfenv(getStub(apicfg.outputs or {}), api.env)
  elseif apicfg.status == 'implemented' then
    local args = {}
    local frameworks = {
      api = api, -- TODO replace api framework with something finer grained
      env = api.env,
      loader = loader,
    }
    for _, fw in ipairs(apicfg.frameworks or {}) do
      table.insert(args, (assert(frameworks[fw], 'unknown framework ' .. fw)))
    end
    for _, st in ipairs(apicfg.states or {}) do
      table.insert(args, api.states[st])
    end
    for _, db in ipairs(apicfg.dbs or {}) do
      table.insert(
        args,
        (function()
          if not db.index then
            return function()
              local t = db2s[db.name].data
              local idx = 0
              return function()
                idx = idx + 1
                return t[idx]
              end
            end
          else
            local function keyify(x)
              return type(x) == 'string' and x:lower() or x
            end
            return function(k)
              local db2 = db2s[db.name]
              local index = db2.indices[db.index]
              if not index then
                index = {}
                for _, row in ipairs(db2.data) do
                  local rowkey = keyify(row[db.index])
                  index[rowkey] = index[rowkey] or row
                end
                db2.indices[db.index] = index
              end
              return index[keyify(k)]
            end
          end
        end)()
      )
    end
    local impl = data.impl[apicfg.name]
    return function(...)
      local t = {}
      for _, v in ipairs(args) do
        table.insert(t, v)
      end
      local n = select('#', ...)
      for i = 1, n do
        local v = select(i, ...)
        if i then
          t[#args + i] = v
        end
      end
      return impl(unpack(t, 1, #args + n))
    end
  else
    error(('invalid status %q on %q'):format(apicfg.status, apicfg.name))
  end
end

local function getFn(api, loader, apicfg, db2s)
  local stub = doGetFn(api, loader, apicfg, db2s)
  return apicfg.outputs == nil and stub
    or function(...)
      return (function(...)
        for idx, out in ipairs(apicfg.outputs) do
          if out.mixin then
            local t = select(idx, ...)
            if t then
              api.env.Mixin(t, api.env[out.mixin])
            end
          end
        end
        return ...
      end)(stub(...))
    end
end

local function resolveUnit(units, unit)
  -- TODO complete unit resolution
  local guid = units.aliases[unit:lower()]
  return guid and units.guids[guid] or nil
end

local function loadFunctions(api, loader)
  local fns = {}
  local db2s = mkdb2s(loader)
  local aliases = {}
  for fn, apicfg in pairs(loadApis(loader.product)) do
    if apicfg.alias then
      aliases[fn] = apicfg.alias
    elseif apicfg.stdlib then
      util.tset(fns, fn, util.tget(_G, apicfg.stdlib))
    else
      local bfn = getFn(api, loader, apicfg, db2s)
      local function doCheckInputs(sig, ...)
        local args = {}
        for i, param in ipairs(sig) do
          local arg = select(i, ...)
          if arg == nil then
            assert(
              param.nilable or param.default ~= nil,
              ('arg %d (%q) of %q is not nilable, but nil was passed'):format(i, tostring(param.name), fn)
            )
          else
            local ty = type(arg)
            -- Simulate C lua_tonumber and lua_tostring.
            if param.type == 'number' and ty == 'string' then
              arg = tonumber(arg) or arg
              ty = type(arg)
            elseif param.type == 'string' and ty == 'number' then
              arg = tostring(arg) or arg
              ty = type(arg)
            elseif param.type == 'unknown' or data.structures[param.type] ~= nil then
              ty = param.type
            elseif param.type == 'unit' and ty == 'string' then
              arg = resolveUnit(api.states.Units, arg)
              ty = 'unit'
            end
            assert(
              ty == param.type,
              ('arg %d (%q) of %q is of type %q, but %q was passed'):format(i, tostring(param.name), fn, param.type, ty)
            )
            args[i] = arg
          end
        end
        return unpack(args, 1, select('#', ...))
      end
      local checkInputs = (function()
        if not apicfg.inputs then
          return function(...)
            return ...
          end
        elseif #apicfg.inputs == 1 then
          return function(...)
            return doCheckInputs(apicfg.inputs[1], ...)
          end
        else
          return function(...)
            local t = { ... }
            local n = select('#', ...)
            for _, sig in ipairs(apicfg.inputs) do
              local result = {
                pcall(function()
                  return doCheckInputs(sig, unpack(t, 1, n))
                end),
              }
              if result[1] then
                return unpack(result, 2)
              end
            end
            error('args matched no input signature of ' .. fn)
          end
        end
      end)()
      local checkOutputs = (function()
        if not apicfg.outputs then
          return function(...)
            return ...
          end
        else
          local nilableTypes = {
            ['nil'] = true,
            oneornil = true,
            unknown = true,
          }
          local supportedTypes = {
            boolean = true,
            number = true,
            string = true,
          }
          return function(...)
            for i, out in ipairs(apicfg.outputs) do
              local arg = select(i, ...)
              if arg == nil then
                assert(
                  out.nilable or nilableTypes[out.type],
                  ('output %d (%q) of %q is not nilable, but nil was returned'):format(i, tostring(out.name), fn)
                )
              elseif supportedTypes[out.type] then
                local ty = type(arg)
                assert(
                  ty == out.type,
                  ('output %d (%q) of %q is of type %q, but %q was returned'):format(
                    i,
                    tostring(out.name),
                    fn,
                    out.type,
                    ty
                  )
                )
              end
            end
            return ...
          end
        end
      end)()
      local function wrapimpl(...)
        api.log(4, 'entering %s', apicfg.name)
        local t = { ... }
        local n = select('#', ...)
        return (function(success, ...)
          api.log(4, 'leaving %s (%s)', apicfg.name, success and 'success' or 'failure')
          if success then
            return ...
          else
            error((...), 3)
          end
        end)(pcall(function()
          return checkOutputs(bfn(checkInputs(unpack(t, 1, n))))
        end))
      end

      local outer
      if apicfg.nowrap then
        outer = function(...)
          return wrapimpl(...)
        end
      else
        outer = debug.newcfunction(wrapimpl)
      end
      util.tset(fns, fn, outer)
    end
  end
  for k, v in pairs(aliases) do
    fns[k] = util.tget(fns, v)
  end
  return fns
end

return {
  loadFunctions = loadFunctions,
}
