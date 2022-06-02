local addonName, G = ...
local assertEquals = _G.assertEquals

local syncTests = {
  {
    name = 'button text',
    fn = function()
      local f = CreateFrame('Button')
      assert(f:GetNumRegions() == 0)
      assert(f:GetFontString() == nil)
      f:SetText('Moo')
      assert(f:GetNumRegions() == 1)
      local fs = f:GetFontString()
      assert(fs ~= nil)
      assert(f:GetRegions() == fs)
      assert(fs:GetParent() == f)
      assert(f:GetText() == 'Moo')
      assert(fs:GetText() == 'Moo')
      local g = CreateFrame('Button')
      assert(g:GetText() == nil)
      g:SetFontString(fs)
      assert(g:GetText() == 'Moo')
      assert(g:GetRegions() == fs)
      assert(fs:GetParent() == g)
      assert(f:GetText() == nil)
      assert(f:GetNumRegions() == 0)
      fs:SetParent(f)
      assert(fs:GetParent() == f)
      assert(f:GetNumRegions() == 1)
      assert(f:GetText() == nil)
      assert(f:GetFontString() == nil)
      assert(g:GetNumRegions() == 0)
      assert(g:GetText() == nil)
      assert(g:GetFontString() == nil)
    end,
  },
  {
    name = 'frame kid order',
    fn = function()
      local f = CreateFrame('Frame')
      local g = CreateFrame('Frame')
      local h = CreateFrame('Frame')
      g:SetParent(f)
      h:SetParent(f)
      assert(f:GetNumChildren() == 2)
      assert(select(1, f:GetChildren()) == g)
      assert(select(2, f:GetChildren()) == h)
      g:SetParent(f)
      assert(select(1, f:GetChildren()) == g)
      assert(select(2, f:GetChildren()) == h)
    end,
  },
  {
    name = 'frame three kids order',
    fn = function()
      local f = CreateFrame('Frame')
      local g = CreateFrame('Frame', nil, f)
      local h = CreateFrame('Frame', nil, f)
      local i = CreateFrame('Frame', nil, f)
      assert(f:GetNumChildren() == 3)
      assert(select(1, f:GetChildren()) == g)
      assert(select(2, f:GetChildren()) == h)
      assert(select(3, f:GetChildren()) == i)
      h:SetParent(nil)
      assert(f:GetNumChildren() == 2)
      assert(select(1, f:GetChildren()) == g)
      assert(select(2, f:GetChildren()) == i)
      h:SetParent(f)
      assert(f:GetNumChildren() == 3)
      assert(select(1, f:GetChildren()) == g)
      assert(select(2, f:GetChildren()) == i)
      assert(select(3, f:GetChildren()) == h)
    end,
  },
  {
    name = 'format missing numbers',
    fn = function()
      assertEquals('0', format('%d'))
    end,
  },
  {
    name = 'format nil numbers',
    fn = function()
      assertEquals('0', format('%d', nil))
    end,
  },
  {
    name = 'does not format missing strings',
    fn = function()
      assert(not pcall(function()
        format('%s')
      end))
    end,
  },
  {
    name = 'does not format nil strings',
    fn = function()
      assert(not pcall(function()
        format('%s', nil)
      end))
    end,
  },
  {
    name = 'format handles indexed substitution',
    fn = function()
      assertEquals(' 7   moo', format('%2$2d %1$5s', 'moo', 7))
    end,
  },
  {
    name = 'format handles up to index 99 substitution',
    fn = function()
      local t = {}
      for i = 1, 100 do
        t[i] = i
      end
      for i = 1, 99 do
        assertEquals(tostring(i), format('%' .. i .. '$d', unpack(t)))
      end
      assert(not pcall(function()
        format('%100$d', unpack(t))
      end))
    end,
  },
  {
    name = 'visible updated on kids before calling any OnShow',
    fn = function()
      local p = CreateFrame('Frame')
      local k1 = CreateFrame('Frame', nil, p)
      local k2 = CreateFrame('Frame', nil, p)
      local log = {}
      local function h(name)
        return function()
          table.insert(
            log,
            table.concat({
              name,
              tostring(p:IsShown()),
              tostring(p:IsVisible()),
              tostring(k1:IsShown()),
              tostring(k1:IsVisible()),
              tostring(k2:IsShown()),
              tostring(k2:IsVisible()),
            }, ',')
          )
        end
      end
      p:SetScript('OnShow', h('parent'))
      k1:SetScript('OnShow', h('kid 1'))
      k2:SetScript('OnShow', h('kid 2'))
      p:Hide()
      p:Show()
      local expected = table.concat({
        'kid 1' .. (',true'):rep(6),
        'kid 2' .. (',true'):rep(6),
        'parent' .. (',true'):rep(6),
      }, '\n')
      assertEquals(expected, table.concat(log, '\n'))
    end,
  },
  {
    name = 'visible updated on kids before OnShow across three parent-kids',
    fn = function()
      local p = CreateFrame('Frame')
      local m = CreateFrame('Frame', nil, p)
      local k = CreateFrame('Frame', nil, m)
      local log = {}
      local function h(name)
        return function()
          table.insert(
            log,
            table.concat({
              name,
              tostring(p:IsShown()),
              tostring(p:IsVisible()),
              tostring(m:IsShown()),
              tostring(m:IsVisible()),
              tostring(k:IsShown()),
              tostring(k:IsVisible()),
            }, ',')
          )
        end
      end
      p:SetScript('OnShow', h('parent'))
      m:SetScript('OnShow', h('middle'))
      k:SetScript('OnShow', h('kid'))
      p:Hide()
      p:Show()
      local expected = table.concat({
        'kid' .. (',true'):rep(6),
        'middle' .. (',true'):rep(6),
        'parent' .. (',true'):rep(6),
      }, '\n')
      assertEquals(expected, table.concat(log, '\n'))
    end,
  },
  {
    name = 'ScrollFrame:SetScrollChild',
    fn = function()
      local f = CreateFrame('ScrollFrame')
      assertEquals(nil, f:GetScrollChild())
      local g = CreateFrame('Frame', 'WowlessScrollFrameChild')
      f:SetScrollChild(g)
      assertEquals(g, f:GetScrollChild())
      f:SetScrollChild(nil)
      assertEquals(nil, f:GetScrollChild())
      f:SetScrollChild('WowlessScrollFrameChild')
      assertEquals(g, f:GetScrollChild())
      assertEquals(
        false,
        pcall(function()
          f:SetScrollChild()
        end)
      )
    end,
  },
  {
    name = 'version',
    fn = function()
      local id = _G.WOW_PROJECT_ID
      if id == 1 then
        assertEquals(id, _G.WOW_PROJECT_MAINLINE)
      elseif id == 2 then
        assertEquals(id, _G.WOW_PROJECT_CLASSIC)
      elseif id == 5 then
        assertEquals(id, _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
      else
        error('invalid WOW_PROJECT_ID')
      end
    end,
  },
}

local asyncTests = {
  {
    name = 'event registration and dispatch order',
    fn = function(done)
      local event = 'CHAT_MSG_SYSTEM'
      local msg = 'event registration and dispatch order'
      local log = {}
      local pending = 0
      local function mkframe(name)
        local f = CreateFrame('Frame')
        pending = pending + 1
        local logged = false
        f:SetScript('OnEvent', function(_, ev, m)
          if not logged and ev == event and m == msg then
            table.insert(log, name)
            logged = true
            pending = pending - 1
            f:UnregisterAllEvents()
            if pending == 0 then
              done(function()
                local t1 = 't32,t2,t24,t4,t30,t6,t18,t8,t28,t10,t22,t12,t26,t14,t20,t16'
                local t2 = 't1,t5,t9,t13,t17,t21,t25,t29,t3,t7,t11,t15,t19,t23,t27,t31'
                local a1 = 'a32,a2,a24,a4,a30,a6,a18,a8,a28,a10,a22,a12,a26,a14,a20,a16'
                local a2 = 'a1,a5,a9,a13,a17,a21,a25,a29,a3,a7,a11,a15,a19,a23,a27,a31'
                assertEquals(table.concat({ t1, t2, a1, a2 }, ','), table.concat(log, ','))
              end)
            end
          end
        end)
        return f
      end
      local t, a = {}, {}
      for i = 1, 32 do
        table.insert(a, mkframe('a' .. i))
        table.insert(t, mkframe('t' .. i))
      end
      for _, f in ipairs(t) do
        f:RegisterEvent(event)
      end
      for _, f in ipairs(a) do
        f:RegisterAllEvents()
      end
      for i = 1, 32, 2 do
        t[i]:UnregisterEvent(event)
        a[i]:UnregisterAllEvents()
      end
      for i = 1, 32, 4 do
        t[i]:RegisterEvent(event)
        a[i]:RegisterAllEvents()
      end
      for i = 3, 32, 4 do
        t[i]:RegisterEvent(event)
        a[i]:RegisterAllEvents()
      end
      assertEquals(0, #log)
      SendSystemMessage(msg)
    end,
  },
  {
    name = 'individual event reg before all',
    fn = function(done)
      local event = 'CHAT_MSG_SYSTEM'
      local msg = 'individual event reg before all'
      local log = {}
      local pending = 0
      local function mkframe(name)
        local f = CreateFrame('Frame')
        pending = pending + 1
        local logged = false
        f:SetScript('OnEvent', function(_, ev, m)
          if not logged and ev == event and m == msg then
            table.insert(log, name)
            logged = true
            pending = pending - 1
            f:UnregisterAllEvents()
            if pending == 0 then
              done(function()
                assertEquals('t1,t2,a1,a2', table.concat(log, ','))
              end)
            end
          end
        end)
        return f
      end
      mkframe('t1'):RegisterEvent(event)
      mkframe('a1'):RegisterAllEvents()
      mkframe('a2'):RegisterAllEvents()
      mkframe('t2'):RegisterEvent(event)
      SendSystemMessage(msg)
    end,
  },
}

_G.WowlessTestFailures = {}
_G.WowlessTestsDone = false

do
  local function checkSafely(name, fn)
    local success, msg = pcall(fn)
    if not success then
      _G.WowlessTestFailures[name] = msg
    end
  end
  local syncIndex, numSyncTests = 0, #syncTests
  local asyncIndex, numAsyncTests, asyncPending = 0, #asyncTests, false
  local totalTime, numFrames = 0, 0
  CreateFrame('Frame'):SetScript('OnUpdate', function(frame, elapsed)
    local t = debugprofilestop()
    totalTime = totalTime + elapsed
    numFrames = numFrames + 1
    while debugprofilestop() - t < elapsed / 2 and syncIndex < numSyncTests do
      syncIndex = syncIndex + 1
      local test = syncTests[syncIndex]
      checkSafely(test.name, test.fn)
    end
    if syncIndex == numSyncTests and not asyncPending then
      if asyncIndex == numAsyncTests then
        frame:SetScript('OnUpdate', nil)
        _G.WowlessTestsDone = true
        local print = DevTools_Dump and print or function() end
        print(('Wowless testing completed in %.1fs (%d frames).'):format(totalTime, numFrames))
        print(('Ran %d sync and %d async tests.'):format(numSyncTests, numAsyncTests))
        if G.GeneratedTestFailures then
          _G.WowlessTestFailures.generated = G.GeneratedTestFailures
        end
        if not next(_G.WowlessTestFailures) then
          print('No errors.')
        else
          print('There were errors.')
          if DevTools_Dump then
            DevTools_Dump(_G.WowlessTestFailures)
          end
        end
      else
        asyncIndex = asyncIndex + 1
        asyncPending = true
        local test = asyncTests[asyncIndex]
        test.fn(function(check)
          asyncPending = false
          checkSafely(test.name, check)
        end)
      end
    end
  end)
end

do
  local saver = CreateFrame('Frame')
  saver:RegisterEvent('ADDON_LOADED')
  saver:SetScript('OnEvent', function(_, _, name)
    if name == addonName then
      _G.WowlessLastTestFailures = _G.WowlessTestFailures
    end
  end)
end
