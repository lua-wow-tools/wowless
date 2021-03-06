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

local function mapify(t)
  if t then
    local tt = {}
    for _, p in ipairs(t) do
      tt[p] = true
    end
    return tt
  end
end

local function stylua(s)
  local fn = os.tmpname()
  require('pl.file').write(fn, s)
  os.execute('stylua ' .. fn)
  local ret = require('pl.file').read(fn)
  os.remove(fn)
  return ret
end

local tablemap = {
  builds = function()
    local t = require('wowapi.yaml').parseFile('data/builds.yaml')
    return 'Builds', t
  end,
  cvars = function()
    local t = require('wowapi.yaml').parseFile('data/cvars.yaml')
    return 'CVars', t
  end,
  globalapis = function()
    local t = {}
    for k, v in pairs(apis) do
      if not k:find('%.') then
        local vv = {
          alias = v.alias,
          nowrap = v.nowrap,
          products = mapify(v.products),
          secureCapsule = unavailableApis[k] and true,
          stdlib = v.stdlib,
        }
        t[k] = next(vv) and vv or true
      end
    end
    return 'GlobalApis', t
  end,
  namespaceapis = function()
    local t = {}
    for k, v in sorted(apiNamespaces) do
      local mt = {}
      for mk, mv in pairs(v.methods) do
        local tt = {
          products = mapify(mv.products),
          stdlib = mv.stdlib,
        }
        mt[mk] = next(tt) and tt or true
      end
      t[k] = {
        methods = mt,
        products = mapify(v.products),
      }
    end
    return 'NamespaceApis', t
  end,
  uiobjectapis = function()
    local t = {}
    for k, v in pairs(uiobjects) do
      local mt = {}
      for mk, mv in pairs(v.methods) do
        local tt = {
          products = mv.products and (not v.products or #mv.products < #v.products) and mapify(mv.products) or nil,
        }
        mt[mk] = next(tt) and tt or true
      end
      t[k] = {
        frametype = not not frametypes[k],
        methods = mt,
        objtype = objTypes[k],
        products = mapify(v.products),
      }
    end
    return 'UIObjectApis', t
  end,
}

for _, p in ipairs(require('wowless.util').productList()) do
  tablemap['global_' .. p] = function()
    local cfg = require('wowapi.yaml').parseFile('data/globals/' .. p .. '.yaml')
    return 'Globals_' .. p, cfg
  end
end

local filemap = (function()
  local t = {}
  for k, v in pairs(tablemap) do
    local nn, tt = v()
    local ss = 'local _, G = ...\nG.' .. nn .. ' = ' .. require('pl.pretty').write(tt) .. '\n'
    -- workaround tainted-lua issue with formatting %d
    ss = ss:gsub('DeprecatedCurrencyFlag = [-0-9]+', 'DeprecatedCurrencyFlag = 2147483648')
    t['addon/Wowless/' .. k .. '.lua'] = stylua(ss)
  end
  return t
end)()

-- Hack so test doesn't have side effects.
if select('#', ...) == 0 then
  local w = require('pl.file').write
  for k, v in pairs(filemap) do
    w(k, v)
  end
else
  return filemap
end
