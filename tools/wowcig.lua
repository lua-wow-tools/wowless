local args = (function()
  local parser = require('argparse')()
  parser:option('-p --product', 'products to fetch, default all'):count('*')
  return parser:parse()
end)()
local products = next(args.product) and args.product or require('wowless.util').productList()
for _, p in ipairs(products) do
  require('pl.file').delete('extracts/' .. p)
  local cmdline = { 'wowcig', '-v', '-p', p }
  for _, db in ipairs(require('tools.dblist')(p)) do
    table.insert(cmdline, '-d')
    table.insert(cmdline, db)
  end
  os.execute(table.concat(cmdline, ' '))
end
