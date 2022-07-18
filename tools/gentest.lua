local sorted = require('pl.tablex').sort

local apis = {}
local uiobjects = {}
do
  local lfs = require('lfs')
  local yaml = require('wowapi.yaml')
  for d in lfs.dir('data/api') do
    if d ~= '.' and d ~= '..' then
      local filename = ('data/api/%s'):format(d)
      local cfg = yaml.parseFile(filename)
      if not cfg.debug then
        apis[cfg.name] = cfg
      end
    end
  end
  for d in lfs.dir('data/uiobjects') do
    if d ~= '.' and d ~= '..' then
      local filename = ('data/uiobjects/%s/%s.yaml'):format(d, d)
      local cfg = yaml.parseFile(filename)
      uiobjects[cfg.name] = cfg
    end
  end
end

local inhrev = {}
for _, cfg in pairs(uiobjects) do
  for _, inh in ipairs(cfg.inherits) do
    inhrev[inh] = inhrev[inh] or {}
    table.insert(inhrev[inh], cfg.name)
  end
end

local unavailableApis = {
  CreateForbiddenFrame = true,
  loadstring_untainted = true,
}

local objTypes = {}
for _, cfg in pairs(uiobjects) do
  objTypes[cfg.name] = cfg.objectType or cfg.name
end

do
  local function fixup(cfg)
    for _, inhname in ipairs(cfg.inherits) do
      local inh = uiobjects[inhname]
      fixup(inh)
      for n, m in pairs(inh.methods) do
        cfg.methods[n] = m
      end
    end
  end
  for _, cfg in pairs(uiobjects) do
    fixup(cfg)
  end
end

local frametypes = {}
do
  local function addtype(ty)
    if not frametypes[ty] then
      frametypes[ty] = true
      for _, inh in ipairs(inhrev[ty] or {}) do
        addtype(inh)
      end
    end
  end
  addtype('Frame')
end

local apiNamespaces = {}
do
  for k, v in pairs(apis) do
    local p = k:find('%.')
    if p then
      local name = k:sub(1, p - 1)
      apiNamespaces[name] = apiNamespaces[name] or { methods = {} }
      apiNamespaces[name].methods[k:sub(p + 1)] = v
    end
  end
  for _, v in pairs(apiNamespaces) do
    local allProducts = require('wowless.util').productList()
    local products = {}
    for _, m in pairs(v.methods) do
      for _, product in ipairs(m.products or allProducts) do
        products[product] = true
      end
    end
    local plist = {}
    for f in pairs(products) do
      table.insert(plist, f)
    end
    assert(next(plist))
    v.products = #plist ~= #allProducts and plist or nil
    for _, m in pairs(v.methods) do
      if m.products and #m.products == #plist then
        m.products = nil
      end
    end
  end
  local unavailable = {
    -- These are grabbed by FrameXML and are unavailable by the time addons run.
    'C_AuthChallenge',
    'C_SecureTransfer',
    'C_StoreSecure',
    'C_WowTokenSecure',
    -- This is documented but does not actually seem to exist.
    'C_ConfigurationWarnings',
  }
  for _, k in ipairs(unavailable) do
    assert(apiNamespaces[k])
    apiNamespaces[k] = nil
  end
end

-- TODO figure out the right approach for these
uiobjects.Minimap = nil
uiobjects.WorldFrame = nil

local cvars = (function()
  local t = {}
  table.insert(t, 'local _, G = ...')
  table.insert(t, 'G.CVars = {')
  for k, v in sorted((require('wowapi.yaml').parseFile('data/cvars.yaml'))) do
    if type(v) == 'string' then
      table.insert(t, '  [\'' .. k .. '\'] = \'' .. v .. '\',')
    else
      table.insert(t, '  [\'' .. k .. '\'] = {')
      for pk, pv in sorted(v) do
        table.insert(t, '    ' .. pk .. ' = \'' .. pv .. '\',')
      end
      table.insert(t, '  },')
    end
  end
  table.insert(t, '}')
  table.insert(t, '')
  return table.concat(t, '\n')
end)()

local globalApis = (function()
  local t = {}
  table.insert(t, 'local _, G = ...')
  table.insert(t, 'G.GlobalApis = {')
  for k, v in sorted(apis) do
    if not k:find('%.') then
      table.insert(t, '') -- to be filled in later
      local idx = #t
      if v.alias then
        table.insert(t, '    alias = { _G.' .. v.alias .. ' },')
      end
      if v.nowrap then
        table.insert(t, '    nowrap = true,')
      end
      if v.products then
        table.sort(v.products)
        table.insert(t, '    products = {')
        for _, p in ipairs(v.products) do
          table.insert(t, '      ' .. p .. ' = true,')
        end
        table.insert(t, '    },')
      end
      if unavailableApis[k] then
        table.insert(t, '    secureCapsule = true,')
      end
      if v.stdlib then
        table.insert(t, '    stdlib = { _G.' .. v.stdlib .. ' },')
      end
      if t[idx + 1] then
        t[idx] = '  ' .. k .. ' = {'
        table.insert(t, '  },')
      else
        t[idx] = '  ' .. k .. ' = true,'
      end
    end
  end
  table.insert(t, '}')
  table.insert(t, '')
  return table.concat(t, '\n')
end)()

local namespaceApis = (function()
  local t = {}
  table.insert(t, 'local _, G = ...')
  table.insert(t, 'G.NamespaceApis = {')
  for k, v in sorted(apiNamespaces) do
    table.insert(t, '  ' .. k .. ' = {')
    table.insert(t, '    methods = {')
    for mk, mv in sorted(v.methods) do
      table.insert(t, '') -- to be filled in later
      local idx = #t
      if mv.products then
        table.sort(mv.products)
        table.insert(t, '        products = {')
        for _, p in ipairs(mv.products) do
          table.insert(t, '          ' .. p .. ' = true,')
        end
        table.insert(t, '        },')
      end
      if mv.stdlib then
        table.insert(t, '        stdlib = { _G.' .. mv.stdlib .. ' },')
      end
      if t[idx + 1] then
        t[idx] = '      ' .. mk .. ' = {'
        table.insert(t, '      },')
      else
        t[idx] = '      ' .. mk .. ' = true,'
      end
    end
    table.insert(t, '    },')
    if v.products then
      table.sort(v.products)
      table.insert(t, '    products = {')
      for _, p in ipairs(v.products) do
        table.insert(t, '      ' .. p .. ' = true,')
      end
      table.insert(t, '    },')
    end
    table.insert(t, '  },')
  end
  table.insert(t, '}')
  table.insert(t, '')
  return table.concat(t, '\n')
end)()

local uiobjectApis = (function()
  local t = {}
  table.insert(t, 'local _, G = ...')
  table.insert(t, 'G.UIObjectApis = {')
  for k, v in sorted(uiobjects) do
    table.insert(t, '  ' .. k .. ' = {')
    table.insert(t, '    frametype = ' .. tostring(not not frametypes[k]) .. ',')
    table.insert(t, '    methods = {')
    for mk, mv in sorted(v.methods) do
      table.insert(t, '') -- to be filled in later
      local idx = #t
      if mv.products and (not v.products or #mv.products < #v.products) then
        table.sort(mv.products)
        table.insert(t, '        products = {')
        for _, p in ipairs(mv.products) do
          table.insert(t, '          ' .. p .. ' = true,')
        end
        table.insert(t, '        },')
      end
      if t[idx + 1] then
        t[idx] = '      ' .. mk .. ' = {'
        table.insert(t, '      },')
      else
        t[idx] = '      ' .. mk .. ' = true,'
      end
    end
    table.insert(t, '    },')
    table.insert(t, '    objtype = \'' .. objTypes[k] .. '\',')
    if v.products then
      table.sort(v.products)
      table.insert(t, '    products = {')
      for _, p in ipairs(v.products) do
        table.insert(t, '      ' .. p .. ' = true,')
      end
      table.insert(t, '    },')
    end
    table.insert(t, '  },')
  end
  table.insert(t, '}')
  table.insert(t, '')
  return table.concat(t, '\n')
end)()

local filemap = {
  ['addon/Wowless/cvars.lua'] = cvars,
  ['addon/Wowless/globalapis.lua'] = globalApis,
  ['addon/Wowless/namespaceapis.lua'] = namespaceApis,
  ['addon/Wowless/uiobjectapis.lua'] = uiobjectApis,
}

-- Hack so test doesn't have side effects.
if select('#', ...) == 0 then
  local w = require('pl.file').write
  for k, v in pairs(filemap) do
    w(k, v)
  end
else
  return filemap
end
