describe('blp', function()
  it('reads', function()
    local w, h, rgba = require('wowless.blp').read('spec/wowless/temp.blp')
    assert.same(w, 64)
    assert.same(h, 64)
    assert.same(require('pl.file').read('spec/wowless/temp.png'), require('wowless.png').write(w, h, rgba))
  end)
end)
