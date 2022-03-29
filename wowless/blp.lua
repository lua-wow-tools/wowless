local vstruct = require('vstruct')
local zlib = require('zlib')

local blpHeader = vstruct.compile([[
  magic: s4  -- BLP2
  version: u4  -- 1
  colorEncoding: u1
  alphaSize: u1
  pixelFormat: u1
  hasMips: u1
  width: u4
  height: u4
  mipOffsets: { 16*u4 }
  mipSizes: { 16*u4 }
  palette: { 256*u4 }
]])

local dxt5 = vstruct.compile([[
  a0: u1
  a1: u1
  alphaTable: { [ 6 | 16*u3 ] }
  c0: u2
  c1: u2
  colorTable: { [ 4 | 16*u2 ] }
]])

local function parseBLP(filename)
  local f = assert(io.open(filename))
  local header = blpHeader:read(f)
  assert(header.magic == 'BLP2')
  assert(header.version == 1)
  assert(header.colorEncoding == 2) -- DXT
  assert(header.alphaSize == 8)
  assert(header.pixelFormat == 7) -- DXT5
  assert(header.hasMips == 17)
  assert(header.width == header.height)
  do
    local cur = 20 + 64 + 64 + 1024 -- header size
    local dim = header.width
    for i = 1, math.log(dim) do
      assert(header.mipOffsets[i] == cur)
      assert(header.mipSizes[i] == dim * dim)
      for _ = 1, dim * dim / 16 do
        require('pl.pretty').dump(dxt5:read(f))
      end
      cur = cur + dim * dim
      dim = dim / 2
    end
  end
  assert(f:close())
end

local function crc32(...)
  local c = zlib.crc32()
  for i = 1, select('#', ...) do
    c = zlib.crc32(c, select(i, ...))
  end
  return c
end

local pngChunks = {
  IDAT = vstruct.compile('s'),
  IEND = vstruct.compile(''),
  IHDR = vstruct.compile([[>
    width: u4
    height: u4
    bitDepth: u1
    colorType: u1
    compressionMethod: u1
    filterMethod: u1
    interlaceMethod: u1
  ]]),
}

local function writePNGChunk(f, type, data)
  local str = pngChunks[type]:write('', data)
  local fmt = ('> u4 s4 s%d u4'):format(#str)
  vstruct.write(fmt, f, { #str, type, str, crc32(type, str) })
end

local function writePNG(filename, width, height, data)
  local f = assert(io.open(filename, 'wb'))
  assert(f:write('\137PNG\r\n\26\n'))
  writePNGChunk(f, 'IHDR', {
    width = width,
    height = height,
    bitDepth = 8,
    colorType = 2,
    compressionMethod = 0,
    filterMethod = 0,
    interlaceMethod = 0,
  })
  local lines = {}
  for i = 1, height do
    table.insert(lines, '\0')
    table.insert(lines, data:sub((i - 1) * width * 3 + 1, i * width * 3))
  end
  writePNGChunk(f, 'IDAT', { zlib.compress(table.concat(lines, '')) })
  writePNGChunk(f, 'IEND', {})
  assert(f:close())
end

parseBLP('temp.blp')
writePNG('temp.png', 100, 100, ('\0\255\0'):rep(10000))
