local function loader(api, sink)

  local handler = require('xmlhandler.dom')
  local path = require('path')
  local xml2lua = require('xml2lua')

  local function readFile(filename)
    local f = assert(io.open(filename:gsub('\\', '/'), 'rb'))
    local content = f:read('*all')
    f:close()
    if content:sub(1, 3) == '\239\187\191' then
      content = content:sub(4)
    end
    return content
  end

  local function loadLuaString(filename, str)
    sink(filename, assert(loadstring(str)))
  end

  local loadXml

  local function loadFile(filename)
    if filename:sub(-4) == '.lua' then
      loadLuaString(filename, readFile(filename))
    elseif filename:sub(-4) == '.xml' then
      return loadXml(filename)
    else
      error('unknown file type ' .. filename)
    end
  end

  -- TODO enable xml
  local enableXml = arg[1] == 'xml'

  function loadXml(filename)
    local dir = path.dirname(filename)
    local h = handler:new()
    h.options.commentNode = false
    xml2lua.parser(h):parse(readFile(filename))
    assert(h.root._name == 'Ui')
    for _, v in ipairs(h.root._children) do
      assert(v._type == 'ELEMENT')
      if v._name == 'Include' then
        assert(v._attr and v._attr.file and #v._children == 0)
        loadFile(path.join(dir, v._attr.file))
      elseif v._name == 'Frame' then
        api.CreateFrame({
          name = v._attr.name,
        })
      elseif not enableXml then
        print('skipping ' .. filename .. ' ' .. v._name)
      elseif v._name == 'Script' then
        if v._attr and v._attr.file then
          assert(#v._children == 0)
          loadFile(path.join(dir, v._attr.file))
        elseif v._children then
          for _, x in ipairs(v._children) do
            if x._type == 'TEXT' then
              loadLuaString(filename, x._text)
            end
          end
        else
          error('invalid script tag')
        end
      end
    end
  end

  local function loadToc(toc)
    local dir = path.dirname(toc)
    for line in io.lines(toc) do
      line = line:match('^%s*(.-)%s*$')
      if line ~= '' and line:sub(1, 1) ~= '#' then
        loadFile(path.join(dir, line))
      end
    end
  end

  return loadToc
end

local env = (function()
  local bitlib = require('bit')
  return setmetatable({
    bit = {
      bor = bitlib.bor,
    },
    getfenv = getfenv,
    getmetatable = getmetatable,
    ipairs = ipairs,
    math = {},
    pairs = pairs,
    rawget = rawget,
    select = select,
    setmetatable = setmetatable,
    string = {
      format = string.format,
      gsub = string.gsub,
      match = string.match,
      sub = string.sub,
      upper = string.upper,
    },
    table = {
      insert = table.insert,
    },
    tostring = tostring,
    type = type,
  }, {
    __index = function(t, k)
      if k == '_G' then
        return t
      elseif string.sub(k, 1, 3) == 'LE_' then
        return 'AUTOGENERATED:' .. k
      end
    end
  })
end)()

do
  local api = setfenv(loadfile('env.lua'), env)()
  local sink = function(filename, lua)
    local success, err = pcall(setfenv(lua, env))
    if not success then
      error('failure loading ' .. filename .. ': ' .. err)
    end
  end
  local toc = require('datafile').path('wowui/classic/FrameXML/FrameXML.toc')
  loader(api, sink)(toc)
end

for k, v in pairs(env) do
  print(k .. ' = ' .. tostring(v))
end
