describe('runner', function()
  local runner = require('wowless.runner')
  it('loads', function()
    local api = runner.run(0)
    assert.same(82, api.GetErrorCount())
  end)
end)
