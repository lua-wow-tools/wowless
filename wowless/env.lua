local bitlib = require('bit')
local extformat = require('wowless.ext').format
local utf8 = require('lua-utf8')
local util = require('wowless.util')
local Mixin = util.mixin

local function mkBaseEnv()
  return {
    abs = math.abs,
    assert = assert,
    bit = {
      band = bitlib.band,
      bnot = bitlib.bnot,
      bor = bitlib.bor,
      bxor = bitlib.bxor,
      lshift = bitlib.lshift,
      rshift = bitlib.rshift,
    },
    ceil = math.ceil,
    collectgarbage = collectgarbage,
    coroutine = {
      create = coroutine.create,
      resume = coroutine.resume,
      running = coroutine.running,
      status = coroutine.status,
      yield = coroutine.yield,
    },
    cos = math.cos,
    date = os.date,
    debugstack = debug.traceback,
    difftime = os.difftime,
    error = error,
    floor = math.floor,
    forceinsecure = forceinsecure,
    format = extformat,
    getmetatable = getmetatable,
    getn = table.getn,
    gmatch = string.gmatch,
    gsub = string.gsub,
    ipairs = ipairs,
    issecure = issecure,
    issecurevariable = issecurevariable,
    math = {
      abs = math.abs,
      ceil = math.ceil,
      cos = math.cos,
      floor = math.floor,
      fmod = math.fmod,
      huge = math.huge,
      log = math.log,
      max = math.max,
      min = math.min,
      modf = math.modf,
      pi = math.pi,
      pow = math.pow,
      rad = math.rad,
      random = math.random,
      sin = math.sin,
      sqrt = math.sqrt,
    },
    max = math.max,
    min = math.min,
    mod = math.fmod,
    newproxy = newproxy,
    next = next,
    pairs = pairs,
    pcall = pcall,
    PI = math.pi,
    print = print,
    rad = math.rad,
    random = math.random,
    rawget = rawget,
    rawset = rawset,
    scrub = scrub,
    select = select,
    setfenv = setfenv,
    setmetatable = setmetatable,
    sin = math.sin,
    sort = table.sort,
    strfind = string.find,
    string = {
      byte = string.byte,
      char = string.char,
      find = string.find,
      format = extformat,
      gmatch = string.gmatch,
      gsub = string.gsub,
      join = util.strjoin,
      len = string.len,
      lower = string.lower,
      match = string.match,
      rep = string.rep,
      split = util.strsplit,
      sub = string.sub,
      trim = util.strtrim,
      upper = string.upper,
    },
    strbyte = string.byte,
    strcmputf8i = utf8.ncasecmp,
    strjoin = util.strjoin,
    strlen = string.len,
    strlenutf8 = utf8.len,
    strlower = string.lower,
    strmatch = string.match,
    strrep = string.rep,
    strsplit = util.strsplit,
    strsub = string.sub,
    strtrim = util.strtrim,
    strupper = string.upper,
    table = {
      concat = table.concat,
      foreach = function(t, fn)
        for i, v in ipairs(t) do
          fn(i, v)
        end
      end,
      getn = table.getn,
      insert = table.insert,
      remove = table.remove,
      sort = table.sort,
      wipe = util.twipe,
    },
    time = os.time,
    tinsert = table.insert,
    tonumber = tonumber,
    tostring = tostring,
    tremove = table.remove,
    type = type,
    unpack = unpack,
    wipe = util.twipe,
  }
end

local function dump(api)
  local block = require('serpent').block
  local config = { nocode = true }
  local function d(x)
    print(block(x, config))
  end
  return function(...)
    for _, x in ipairs({ ... }) do
      d(x)
      if api.UserData(x) then
        print('===[begin userdata]===')
        d(api.UserData(x))
        print('===[ end userdata ]===')
      end
    end
  end
end

local securecall = securecall
local type = type

local function wrapAll(t)
  for k, v in pairs(t) do
    local ty = type(v)
    if v == setfenv then
      t[k] = function(arg, ...)
        return securecall(v, type(arg) == 'number' and arg + 2 or arg, ...)
      end
    elseif ty == 'function' and v ~= securecall then
      t[k] = function(...)
        return securecall(v, ...)
      end
    elseif ty == 'table' then
      wrapAll(v)
    end
  end
end

local function init(api, loader)
  api.env.__dump = dump(api)
  Mixin(api.env, mkBaseEnv())
  util.recursiveMixin(api.env, require('wowapi.loader').loadFunctions(api, loader))
  Mixin(api.uiobjectTypes, require('wowapi.uiobjects')(api))
  wrapAll(api.env)
  api.env._G = api.env
end

return {
  init = init,
}
