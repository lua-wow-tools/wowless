describe('addon #small', function()
  pending('writes a log on PLAYER_LOGOUT', function()
    local log = function(_, ...)
      print(string.format(...))
    end
    local api = require('wowless.api').new(log)
    require('wowless.env').init(api)
    local loader = require('wowless.loader').loader(api)
    loader.loadToc('addon/Wowless/Wowless.toc')
    api.SendEvent('PLAYER_LOGIN')
    api.SendEvent('PLAYER_LOGOUT')
    local expected = {
      'OnLoad(WowlessSimpleFrame,none)',
      'OnShow(WowlessSimpleFrame,none)',
      'OnLoad(WowlessAttributeFrame,none)',
      'OnShow(WowlessAttributeFrame,none)',
      'OnLoad(WowlessHiddenFrame,none)',
      'OnLoad(WowlessParentKid2,WowlessParent)',
      'OnShow(WowlessParentKid2,WowlessParent)',
      'OnLoad(WowlessParentKid1,WowlessParent)',
      'OnShow(WowlessParentKid1,WowlessParent)',
      'OnLoad(WowlessParent,none)',
      'OnShow(WowlessParent,none)',
      'OnLoad(WowlessKeyParent,none)',
      'OnShow(WowlessKeyParent,none)',
      'OnLoad(WowlessKeyParentKid1,WowlessKeyParent)',
      'OnShow(WowlessKeyParentKid1,WowlessKeyParent)',
      'OnLoad(WowlessKeyParentKid2,WowlessKeyParent)',
      'OnShow(WowlessKeyParentKid2,WowlessKeyParent)',
      'before WowlessLuaFrame',
      'OnLoad(WowlessLuaFrame,none)',
      'OnShow(WowlessLuaFrame,none)',
      'after WowlessLuaFrame',
    }
    assert.same(expected, api.env.WowlessLog)
  end)
end)