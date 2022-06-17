local _, G = ...
local assertEquals = _G.assertEquals
function G.GeneratedTests()
  local cfuncs = {}
  local function checkFunc(func, isLua)
    assertEquals('function', type(func))
    return {
      getfenv = function()
        assertEquals(_G, getfenv(func))
      end,
      impltype = function()
        assertEquals(
          isLua,
          pcall(function()
            coroutine.create(func)
          end)
        )
      end,
      unique = not isLua and function()
        assertEquals(nil, cfuncs[func])
        cfuncs[func] = true
      end or nil,
    }
  end
  local function checkCFunc(func)
    return checkFunc(func, false)
  end
  local function checkLuaFunc(func)
    return checkFunc(func, true)
  end
  local function checkNotCFunc(func)
    if func ~= nil and not cfuncs[func] then
      return checkLuaFunc(func)
    end
  end
  return {
    apiNamespaces = function()
      local function mkTests(ns, tests)
        for k, v in pairs(ns) do
          -- Anything left over must be a FrameXML-defined function.
          if not tests[k] then
            tests['~' .. k] = function()
              if not cfuncs[v] then
                return checkLuaFunc(v)
              end
            end
          end
        end
        return tests
      end
      return {
        C_AccountInfo = function()
          local ns = _G.C_AccountInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetIDFromBattleNetAccountGUID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetIDFromBattleNetAccountGUID)
              end
              return checkCFunc(ns.GetIDFromBattleNetAccountGUID)
            end,
            IsGUIDBattleNetAccountType = function()
              return checkCFunc(ns.IsGUIDBattleNetAccountType)
            end,
            IsGUIDRelatedToLocalAccount = function()
              return checkCFunc(ns.IsGUIDRelatedToLocalAccount)
            end,
          })
        end,
        C_AchievementInfo = function()
          local ns = _G.C_AchievementInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetRewardItemID = function()
              return checkCFunc(ns.GetRewardItemID)
            end,
            GetSupercedingAchievements = function()
              return checkCFunc(ns.GetSupercedingAchievements)
            end,
            IsValidAchievement = function()
              return checkCFunc(ns.IsValidAchievement)
            end,
            SetPortraitTexture = function()
              return checkCFunc(ns.SetPortraitTexture)
            end,
          })
        end,
        C_ActionBar = function()
          local ns = _G.C_ActionBar
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            FindFlyoutActionButtons = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.FindFlyoutActionButtons)
              end
              return checkCFunc(ns.FindFlyoutActionButtons)
            end,
            FindPetActionButtons = function()
              return checkCFunc(ns.FindPetActionButtons)
            end,
            FindSpellActionButtons = function()
              return checkCFunc(ns.FindSpellActionButtons)
            end,
            GetBonusBarIndexForSlot = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBonusBarIndexForSlot)
              end
              return checkCFunc(ns.GetBonusBarIndexForSlot)
            end,
            GetPetActionPetBarIndices = function()
              return checkCFunc(ns.GetPetActionPetBarIndices)
            end,
            HasFlyoutActionButtons = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.HasFlyoutActionButtons)
              end
              return checkCFunc(ns.HasFlyoutActionButtons)
            end,
            HasPetActionButtons = function()
              return checkCFunc(ns.HasPetActionButtons)
            end,
            HasPetActionPetBarIndices = function()
              return checkCFunc(ns.HasPetActionPetBarIndices)
            end,
            HasSpellActionButtons = function()
              return checkCFunc(ns.HasSpellActionButtons)
            end,
            IsAutoCastPetAction = function()
              return checkCFunc(ns.IsAutoCastPetAction)
            end,
            IsEnabledAutoCastPetAction = function()
              return checkCFunc(ns.IsEnabledAutoCastPetAction)
            end,
            IsHarmfulAction = function()
              return checkCFunc(ns.IsHarmfulAction)
            end,
            IsHelpfulAction = function()
              return checkCFunc(ns.IsHelpfulAction)
            end,
            IsOnBarOrSpecialBar = function()
              return checkCFunc(ns.IsOnBarOrSpecialBar)
            end,
            PutActionInSlot = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.PutActionInSlot)
              end
              return checkCFunc(ns.PutActionInSlot)
            end,
            ShouldOverrideBarShowHealthBar = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ShouldOverrideBarShowHealthBar)
              end
              return checkCFunc(ns.ShouldOverrideBarShowHealthBar)
            end,
            ShouldOverrideBarShowManaBar = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ShouldOverrideBarShowManaBar)
              end
              return checkCFunc(ns.ShouldOverrideBarShowManaBar)
            end,
            ToggleAutoCastPetAction = function()
              return checkCFunc(ns.ToggleAutoCastPetAction)
            end,
          })
        end,
        C_AdventureJournal = function()
          local ns = _G.C_AdventureJournal
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ActivateEntry = function()
              return checkCFunc(ns.ActivateEntry)
            end,
            CanBeShown = function()
              return checkCFunc(ns.CanBeShown)
            end,
            GetNumAvailableSuggestions = function()
              return checkCFunc(ns.GetNumAvailableSuggestions)
            end,
            GetPrimaryOffset = function()
              return checkCFunc(ns.GetPrimaryOffset)
            end,
            GetReward = function()
              return checkCFunc(ns.GetReward)
            end,
            GetSuggestions = function()
              return checkCFunc(ns.GetSuggestions)
            end,
            SetPrimaryOffset = function()
              return checkCFunc(ns.SetPrimaryOffset)
            end,
            UpdateSuggestions = function()
              return checkCFunc(ns.UpdateSuggestions)
            end,
          })
        end,
        C_AdventureMap = function()
          local ns = _G.C_AdventureMap
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            Close = function()
              return checkCFunc(ns.Close)
            end,
            GetMapID = function()
              return checkCFunc(ns.GetMapID)
            end,
            GetMapInsetDetailTileInfo = function()
              return checkCFunc(ns.GetMapInsetDetailTileInfo)
            end,
            GetMapInsetInfo = function()
              return checkCFunc(ns.GetMapInsetInfo)
            end,
            GetNumMapInsets = function()
              return checkCFunc(ns.GetNumMapInsets)
            end,
            GetNumQuestOffers = function()
              return checkCFunc(ns.GetNumQuestOffers)
            end,
            GetNumZoneChoices = function()
              return checkCFunc(ns.GetNumZoneChoices)
            end,
            GetQuestInfo = function()
              return checkCFunc(ns.GetQuestInfo)
            end,
            GetQuestOfferInfo = function()
              return checkCFunc(ns.GetQuestOfferInfo)
            end,
            GetZoneChoiceInfo = function()
              return checkCFunc(ns.GetZoneChoiceInfo)
            end,
            StartQuest = function()
              return checkCFunc(ns.StartQuest)
            end,
          })
        end,
        C_AlliedRaces = function()
          local ns = _G.C_AlliedRaces
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ClearAlliedRaceDetailsGiver = function()
              return checkCFunc(ns.ClearAlliedRaceDetailsGiver)
            end,
            GetAllRacialAbilitiesFromID = function()
              return checkCFunc(ns.GetAllRacialAbilitiesFromID)
            end,
            GetRaceInfoByID = function()
              return checkCFunc(ns.GetRaceInfoByID)
            end,
          })
        end,
        C_AnimaDiversion = function()
          local ns = _G.C_AnimaDiversion
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CloseUI = function()
              return checkCFunc(ns.CloseUI)
            end,
            GetAnimaDiversionNodes = function()
              return checkCFunc(ns.GetAnimaDiversionNodes)
            end,
            GetOriginPosition = function()
              return checkCFunc(ns.GetOriginPosition)
            end,
            GetReinforceProgress = function()
              return checkCFunc(ns.GetReinforceProgress)
            end,
            GetTextureKit = function()
              return checkCFunc(ns.GetTextureKit)
            end,
            OpenAnimaDiversionUI = function()
              return checkCFunc(ns.OpenAnimaDiversionUI)
            end,
            SelectAnimaNode = function()
              return checkCFunc(ns.SelectAnimaNode)
            end,
          })
        end,
        C_ArdenwealdGardening = function()
          local ns = _G.C_ArdenwealdGardening
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetGardenData = function()
              return checkCFunc(ns.GetGardenData)
            end,
            IsGardenAccessible = function()
              return checkCFunc(ns.IsGardenAccessible)
            end,
          })
        end,
        C_AreaPoiInfo = function()
          local ns = _G.C_AreaPoiInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetAreaPOIForMap = function()
              return checkCFunc(ns.GetAreaPOIForMap)
            end,
            GetAreaPOIInfo = function()
              return checkCFunc(ns.GetAreaPOIInfo)
            end,
            GetAreaPOISecondsLeft = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAreaPOISecondsLeft)
              end
              return checkCFunc(ns.GetAreaPOISecondsLeft)
            end,
            GetAreaPOITimeLeft = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAreaPOITimeLeft)
              end
              return checkCFunc(ns.GetAreaPOITimeLeft)
            end,
            IsAreaPOITimed = function()
              return checkCFunc(ns.IsAreaPOITimed)
            end,
          })
        end,
        C_ArtifactUI = function()
          local ns = _G.C_ArtifactUI
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AddPower = function()
              return checkCFunc(ns.AddPower)
            end,
            ApplyCursorRelicToSlot = function()
              return checkCFunc(ns.ApplyCursorRelicToSlot)
            end,
            CanApplyArtifactRelic = function()
              return checkCFunc(ns.CanApplyArtifactRelic)
            end,
            CanApplyCursorRelicToSlot = function()
              return checkCFunc(ns.CanApplyCursorRelicToSlot)
            end,
            CanApplyRelicItemIDToEquippedArtifactSlot = function()
              return checkCFunc(ns.CanApplyRelicItemIDToEquippedArtifactSlot)
            end,
            CanApplyRelicItemIDToSlot = function()
              return checkCFunc(ns.CanApplyRelicItemIDToSlot)
            end,
            CheckRespecNPC = function()
              return checkCFunc(ns.CheckRespecNPC)
            end,
            Clear = function()
              return checkCFunc(ns.Clear)
            end,
            ClearForgeCamera = function()
              return checkCFunc(ns.ClearForgeCamera)
            end,
            ConfirmRespec = function()
              return checkCFunc(ns.ConfirmRespec)
            end,
            DoesEquippedArtifactHaveAnyRelicsSlotted = function()
              return checkCFunc(ns.DoesEquippedArtifactHaveAnyRelicsSlotted)
            end,
            GetAppearanceInfo = function()
              return checkCFunc(ns.GetAppearanceInfo)
            end,
            GetAppearanceInfoByID = function()
              return checkCFunc(ns.GetAppearanceInfoByID)
            end,
            GetAppearanceSetInfo = function()
              return checkCFunc(ns.GetAppearanceSetInfo)
            end,
            GetArtifactArtInfo = function()
              return checkCFunc(ns.GetArtifactArtInfo)
            end,
            GetArtifactInfo = function()
              return checkCFunc(ns.GetArtifactInfo)
            end,
            GetArtifactItemID = function()
              return checkCFunc(ns.GetArtifactItemID)
            end,
            GetArtifactTier = function()
              return checkCFunc(ns.GetArtifactTier)
            end,
            GetArtifactXPRewardTargetInfo = function()
              return checkCFunc(ns.GetArtifactXPRewardTargetInfo)
            end,
            GetCostForPointAtRank = function()
              return checkCFunc(ns.GetCostForPointAtRank)
            end,
            GetEquippedArtifactArtInfo = function()
              return checkCFunc(ns.GetEquippedArtifactArtInfo)
            end,
            GetEquippedArtifactInfo = function()
              return checkCFunc(ns.GetEquippedArtifactInfo)
            end,
            GetEquippedArtifactItemID = function()
              return checkCFunc(ns.GetEquippedArtifactItemID)
            end,
            GetEquippedArtifactNumRelicSlots = function()
              return checkCFunc(ns.GetEquippedArtifactNumRelicSlots)
            end,
            GetEquippedArtifactRelicInfo = function()
              return checkCFunc(ns.GetEquippedArtifactRelicInfo)
            end,
            GetEquippedRelicLockedReason = function()
              return checkCFunc(ns.GetEquippedRelicLockedReason)
            end,
            GetForgeRotation = function()
              return checkCFunc(ns.GetForgeRotation)
            end,
            GetItemLevelIncreaseProvidedByRelic = function()
              return checkCFunc(ns.GetItemLevelIncreaseProvidedByRelic)
            end,
            GetMetaPowerInfo = function()
              return checkCFunc(ns.GetMetaPowerInfo)
            end,
            GetNumAppearanceSets = function()
              return checkCFunc(ns.GetNumAppearanceSets)
            end,
            GetNumObtainedArtifacts = function()
              return checkCFunc(ns.GetNumObtainedArtifacts)
            end,
            GetNumRelicSlots = function()
              return checkCFunc(ns.GetNumRelicSlots)
            end,
            GetPointsRemaining = function()
              return checkCFunc(ns.GetPointsRemaining)
            end,
            GetPowerHyperlink = function()
              return checkCFunc(ns.GetPowerHyperlink)
            end,
            GetPowerInfo = function()
              return checkCFunc(ns.GetPowerInfo)
            end,
            GetPowerLinks = function()
              return checkCFunc(ns.GetPowerLinks)
            end,
            GetPowers = function()
              return checkCFunc(ns.GetPowers)
            end,
            GetPowersAffectedByRelic = function()
              return checkCFunc(ns.GetPowersAffectedByRelic)
            end,
            GetPowersAffectedByRelicItemLink = function()
              return checkCFunc(ns.GetPowersAffectedByRelicItemLink)
            end,
            GetPreviewAppearance = function()
              return checkCFunc(ns.GetPreviewAppearance)
            end,
            GetRelicInfo = function()
              return checkCFunc(ns.GetRelicInfo)
            end,
            GetRelicInfoByItemID = function()
              return checkCFunc(ns.GetRelicInfoByItemID)
            end,
            GetRelicLockedReason = function()
              return checkCFunc(ns.GetRelicLockedReason)
            end,
            GetRelicSlotType = function()
              return checkCFunc(ns.GetRelicSlotType)
            end,
            GetRespecArtifactArtInfo = function()
              return checkCFunc(ns.GetRespecArtifactArtInfo)
            end,
            GetRespecArtifactInfo = function()
              return checkCFunc(ns.GetRespecArtifactInfo)
            end,
            GetRespecCost = function()
              return checkCFunc(ns.GetRespecCost)
            end,
            GetTotalPowerCost = function()
              return checkCFunc(ns.GetTotalPowerCost)
            end,
            GetTotalPurchasedRanks = function()
              return checkCFunc(ns.GetTotalPurchasedRanks)
            end,
            IsArtifactDisabled = function()
              return checkCFunc(ns.IsArtifactDisabled)
            end,
            IsAtForge = function()
              return checkCFunc(ns.IsAtForge)
            end,
            IsEquippedArtifactDisabled = function()
              return checkCFunc(ns.IsEquippedArtifactDisabled)
            end,
            IsEquippedArtifactMaxed = function()
              return checkCFunc(ns.IsEquippedArtifactMaxed)
            end,
            IsMaxedByRulesOrEffect = function()
              return checkCFunc(ns.IsMaxedByRulesOrEffect)
            end,
            IsPowerKnown = function()
              return checkCFunc(ns.IsPowerKnown)
            end,
            IsViewedArtifactEquipped = function()
              return checkCFunc(ns.IsViewedArtifactEquipped)
            end,
            SetAppearance = function()
              return checkCFunc(ns.SetAppearance)
            end,
            SetForgeCamera = function()
              return checkCFunc(ns.SetForgeCamera)
            end,
            SetForgeRotation = function()
              return checkCFunc(ns.SetForgeRotation)
            end,
            SetPreviewAppearance = function()
              return checkCFunc(ns.SetPreviewAppearance)
            end,
            ShouldSuppressForgeRotation = function()
              return checkCFunc(ns.ShouldSuppressForgeRotation)
            end,
          })
        end,
        C_AuctionHouse = function()
          local ns = _G.C_AuctionHouse
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CalculateCommodityDeposit = function()
              return checkCFunc(ns.CalculateCommodityDeposit)
            end,
            CalculateItemDeposit = function()
              return checkCFunc(ns.CalculateItemDeposit)
            end,
            CanCancelAuction = function()
              return checkCFunc(ns.CanCancelAuction)
            end,
            CancelAuction = function()
              return checkCFunc(ns.CancelAuction)
            end,
            CancelCommoditiesPurchase = function()
              return checkCFunc(ns.CancelCommoditiesPurchase)
            end,
            CancelSell = function()
              return checkCFunc(ns.CancelSell)
            end,
            CloseAuctionHouse = function()
              return checkCFunc(ns.CloseAuctionHouse)
            end,
            ConfirmCommoditiesPurchase = function()
              return checkCFunc(ns.ConfirmCommoditiesPurchase)
            end,
            FavoritesAreAvailable = function()
              return checkCFunc(ns.FavoritesAreAvailable)
            end,
            GetAuctionInfoByID = function()
              return checkCFunc(ns.GetAuctionInfoByID)
            end,
            GetAuctionItemSubClasses = function()
              return checkCFunc(ns.GetAuctionItemSubClasses)
            end,
            GetAvailablePostCount = function()
              return checkCFunc(ns.GetAvailablePostCount)
            end,
            GetBidInfo = function()
              return checkCFunc(ns.GetBidInfo)
            end,
            GetBidType = function()
              return checkCFunc(ns.GetBidType)
            end,
            GetBids = function()
              return checkCFunc(ns.GetBids)
            end,
            GetBrowseResults = function()
              return checkCFunc(ns.GetBrowseResults)
            end,
            GetCancelCost = function()
              return checkCFunc(ns.GetCancelCost)
            end,
            GetCommoditySearchResultInfo = function()
              return checkCFunc(ns.GetCommoditySearchResultInfo)
            end,
            GetCommoditySearchResultsQuantity = function()
              return checkCFunc(ns.GetCommoditySearchResultsQuantity)
            end,
            GetExtraBrowseInfo = function()
              return checkCFunc(ns.GetExtraBrowseInfo)
            end,
            GetFilterGroups = function()
              return checkCFunc(ns.GetFilterGroups)
            end,
            GetItemCommodityStatus = function()
              return checkCFunc(ns.GetItemCommodityStatus)
            end,
            GetItemKeyFromItem = function()
              return checkCFunc(ns.GetItemKeyFromItem)
            end,
            GetItemKeyInfo = function()
              return checkCFunc(ns.GetItemKeyInfo)
            end,
            GetItemKeyRequiredLevel = function()
              return checkCFunc(ns.GetItemKeyRequiredLevel)
            end,
            GetItemSearchResultInfo = function()
              return checkCFunc(ns.GetItemSearchResultInfo)
            end,
            GetItemSearchResultsQuantity = function()
              return checkCFunc(ns.GetItemSearchResultsQuantity)
            end,
            GetMaxBidItemBid = function()
              return checkCFunc(ns.GetMaxBidItemBid)
            end,
            GetMaxBidItemBuyout = function()
              return checkCFunc(ns.GetMaxBidItemBuyout)
            end,
            GetMaxCommoditySearchResultPrice = function()
              return checkCFunc(ns.GetMaxCommoditySearchResultPrice)
            end,
            GetMaxItemSearchResultBid = function()
              return checkCFunc(ns.GetMaxItemSearchResultBid)
            end,
            GetMaxItemSearchResultBuyout = function()
              return checkCFunc(ns.GetMaxItemSearchResultBuyout)
            end,
            GetMaxOwnedAuctionBid = function()
              return checkCFunc(ns.GetMaxOwnedAuctionBid)
            end,
            GetMaxOwnedAuctionBuyout = function()
              return checkCFunc(ns.GetMaxOwnedAuctionBuyout)
            end,
            GetNumBidTypes = function()
              return checkCFunc(ns.GetNumBidTypes)
            end,
            GetNumBids = function()
              return checkCFunc(ns.GetNumBids)
            end,
            GetNumCommoditySearchResults = function()
              return checkCFunc(ns.GetNumCommoditySearchResults)
            end,
            GetNumItemSearchResults = function()
              return checkCFunc(ns.GetNumItemSearchResults)
            end,
            GetNumOwnedAuctionTypes = function()
              return checkCFunc(ns.GetNumOwnedAuctionTypes)
            end,
            GetNumOwnedAuctions = function()
              return checkCFunc(ns.GetNumOwnedAuctions)
            end,
            GetNumReplicateItems = function()
              return checkCFunc(ns.GetNumReplicateItems)
            end,
            GetOwnedAuctionInfo = function()
              return checkCFunc(ns.GetOwnedAuctionInfo)
            end,
            GetOwnedAuctionType = function()
              return checkCFunc(ns.GetOwnedAuctionType)
            end,
            GetOwnedAuctions = function()
              return checkCFunc(ns.GetOwnedAuctions)
            end,
            GetQuoteDurationRemaining = function()
              return checkCFunc(ns.GetQuoteDurationRemaining)
            end,
            GetReplicateItemBattlePetInfo = function()
              return checkCFunc(ns.GetReplicateItemBattlePetInfo)
            end,
            GetReplicateItemInfo = function()
              return checkCFunc(ns.GetReplicateItemInfo)
            end,
            GetReplicateItemLink = function()
              return checkCFunc(ns.GetReplicateItemLink)
            end,
            GetReplicateItemTimeLeft = function()
              return checkCFunc(ns.GetReplicateItemTimeLeft)
            end,
            GetTimeLeftBandInfo = function()
              return checkCFunc(ns.GetTimeLeftBandInfo)
            end,
            HasFavorites = function()
              return checkCFunc(ns.HasFavorites)
            end,
            HasFullBidResults = function()
              return checkCFunc(ns.HasFullBidResults)
            end,
            HasFullBrowseResults = function()
              return checkCFunc(ns.HasFullBrowseResults)
            end,
            HasFullCommoditySearchResults = function()
              return checkCFunc(ns.HasFullCommoditySearchResults)
            end,
            HasFullItemSearchResults = function()
              return checkCFunc(ns.HasFullItemSearchResults)
            end,
            HasFullOwnedAuctionResults = function()
              return checkCFunc(ns.HasFullOwnedAuctionResults)
            end,
            HasMaxFavorites = function()
              return checkCFunc(ns.HasMaxFavorites)
            end,
            HasSearchResults = function()
              return checkCFunc(ns.HasSearchResults)
            end,
            IsFavoriteItem = function()
              return checkCFunc(ns.IsFavoriteItem)
            end,
            IsSellItemValid = function()
              return checkCFunc(ns.IsSellItemValid)
            end,
            IsThrottledMessageSystemReady = function()
              return checkCFunc(ns.IsThrottledMessageSystemReady)
            end,
            MakeItemKey = function()
              return checkCFunc(ns.MakeItemKey)
            end,
            PlaceBid = function()
              return checkCFunc(ns.PlaceBid)
            end,
            PostCommodity = function()
              return checkCFunc(ns.PostCommodity)
            end,
            PostItem = function()
              return checkCFunc(ns.PostItem)
            end,
            QueryBids = function()
              return checkCFunc(ns.QueryBids)
            end,
            QueryOwnedAuctions = function()
              return checkCFunc(ns.QueryOwnedAuctions)
            end,
            RefreshCommoditySearchResults = function()
              return checkCFunc(ns.RefreshCommoditySearchResults)
            end,
            RefreshItemSearchResults = function()
              return checkCFunc(ns.RefreshItemSearchResults)
            end,
            ReplicateItems = function()
              return checkCFunc(ns.ReplicateItems)
            end,
            RequestFavorites = function()
              return checkCFunc(ns.RequestFavorites)
            end,
            RequestMoreBrowseResults = function()
              return checkCFunc(ns.RequestMoreBrowseResults)
            end,
            RequestMoreCommoditySearchResults = function()
              return checkCFunc(ns.RequestMoreCommoditySearchResults)
            end,
            RequestMoreItemSearchResults = function()
              return checkCFunc(ns.RequestMoreItemSearchResults)
            end,
            RequestOwnedAuctionBidderInfo = function()
              return checkCFunc(ns.RequestOwnedAuctionBidderInfo)
            end,
            SearchForFavorites = function()
              return checkCFunc(ns.SearchForFavorites)
            end,
            SearchForItemKeys = function()
              return checkCFunc(ns.SearchForItemKeys)
            end,
            SendBrowseQuery = function()
              return checkCFunc(ns.SendBrowseQuery)
            end,
            SendSearchQuery = function()
              return checkCFunc(ns.SendSearchQuery)
            end,
            SendSellSearchQuery = function()
              return checkCFunc(ns.SendSellSearchQuery)
            end,
            SetFavoriteItem = function()
              return checkCFunc(ns.SetFavoriteItem)
            end,
            StartCommoditiesPurchase = function()
              return checkCFunc(ns.StartCommoditiesPurchase)
            end,
          })
        end,
        C_AzeriteEmpoweredItem = function()
          local ns = _G.C_AzeriteEmpoweredItem
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanSelectPower = function()
              return checkCFunc(ns.CanSelectPower)
            end,
            CloseAzeriteEmpoweredItemRespec = function()
              return checkCFunc(ns.CloseAzeriteEmpoweredItemRespec)
            end,
            ConfirmAzeriteEmpoweredItemRespec = function()
              return checkCFunc(ns.ConfirmAzeriteEmpoweredItemRespec)
            end,
            GetAllTierInfo = function()
              return checkCFunc(ns.GetAllTierInfo)
            end,
            GetAllTierInfoByItemID = function()
              return checkCFunc(ns.GetAllTierInfoByItemID)
            end,
            GetAzeriteEmpoweredItemRespecCost = function()
              return checkCFunc(ns.GetAzeriteEmpoweredItemRespecCost)
            end,
            GetPowerInfo = function()
              return checkCFunc(ns.GetPowerInfo)
            end,
            GetPowerText = function()
              return checkCFunc(ns.GetPowerText)
            end,
            GetSpecsForPower = function()
              return checkCFunc(ns.GetSpecsForPower)
            end,
            HasAnyUnselectedPowers = function()
              return checkCFunc(ns.HasAnyUnselectedPowers)
            end,
            HasBeenViewed = function()
              return checkCFunc(ns.HasBeenViewed)
            end,
            IsAzeriteEmpoweredItem = function()
              return checkCFunc(ns.IsAzeriteEmpoweredItem)
            end,
            IsAzeriteEmpoweredItemByID = function()
              return checkCFunc(ns.IsAzeriteEmpoweredItemByID)
            end,
            IsAzeritePreviewSourceDisplayable = function()
              return checkCFunc(ns.IsAzeritePreviewSourceDisplayable)
            end,
            IsHeartOfAzerothEquipped = function()
              return checkCFunc(ns.IsHeartOfAzerothEquipped)
            end,
            IsPowerAvailableForSpec = function()
              return checkCFunc(ns.IsPowerAvailableForSpec)
            end,
            IsPowerSelected = function()
              return checkCFunc(ns.IsPowerSelected)
            end,
            SelectPower = function()
              return checkCFunc(ns.SelectPower)
            end,
            SetHasBeenViewed = function()
              return checkCFunc(ns.SetHasBeenViewed)
            end,
          })
        end,
        C_AzeriteEssence = function()
          local ns = _G.C_AzeriteEssence
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ActivateEssence = function()
              return checkCFunc(ns.ActivateEssence)
            end,
            CanActivateEssence = function()
              return checkCFunc(ns.CanActivateEssence)
            end,
            CanDeactivateEssence = function()
              return checkCFunc(ns.CanDeactivateEssence)
            end,
            CanOpenUI = function()
              return checkCFunc(ns.CanOpenUI)
            end,
            ClearPendingActivationEssence = function()
              return checkCFunc(ns.ClearPendingActivationEssence)
            end,
            CloseForge = function()
              return checkCFunc(ns.CloseForge)
            end,
            GetEssenceHyperlink = function()
              return checkCFunc(ns.GetEssenceHyperlink)
            end,
            GetEssenceInfo = function()
              return checkCFunc(ns.GetEssenceInfo)
            end,
            GetEssences = function()
              return checkCFunc(ns.GetEssences)
            end,
            GetMilestoneEssence = function()
              return checkCFunc(ns.GetMilestoneEssence)
            end,
            GetMilestoneInfo = function()
              return checkCFunc(ns.GetMilestoneInfo)
            end,
            GetMilestoneSpell = function()
              return checkCFunc(ns.GetMilestoneSpell)
            end,
            GetMilestones = function()
              return checkCFunc(ns.GetMilestones)
            end,
            GetNumUnlockedEssences = function()
              return checkCFunc(ns.GetNumUnlockedEssences)
            end,
            GetNumUsableEssences = function()
              return checkCFunc(ns.GetNumUsableEssences)
            end,
            GetPendingActivationEssence = function()
              return checkCFunc(ns.GetPendingActivationEssence)
            end,
            HasNeverActivatedAnyEssences = function()
              return checkCFunc(ns.HasNeverActivatedAnyEssences)
            end,
            HasPendingActivationEssence = function()
              return checkCFunc(ns.HasPendingActivationEssence)
            end,
            IsAtForge = function()
              return checkCFunc(ns.IsAtForge)
            end,
            SetPendingActivationEssence = function()
              return checkCFunc(ns.SetPendingActivationEssence)
            end,
            UnlockMilestone = function()
              return checkCFunc(ns.UnlockMilestone)
            end,
          })
        end,
        C_AzeriteItem = function()
          local ns = _G.C_AzeriteItem
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            FindActiveAzeriteItem = function()
              return checkCFunc(ns.FindActiveAzeriteItem)
            end,
            GetAzeriteItemXPInfo = function()
              return checkCFunc(ns.GetAzeriteItemXPInfo)
            end,
            GetPowerLevel = function()
              return checkCFunc(ns.GetPowerLevel)
            end,
            GetUnlimitedPowerLevel = function()
              return checkCFunc(ns.GetUnlimitedPowerLevel)
            end,
            HasActiveAzeriteItem = function()
              return checkCFunc(ns.HasActiveAzeriteItem)
            end,
            IsAzeriteItem = function()
              return checkCFunc(ns.IsAzeriteItem)
            end,
            IsAzeriteItemAtMaxLevel = function()
              return checkCFunc(ns.IsAzeriteItemAtMaxLevel)
            end,
            IsAzeriteItemByID = function()
              return checkCFunc(ns.IsAzeriteItemByID)
            end,
            IsAzeriteItemEnabled = function()
              return checkCFunc(ns.IsAzeriteItemEnabled)
            end,
          })
        end,
        C_BarberShop = function()
          local ns = _G.C_BarberShop
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ApplyCustomizationChoices = function()
              return checkCFunc(ns.ApplyCustomizationChoices)
            end,
            Cancel = function()
              return checkCFunc(ns.Cancel)
            end,
            ClearPreviewChoices = function()
              return checkCFunc(ns.ClearPreviewChoices)
            end,
            GetAvailableCustomizations = function()
              return checkCFunc(ns.GetAvailableCustomizations)
            end,
            GetCurrentCameraZoom = function()
              return checkCFunc(ns.GetCurrentCameraZoom)
            end,
            GetCurrentCharacterData = function()
              return checkCFunc(ns.GetCurrentCharacterData)
            end,
            GetCurrentCost = function()
              return checkCFunc(ns.GetCurrentCost)
            end,
            HasAnyChanges = function()
              return checkCFunc(ns.HasAnyChanges)
            end,
            IsViewingAlteredForm = function()
              return checkCFunc(ns.IsViewingAlteredForm)
            end,
            MarkCustomizationChoiceAsSeen = function()
              return checkCFunc(ns.MarkCustomizationChoiceAsSeen)
            end,
            MarkCustomizationOptionAsSeen = function()
              return checkCFunc(ns.MarkCustomizationOptionAsSeen)
            end,
            PreviewCustomizationChoice = function()
              return checkCFunc(ns.PreviewCustomizationChoice)
            end,
            RandomizeCustomizationChoices = function()
              return checkCFunc(ns.RandomizeCustomizationChoices)
            end,
            ResetCameraRotation = function()
              return checkCFunc(ns.ResetCameraRotation)
            end,
            ResetCustomizationChoices = function()
              return checkCFunc(ns.ResetCustomizationChoices)
            end,
            RotateCamera = function()
              return checkCFunc(ns.RotateCamera)
            end,
            SaveSeenChoices = function()
              return checkCFunc(ns.SaveSeenChoices)
            end,
            SetCameraDistanceOffset = function()
              return checkCFunc(ns.SetCameraDistanceOffset)
            end,
            SetCameraZoomLevel = function()
              return checkCFunc(ns.SetCameraZoomLevel)
            end,
            SetCustomizationChoice = function()
              return checkCFunc(ns.SetCustomizationChoice)
            end,
            SetModelDressState = function()
              return checkCFunc(ns.SetModelDressState)
            end,
            SetSelectedSex = function()
              return checkCFunc(ns.SetSelectedSex)
            end,
            SetViewingAlteredForm = function()
              return checkCFunc(ns.SetViewingAlteredForm)
            end,
            SetViewingShapeshiftForm = function()
              return checkCFunc(ns.SetViewingShapeshiftForm)
            end,
            ZoomCamera = function()
              return checkCFunc(ns.ZoomCamera)
            end,
          })
        end,
        C_BattleNet = function()
          local ns = _G.C_BattleNet
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetAccountInfoByGUID = function()
              return checkCFunc(ns.GetAccountInfoByGUID)
            end,
            GetAccountInfoByID = function()
              return checkCFunc(ns.GetAccountInfoByID)
            end,
            GetFriendAccountInfo = function()
              return checkCFunc(ns.GetFriendAccountInfo)
            end,
            GetFriendGameAccountInfo = function()
              return checkCFunc(ns.GetFriendGameAccountInfo)
            end,
            GetFriendNumGameAccounts = function()
              return checkCFunc(ns.GetFriendNumGameAccounts)
            end,
            GetGameAccountInfoByGUID = function()
              return checkCFunc(ns.GetGameAccountInfoByGUID)
            end,
            GetGameAccountInfoByID = function()
              return checkCFunc(ns.GetGameAccountInfoByID)
            end,
          })
        end,
        C_BehavioralMessaging = function()
          local ns = _G.C_BehavioralMessaging
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            SendNotificationReceipt = function()
              return checkCFunc(ns.SendNotificationReceipt)
            end,
          })
        end,
        C_BlackMarket = function()
          local ns = _G.C_BlackMarket
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            Close = function()
              return checkCFunc(ns.Close)
            end,
            GetHotItem = function()
              return checkCFunc(ns.GetHotItem)
            end,
            GetItemInfoByID = function()
              return checkCFunc(ns.GetItemInfoByID)
            end,
            GetItemInfoByIndex = function()
              return checkCFunc(ns.GetItemInfoByIndex)
            end,
            GetNumItems = function()
              return checkCFunc(ns.GetNumItems)
            end,
            IsViewOnly = function()
              return checkCFunc(ns.IsViewOnly)
            end,
            ItemPlaceBid = function()
              return checkCFunc(ns.ItemPlaceBid)
            end,
            RequestItems = function()
              return checkCFunc(ns.RequestItems)
            end,
          })
        end,
        C_CVar = function()
          local ns = _G.C_CVar
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetCVar = function()
              return checkCFunc(ns.GetCVar)
            end,
            GetCVarBitfield = function()
              return checkCFunc(ns.GetCVarBitfield)
            end,
            GetCVarBool = function()
              return checkCFunc(ns.GetCVarBool)
            end,
            GetCVarDefault = function()
              return checkCFunc(ns.GetCVarDefault)
            end,
            RegisterCVar = function()
              return checkCFunc(ns.RegisterCVar)
            end,
            ResetTestCVars = function()
              return checkCFunc(ns.ResetTestCVars)
            end,
            SetCVar = function()
              return checkCFunc(ns.SetCVar)
            end,
            SetCVarBitfield = function()
              return checkCFunc(ns.SetCVarBitfield)
            end,
          })
        end,
        C_Calendar = function()
          local ns = _G.C_Calendar
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AddEvent = function()
              return checkCFunc(ns.AddEvent)
            end,
            AreNamesReady = function()
              return checkCFunc(ns.AreNamesReady)
            end,
            CanAddEvent = function()
              return checkCFunc(ns.CanAddEvent)
            end,
            CanSendInvite = function()
              return checkCFunc(ns.CanSendInvite)
            end,
            CloseEvent = function()
              return checkCFunc(ns.CloseEvent)
            end,
            ContextMenuEventCanComplain = function()
              return checkCFunc(ns.ContextMenuEventCanComplain)
            end,
            ContextMenuEventCanEdit = function()
              return checkCFunc(ns.ContextMenuEventCanEdit)
            end,
            ContextMenuEventCanRemove = function()
              return checkCFunc(ns.ContextMenuEventCanRemove)
            end,
            ContextMenuEventClipboard = function()
              return checkCFunc(ns.ContextMenuEventClipboard)
            end,
            ContextMenuEventComplain = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ContextMenuEventComplain)
              end
              return checkCFunc(ns.ContextMenuEventComplain)
            end,
            ContextMenuEventCopy = function()
              return checkCFunc(ns.ContextMenuEventCopy)
            end,
            ContextMenuEventGetCalendarType = function()
              return checkCFunc(ns.ContextMenuEventGetCalendarType)
            end,
            ContextMenuEventPaste = function()
              return checkCFunc(ns.ContextMenuEventPaste)
            end,
            ContextMenuEventRemove = function()
              return checkCFunc(ns.ContextMenuEventRemove)
            end,
            ContextMenuEventSignUp = function()
              return checkCFunc(ns.ContextMenuEventSignUp)
            end,
            ContextMenuGetEventIndex = function()
              return checkCFunc(ns.ContextMenuGetEventIndex)
            end,
            ContextMenuInviteAvailable = function()
              return checkCFunc(ns.ContextMenuInviteAvailable)
            end,
            ContextMenuInviteDecline = function()
              return checkCFunc(ns.ContextMenuInviteDecline)
            end,
            ContextMenuInviteRemove = function()
              return checkCFunc(ns.ContextMenuInviteRemove)
            end,
            ContextMenuInviteTentative = function()
              return checkCFunc(ns.ContextMenuInviteTentative)
            end,
            ContextMenuSelectEvent = function()
              return checkCFunc(ns.ContextMenuSelectEvent)
            end,
            CreateCommunitySignUpEvent = function()
              return checkCFunc(ns.CreateCommunitySignUpEvent)
            end,
            CreateGuildAnnouncementEvent = function()
              return checkCFunc(ns.CreateGuildAnnouncementEvent)
            end,
            CreateGuildSignUpEvent = function()
              return checkCFunc(ns.CreateGuildSignUpEvent)
            end,
            CreatePlayerEvent = function()
              return checkCFunc(ns.CreatePlayerEvent)
            end,
            EventAvailable = function()
              return checkCFunc(ns.EventAvailable)
            end,
            EventCanEdit = function()
              return checkCFunc(ns.EventCanEdit)
            end,
            EventClearAutoApprove = function()
              return checkCFunc(ns.EventClearAutoApprove)
            end,
            EventClearLocked = function()
              return checkCFunc(ns.EventClearLocked)
            end,
            EventClearModerator = function()
              return checkCFunc(ns.EventClearModerator)
            end,
            EventDecline = function()
              return checkCFunc(ns.EventDecline)
            end,
            EventGetCalendarType = function()
              return checkCFunc(ns.EventGetCalendarType)
            end,
            EventGetClubId = function()
              return checkCFunc(ns.EventGetClubId)
            end,
            EventGetInvite = function()
              return checkCFunc(ns.EventGetInvite)
            end,
            EventGetInviteResponseTime = function()
              return checkCFunc(ns.EventGetInviteResponseTime)
            end,
            EventGetInviteSortCriterion = function()
              return checkCFunc(ns.EventGetInviteSortCriterion)
            end,
            EventGetSelectedInvite = function()
              return checkCFunc(ns.EventGetSelectedInvite)
            end,
            EventGetStatusOptions = function()
              return checkCFunc(ns.EventGetStatusOptions)
            end,
            EventGetTextures = function()
              return checkCFunc(ns.EventGetTextures)
            end,
            EventGetTypes = function()
              return checkCFunc(ns.EventGetTypes)
            end,
            EventGetTypesDisplayOrdered = function()
              return checkCFunc(ns.EventGetTypesDisplayOrdered)
            end,
            EventHasPendingInvite = function()
              return checkCFunc(ns.EventHasPendingInvite)
            end,
            EventHaveSettingsChanged = function()
              return checkCFunc(ns.EventHaveSettingsChanged)
            end,
            EventInvite = function()
              return checkCFunc(ns.EventInvite)
            end,
            EventRemoveInvite = function()
              return checkCFunc(ns.EventRemoveInvite)
            end,
            EventRemoveInviteByGuid = function()
              return checkCFunc(ns.EventRemoveInviteByGuid)
            end,
            EventSelectInvite = function()
              return checkCFunc(ns.EventSelectInvite)
            end,
            EventSetAutoApprove = function()
              return checkCFunc(ns.EventSetAutoApprove)
            end,
            EventSetClubId = function()
              return checkCFunc(ns.EventSetClubId)
            end,
            EventSetDate = function()
              return checkCFunc(ns.EventSetDate)
            end,
            EventSetDescription = function()
              return checkCFunc(ns.EventSetDescription)
            end,
            EventSetInviteStatus = function()
              return checkCFunc(ns.EventSetInviteStatus)
            end,
            EventSetLocked = function()
              return checkCFunc(ns.EventSetLocked)
            end,
            EventSetModerator = function()
              return checkCFunc(ns.EventSetModerator)
            end,
            EventSetTextureID = function()
              return checkCFunc(ns.EventSetTextureID)
            end,
            EventSetTime = function()
              return checkCFunc(ns.EventSetTime)
            end,
            EventSetTitle = function()
              return checkCFunc(ns.EventSetTitle)
            end,
            EventSetType = function()
              return checkCFunc(ns.EventSetType)
            end,
            EventSignUp = function()
              return checkCFunc(ns.EventSignUp)
            end,
            EventSortInvites = function()
              return checkCFunc(ns.EventSortInvites)
            end,
            EventTentative = function()
              return checkCFunc(ns.EventTentative)
            end,
            GetClubCalendarEvents = function()
              return checkCFunc(ns.GetClubCalendarEvents)
            end,
            GetDayEvent = function()
              return checkCFunc(ns.GetDayEvent)
            end,
            GetDefaultGuildFilter = function()
              return checkCFunc(ns.GetDefaultGuildFilter)
            end,
            GetEventIndex = function()
              return checkCFunc(ns.GetEventIndex)
            end,
            GetEventIndexInfo = function()
              return checkCFunc(ns.GetEventIndexInfo)
            end,
            GetEventInfo = function()
              return checkCFunc(ns.GetEventInfo)
            end,
            GetFirstPendingInvite = function()
              return checkCFunc(ns.GetFirstPendingInvite)
            end,
            GetGuildEventInfo = function()
              return checkCFunc(ns.GetGuildEventInfo)
            end,
            GetGuildEventSelectionInfo = function()
              return checkCFunc(ns.GetGuildEventSelectionInfo)
            end,
            GetHolidayInfo = function()
              return checkCFunc(ns.GetHolidayInfo)
            end,
            GetMaxCreateDate = function()
              return checkCFunc(ns.GetMaxCreateDate)
            end,
            GetMinDate = function()
              return checkCFunc(ns.GetMinDate)
            end,
            GetMonthInfo = function()
              return checkCFunc(ns.GetMonthInfo)
            end,
            GetNextClubId = function()
              return checkCFunc(ns.GetNextClubId)
            end,
            GetNumDayEvents = function()
              return checkCFunc(ns.GetNumDayEvents)
            end,
            GetNumGuildEvents = function()
              return checkCFunc(ns.GetNumGuildEvents)
            end,
            GetNumInvites = function()
              return checkCFunc(ns.GetNumInvites)
            end,
            GetNumPendingInvites = function()
              return checkCFunc(ns.GetNumPendingInvites)
            end,
            GetRaidInfo = function()
              return checkCFunc(ns.GetRaidInfo)
            end,
            IsActionPending = function()
              return checkCFunc(ns.IsActionPending)
            end,
            IsEventOpen = function()
              return checkCFunc(ns.IsEventOpen)
            end,
            MassInviteCommunity = function()
              return checkCFunc(ns.MassInviteCommunity)
            end,
            MassInviteGuild = function()
              return checkCFunc(ns.MassInviteGuild)
            end,
            OpenCalendar = function()
              return checkCFunc(ns.OpenCalendar)
            end,
            OpenEvent = function()
              return checkCFunc(ns.OpenEvent)
            end,
            RemoveEvent = function()
              return checkCFunc(ns.RemoveEvent)
            end,
            SetAbsMonth = function()
              return checkCFunc(ns.SetAbsMonth)
            end,
            SetMonth = function()
              return checkCFunc(ns.SetMonth)
            end,
            SetNextClubId = function()
              return checkCFunc(ns.SetNextClubId)
            end,
            UpdateEvent = function()
              return checkCFunc(ns.UpdateEvent)
            end,
          })
        end,
        C_CampaignInfo = function()
          local ns = _G.C_CampaignInfo
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetAvailableCampaigns = function()
              return checkCFunc(ns.GetAvailableCampaigns)
            end,
            GetCampaignChapterInfo = function()
              return checkCFunc(ns.GetCampaignChapterInfo)
            end,
            GetCampaignID = function()
              return checkCFunc(ns.GetCampaignID)
            end,
            GetCampaignInfo = function()
              return checkCFunc(ns.GetCampaignInfo)
            end,
            GetChapterIDs = function()
              return checkCFunc(ns.GetChapterIDs)
            end,
            GetCurrentChapterID = function()
              return checkCFunc(ns.GetCurrentChapterID)
            end,
            GetFailureReason = function()
              return checkCFunc(ns.GetFailureReason)
            end,
            GetState = function()
              return checkCFunc(ns.GetState)
            end,
            IsCampaignQuest = function()
              return checkCFunc(ns.IsCampaignQuest)
            end,
            UsesNormalQuestIcons = function()
              return checkCFunc(ns.UsesNormalQuestIcons)
            end,
          })
        end,
        C_ChallengeMode = function()
          local ns = _G.C_ChallengeMode
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanUseKeystoneInCurrentMap = function()
              return checkCFunc(ns.CanUseKeystoneInCurrentMap)
            end,
            ClearKeystone = function()
              return checkCFunc(ns.ClearKeystone)
            end,
            CloseKeystoneFrame = function()
              return checkCFunc(ns.CloseKeystoneFrame)
            end,
            GetActiveChallengeMapID = function()
              return checkCFunc(ns.GetActiveChallengeMapID)
            end,
            GetActiveKeystoneInfo = function()
              return checkCFunc(ns.GetActiveKeystoneInfo)
            end,
            GetAffixInfo = function()
              return checkCFunc(ns.GetAffixInfo)
            end,
            GetCompletionInfo = function()
              return checkCFunc(ns.GetCompletionInfo)
            end,
            GetDeathCount = function()
              return checkCFunc(ns.GetDeathCount)
            end,
            GetDungeonScoreRarityColor = function()
              return checkCFunc(ns.GetDungeonScoreRarityColor)
            end,
            GetGuildLeaders = function()
              return checkCFunc(ns.GetGuildLeaders)
            end,
            GetKeystoneLevelRarityColor = function()
              return checkCFunc(ns.GetKeystoneLevelRarityColor)
            end,
            GetMapScoreInfo = function()
              return checkCFunc(ns.GetMapScoreInfo)
            end,
            GetMapTable = function()
              return checkCFunc(ns.GetMapTable)
            end,
            GetMapUIInfo = function()
              return checkCFunc(ns.GetMapUIInfo)
            end,
            GetOverallDungeonScore = function()
              return checkCFunc(ns.GetOverallDungeonScore)
            end,
            GetPowerLevelDamageHealthMod = function()
              return checkCFunc(ns.GetPowerLevelDamageHealthMod)
            end,
            GetSlottedKeystoneInfo = function()
              return checkCFunc(ns.GetSlottedKeystoneInfo)
            end,
            GetSpecificDungeonOverallScoreRarityColor = function()
              return checkCFunc(ns.GetSpecificDungeonOverallScoreRarityColor)
            end,
            GetSpecificDungeonScoreRarityColor = function()
              return checkCFunc(ns.GetSpecificDungeonScoreRarityColor)
            end,
            HasSlottedKeystone = function()
              return checkCFunc(ns.HasSlottedKeystone)
            end,
            IsChallengeModeActive = function()
              return checkCFunc(ns.IsChallengeModeActive)
            end,
            RemoveKeystone = function()
              return checkCFunc(ns.RemoveKeystone)
            end,
            RequestLeaders = function()
              return checkCFunc(ns.RequestLeaders)
            end,
            Reset = function()
              return checkCFunc(ns.Reset)
            end,
            SetKeystoneTooltip = function()
              return checkCFunc(ns.SetKeystoneTooltip)
            end,
            SlotKeystone = function()
              return checkCFunc(ns.SlotKeystone)
            end,
            StartChallengeMode = function()
              return checkCFunc(ns.StartChallengeMode)
            end,
          })
        end,
        C_CharacterServices = function()
          local ns = _G.C_CharacterServices
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AssignPCTDistribution = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.AssignPCTDistribution)
              end
              return checkCFunc(ns.AssignPCTDistribution)
            end,
            AssignPFCDistribution = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.AssignPFCDistribution)
              end
              return checkCFunc(ns.AssignPFCDistribution)
            end,
            AssignUpgradeDistribution = function()
              return checkCFunc(ns.AssignUpgradeDistribution)
            end,
            GetActiveCharacterUpgradeBoostType = function()
              return checkCFunc(ns.GetActiveCharacterUpgradeBoostType)
            end,
            GetActiveClassTrialBoostType = function()
              return checkCFunc(ns.GetActiveClassTrialBoostType)
            end,
            GetAutomaticBoost = function()
              return checkCFunc(ns.GetAutomaticBoost)
            end,
            GetAutomaticBoostCharacter = function()
              return checkCFunc(ns.GetAutomaticBoostCharacter)
            end,
            GetCharacterServiceDisplayData = function()
              return checkCFunc(ns.GetCharacterServiceDisplayData)
            end,
            GetCharacterServiceDisplayDataByVASType = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCharacterServiceDisplayDataByVASType)
              end
              return checkCFunc(ns.GetCharacterServiceDisplayDataByVASType)
            end,
            GetCharacterServiceDisplayInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCharacterServiceDisplayInfo)
              end
              return checkCFunc(ns.GetCharacterServiceDisplayInfo)
            end,
            GetCharacterServiceDisplayOrder = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCharacterServiceDisplayOrder)
              end
              return checkCFunc(ns.GetCharacterServiceDisplayOrder)
            end,
            GetVASDistributions = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetVASDistributions)
              end
              return checkCFunc(ns.GetVASDistributions)
            end,
            HasRequiredBoostForClassTrial = function()
              return checkCFunc(ns.HasRequiredBoostForClassTrial)
            end,
            HasRequiredBoostForUnrevoke = function()
              return checkCFunc(ns.HasRequiredBoostForUnrevoke)
            end,
            SetAutomaticBoost = function()
              return checkCFunc(ns.SetAutomaticBoost)
            end,
            SetAutomaticBoostCharacter = function()
              return checkCFunc(ns.SetAutomaticBoostCharacter)
            end,
          })
        end,
        C_CharacterServicesPublic = function()
          local ns = _G.C_CharacterServicesPublic
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ShouldSeeControlPopup = function()
              return checkCFunc(ns.ShouldSeeControlPopup)
            end,
          })
        end,
        C_ChatBubbles = function()
          local ns = _G.C_ChatBubbles
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetAllChatBubbles = function()
              return checkCFunc(ns.GetAllChatBubbles)
            end,
          })
        end,
        C_ChatInfo = function()
          local ns = _G.C_ChatInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanReportPlayer = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanReportPlayer)
              end
              return checkCFunc(ns.CanReportPlayer)
            end,
            GetChannelInfoFromIdentifier = function()
              return checkCFunc(ns.GetChannelInfoFromIdentifier)
            end,
            GetChannelRosterInfo = function()
              return checkCFunc(ns.GetChannelRosterInfo)
            end,
            GetChannelRuleset = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetChannelRuleset)
              end
              return checkCFunc(ns.GetChannelRuleset)
            end,
            GetChannelRulesetForChannelID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetChannelRulesetForChannelID)
              end
              return checkCFunc(ns.GetChannelRulesetForChannelID)
            end,
            GetChannelShortcut = function()
              return checkCFunc(ns.GetChannelShortcut)
            end,
            GetChannelShortcutForChannelID = function()
              return checkCFunc(ns.GetChannelShortcutForChannelID)
            end,
            GetChatTypeName = function()
              return checkCFunc(ns.GetChatTypeName)
            end,
            GetClubStreamIDs = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetClubStreamIDs)
              end
              return checkCFunc(ns.GetClubStreamIDs)
            end,
            GetGeneralChannelID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetGeneralChannelID)
              end
              return checkCFunc(ns.GetGeneralChannelID)
            end,
            GetGeneralChannelLocalID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetGeneralChannelLocalID)
              end
              return checkCFunc(ns.GetGeneralChannelLocalID)
            end,
            GetMentorChannelID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMentorChannelID)
              end
              return checkCFunc(ns.GetMentorChannelID)
            end,
            GetNumActiveChannels = function()
              return checkCFunc(ns.GetNumActiveChannels)
            end,
            GetNumReservedChatWindows = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumReservedChatWindows)
              end
              return checkCFunc(ns.GetNumReservedChatWindows)
            end,
            GetRegisteredAddonMessagePrefixes = function()
              return checkCFunc(ns.GetRegisteredAddonMessagePrefixes)
            end,
            IsAddonMessagePrefixRegistered = function()
              return checkCFunc(ns.IsAddonMessagePrefixRegistered)
            end,
            IsChannelRegional = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsChannelRegional)
              end
              return checkCFunc(ns.IsChannelRegional)
            end,
            IsChannelRegionalForChannelID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsChannelRegionalForChannelID)
              end
              return checkCFunc(ns.IsChannelRegionalForChannelID)
            end,
            IsPartyChannelType = function()
              return checkCFunc(ns.IsPartyChannelType)
            end,
            IsRegionalServiceAvailable = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsRegionalServiceAvailable)
              end
              return checkCFunc(ns.IsRegionalServiceAvailable)
            end,
            IsValidChatLine = function()
              return checkCFunc(ns.IsValidChatLine)
            end,
            RegisterAddonMessagePrefix = function()
              return checkCFunc(ns.RegisterAddonMessagePrefix)
            end,
            ReplaceIconAndGroupExpressions = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ReplaceIconAndGroupExpressions)
              end
              return checkCFunc(ns.ReplaceIconAndGroupExpressions)
            end,
            ReportPlayer = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ReportPlayer)
              end
              return checkCFunc(ns.ReportPlayer)
            end,
            ReportServerLag = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ReportServerLag)
              end
              return checkCFunc(ns.ReportServerLag)
            end,
            ResetDefaultZoneChannels = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ResetDefaultZoneChannels)
              end
              return checkCFunc(ns.ResetDefaultZoneChannels)
            end,
            SendAddonMessage = function()
              return checkCFunc(ns.SendAddonMessage)
            end,
            SendAddonMessageLogged = function()
              return checkCFunc(ns.SendAddonMessageLogged)
            end,
            SwapChatChannelsByChannelIndex = function()
              return checkCFunc(ns.SwapChatChannelsByChannelIndex)
            end,
          })
        end,
        C_ChromieTime = function()
          local ns = _G.C_ChromieTime
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CloseUI = function()
              return checkCFunc(ns.CloseUI)
            end,
            GetChromieTimeExpansionOption = function()
              return checkCFunc(ns.GetChromieTimeExpansionOption)
            end,
            GetChromieTimeExpansionOptions = function()
              return checkCFunc(ns.GetChromieTimeExpansionOptions)
            end,
            SelectChromieTimeOption = function()
              return checkCFunc(ns.SelectChromieTimeOption)
            end,
          })
        end,
        C_ClassColor = function()
          local ns = _G.C_ClassColor
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetClassColor = function()
              return checkCFunc(ns.GetClassColor)
            end,
          })
        end,
        C_ClassTrial = function()
          local ns = _G.C_ClassTrial
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetClassTrialLogoutTimeSeconds = function()
              return checkCFunc(ns.GetClassTrialLogoutTimeSeconds)
            end,
            IsClassTrialCharacter = function()
              return checkCFunc(ns.IsClassTrialCharacter)
            end,
          })
        end,
        C_ClickBindings = function()
          local ns = _G.C_ClickBindings
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanSpellBeClickBound = function()
              return checkCFunc(ns.CanSpellBeClickBound)
            end,
            ExecuteBinding = function()
              return checkCFunc(ns.ExecuteBinding)
            end,
            GetBindingType = function()
              return checkCFunc(ns.GetBindingType)
            end,
            GetEffectiveInteractionButton = function()
              return checkCFunc(ns.GetEffectiveInteractionButton)
            end,
            GetProfileInfo = function()
              return checkCFunc(ns.GetProfileInfo)
            end,
            GetStringFromModifiers = function()
              return checkCFunc(ns.GetStringFromModifiers)
            end,
            GetTutorialShown = function()
              return checkCFunc(ns.GetTutorialShown)
            end,
            MakeModifiers = function()
              return checkCFunc(ns.MakeModifiers)
            end,
            ResetCurrentProfile = function()
              return checkCFunc(ns.ResetCurrentProfile)
            end,
            SetProfileByInfo = function()
              return checkCFunc(ns.SetProfileByInfo)
            end,
            SetTutorialShown = function()
              return checkCFunc(ns.SetTutorialShown)
            end,
          })
        end,
        C_Club = function()
          local ns = _G.C_Club
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AcceptInvitation = function()
              return checkCFunc(ns.AcceptInvitation)
            end,
            AddClubStreamChatChannel = function()
              return checkCFunc(ns.AddClubStreamChatChannel)
            end,
            AdvanceStreamViewMarker = function()
              return checkCFunc(ns.AdvanceStreamViewMarker)
            end,
            AssignMemberRole = function()
              return checkCFunc(ns.AssignMemberRole)
            end,
            CanResolvePlayerLocationFromClubMessageData = function()
              return checkCFunc(ns.CanResolvePlayerLocationFromClubMessageData)
            end,
            ClearAutoAdvanceStreamViewMarker = function()
              return checkCFunc(ns.ClearAutoAdvanceStreamViewMarker)
            end,
            ClearClubPresenceSubscription = function()
              return checkCFunc(ns.ClearClubPresenceSubscription)
            end,
            CompareBattleNetDisplayName = function()
              return checkCFunc(ns.CompareBattleNetDisplayName)
            end,
            CreateClub = function()
              return checkCFunc(ns.CreateClub)
            end,
            CreateStream = function()
              return checkCFunc(ns.CreateStream)
            end,
            CreateTicket = function()
              return checkCFunc(ns.CreateTicket)
            end,
            DeclineInvitation = function()
              return checkCFunc(ns.DeclineInvitation)
            end,
            DestroyClub = function()
              return checkCFunc(ns.DestroyClub)
            end,
            DestroyMessage = function()
              return checkCFunc(ns.DestroyMessage)
            end,
            DestroyStream = function()
              return checkCFunc(ns.DestroyStream)
            end,
            DestroyTicket = function()
              return checkCFunc(ns.DestroyTicket)
            end,
            DoesCommunityHaveMembersOfTheOppositeFaction = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.DoesCommunityHaveMembersOfTheOppositeFaction)
              end
              return checkCFunc(ns.DoesCommunityHaveMembersOfTheOppositeFaction)
            end,
            EditClub = function()
              return checkCFunc(ns.EditClub)
            end,
            EditMessage = function()
              return checkCFunc(ns.EditMessage)
            end,
            EditStream = function()
              return checkCFunc(ns.EditStream)
            end,
            Flush = function()
              return checkCFunc(ns.Flush)
            end,
            FocusCommunityStreams = function()
              return checkCFunc(ns.FocusCommunityStreams)
            end,
            FocusStream = function()
              return checkCFunc(ns.FocusStream)
            end,
            GetAssignableRoles = function()
              return checkCFunc(ns.GetAssignableRoles)
            end,
            GetAvatarIdList = function()
              return checkCFunc(ns.GetAvatarIdList)
            end,
            GetClubCapacity = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetClubCapacity)
              end
              return checkCFunc(ns.GetClubCapacity)
            end,
            GetClubInfo = function()
              return checkCFunc(ns.GetClubInfo)
            end,
            GetClubLimits = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetClubLimits)
              end
              return checkCFunc(ns.GetClubLimits)
            end,
            GetClubMembers = function()
              return checkCFunc(ns.GetClubMembers)
            end,
            GetClubPrivileges = function()
              return checkCFunc(ns.GetClubPrivileges)
            end,
            GetClubStreamNotificationSettings = function()
              return checkCFunc(ns.GetClubStreamNotificationSettings)
            end,
            GetCommunityNameResultText = function()
              return checkCFunc(ns.GetCommunityNameResultText)
            end,
            GetGuildClubId = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetGuildClubId)
              end
              return checkCFunc(ns.GetGuildClubId)
            end,
            GetInfoFromLastCommunityChatLine = function()
              return checkCFunc(ns.GetInfoFromLastCommunityChatLine)
            end,
            GetInvitationCandidates = function()
              return checkCFunc(ns.GetInvitationCandidates)
            end,
            GetInvitationInfo = function()
              return checkCFunc(ns.GetInvitationInfo)
            end,
            GetInvitationsForClub = function()
              return checkCFunc(ns.GetInvitationsForClub)
            end,
            GetInvitationsForSelf = function()
              return checkCFunc(ns.GetInvitationsForSelf)
            end,
            GetLastTicketResponse = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetLastTicketResponse)
              end
              return checkCFunc(ns.GetLastTicketResponse)
            end,
            GetMemberInfo = function()
              return checkCFunc(ns.GetMemberInfo)
            end,
            GetMemberInfoForSelf = function()
              return checkCFunc(ns.GetMemberInfoForSelf)
            end,
            GetMessageInfo = function()
              return checkCFunc(ns.GetMessageInfo)
            end,
            GetMessageRanges = function()
              return checkCFunc(ns.GetMessageRanges)
            end,
            GetMessagesBefore = function()
              return checkCFunc(ns.GetMessagesBefore)
            end,
            GetMessagesInRange = function()
              return checkCFunc(ns.GetMessagesInRange)
            end,
            GetStreamInfo = function()
              return checkCFunc(ns.GetStreamInfo)
            end,
            GetStreamViewMarker = function()
              return checkCFunc(ns.GetStreamViewMarker)
            end,
            GetStreams = function()
              return checkCFunc(ns.GetStreams)
            end,
            GetSubscribedClubs = function()
              return checkCFunc(ns.GetSubscribedClubs)
            end,
            GetTickets = function()
              return checkCFunc(ns.GetTickets)
            end,
            IsAccountMuted = function()
              return checkCFunc(ns.IsAccountMuted)
            end,
            IsBeginningOfStream = function()
              return checkCFunc(ns.IsBeginningOfStream)
            end,
            IsEnabled = function()
              return checkCFunc(ns.IsEnabled)
            end,
            IsRestricted = function()
              return checkCFunc(ns.IsRestricted)
            end,
            IsSubscribedToStream = function()
              return checkCFunc(ns.IsSubscribedToStream)
            end,
            KickMember = function()
              return checkCFunc(ns.KickMember)
            end,
            LeaveClub = function()
              return checkCFunc(ns.LeaveClub)
            end,
            RedeemTicket = function()
              return checkCFunc(ns.RedeemTicket)
            end,
            RequestInvitationsForClub = function()
              return checkCFunc(ns.RequestInvitationsForClub)
            end,
            RequestMoreMessagesBefore = function()
              return checkCFunc(ns.RequestMoreMessagesBefore)
            end,
            RequestTicket = function()
              return checkCFunc(ns.RequestTicket)
            end,
            RequestTickets = function()
              return checkCFunc(ns.RequestTickets)
            end,
            RevokeInvitation = function()
              return checkCFunc(ns.RevokeInvitation)
            end,
            SendBattleTagFriendRequest = function()
              return checkCFunc(ns.SendBattleTagFriendRequest)
            end,
            SendCharacterInvitation = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SendCharacterInvitation)
              end
              return checkCFunc(ns.SendCharacterInvitation)
            end,
            SendInvitation = function()
              return checkCFunc(ns.SendInvitation)
            end,
            SendMessage = function()
              return checkCFunc(ns.SendMessage)
            end,
            SetAutoAdvanceStreamViewMarker = function()
              return checkCFunc(ns.SetAutoAdvanceStreamViewMarker)
            end,
            SetAvatarTexture = function()
              return checkCFunc(ns.SetAvatarTexture)
            end,
            SetClubMemberNote = function()
              return checkCFunc(ns.SetClubMemberNote)
            end,
            SetClubPresenceSubscription = function()
              return checkCFunc(ns.SetClubPresenceSubscription)
            end,
            SetClubStreamNotificationSettings = function()
              return checkCFunc(ns.SetClubStreamNotificationSettings)
            end,
            SetCommunityID = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetCommunityID)
              end
              return checkCFunc(ns.SetCommunityID)
            end,
            SetFavorite = function()
              return checkCFunc(ns.SetFavorite)
            end,
            SetSocialQueueingEnabled = function()
              return checkCFunc(ns.SetSocialQueueingEnabled)
            end,
            ShouldAllowClubType = function()
              return checkCFunc(ns.ShouldAllowClubType)
            end,
            UnfocusAllStreams = function()
              return checkCFunc(ns.UnfocusAllStreams)
            end,
            UnfocusStream = function()
              return checkCFunc(ns.UnfocusStream)
            end,
            ValidateText = function()
              return checkCFunc(ns.ValidateText)
            end,
          })
        end,
        C_ClubFinder = function()
          local ns = _G.C_ClubFinder
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ApplicantAcceptClubInvite = function()
              return checkCFunc(ns.ApplicantAcceptClubInvite)
            end,
            ApplicantDeclineClubInvite = function()
              return checkCFunc(ns.ApplicantDeclineClubInvite)
            end,
            CancelMembershipRequest = function()
              return checkCFunc(ns.CancelMembershipRequest)
            end,
            CheckAllPlayerApplicantSettings = function()
              return checkCFunc(ns.CheckAllPlayerApplicantSettings)
            end,
            ClearAllFinderCache = function()
              return checkCFunc(ns.ClearAllFinderCache)
            end,
            ClearClubApplicantsCache = function()
              return checkCFunc(ns.ClearClubApplicantsCache)
            end,
            ClearClubFinderPostingsCache = function()
              return checkCFunc(ns.ClearClubFinderPostingsCache)
            end,
            DoesPlayerBelongToClubFromClubGUID = function()
              return checkCFunc(ns.DoesPlayerBelongToClubFromClubGUID)
            end,
            GetClubFinderDisableReason = function()
              return checkCFunc(ns.GetClubFinderDisableReason)
            end,
            GetClubRecruitmentSettings = function()
              return checkCFunc(ns.GetClubRecruitmentSettings)
            end,
            GetClubTypeFromFinderGUID = function()
              return checkCFunc(ns.GetClubTypeFromFinderGUID)
            end,
            GetFocusIndexFromFlag = function()
              return checkCFunc(ns.GetFocusIndexFromFlag)
            end,
            GetPlayerApplicantLocaleFlags = function()
              return checkCFunc(ns.GetPlayerApplicantLocaleFlags)
            end,
            GetPlayerApplicantSettings = function()
              return checkCFunc(ns.GetPlayerApplicantSettings)
            end,
            GetPlayerClubApplicationStatus = function()
              return checkCFunc(ns.GetPlayerClubApplicationStatus)
            end,
            GetPlayerSettingsFocusFlagsSelectedCount = function()
              return checkCFunc(ns.GetPlayerSettingsFocusFlagsSelectedCount)
            end,
            GetPostingIDFromClubFinderGUID = function()
              return checkCFunc(ns.GetPostingIDFromClubFinderGUID)
            end,
            GetRecruitingClubInfoFromClubID = function()
              return checkCFunc(ns.GetRecruitingClubInfoFromClubID)
            end,
            GetRecruitingClubInfoFromFinderGUID = function()
              return checkCFunc(ns.GetRecruitingClubInfoFromFinderGUID)
            end,
            GetStatusOfPostingFromClubId = function()
              return checkCFunc(ns.GetStatusOfPostingFromClubId)
            end,
            GetTotalMatchingCommunityListSize = function()
              return checkCFunc(ns.GetTotalMatchingCommunityListSize)
            end,
            GetTotalMatchingGuildListSize = function()
              return checkCFunc(ns.GetTotalMatchingGuildListSize)
            end,
            HasAlreadyAppliedToLinkedPosting = function()
              return checkCFunc(ns.HasAlreadyAppliedToLinkedPosting)
            end,
            HasPostingBeenDelisted = function()
              return checkCFunc(ns.HasPostingBeenDelisted)
            end,
            IsEnabled = function()
              return checkCFunc(ns.IsEnabled)
            end,
            IsListingEnabledFromFlags = function()
              return checkCFunc(ns.IsListingEnabledFromFlags)
            end,
            IsPostingBanned = function()
              return checkCFunc(ns.IsPostingBanned)
            end,
            LookupClubPostingFromClubFinderGUID = function()
              return checkCFunc(ns.LookupClubPostingFromClubFinderGUID)
            end,
            PlayerGetClubInvitationList = function()
              return checkCFunc(ns.PlayerGetClubInvitationList)
            end,
            PlayerRequestPendingClubsList = function()
              return checkCFunc(ns.PlayerRequestPendingClubsList)
            end,
            PlayerReturnPendingCommunitiesList = function()
              return checkCFunc(ns.PlayerReturnPendingCommunitiesList)
            end,
            PlayerReturnPendingGuildsList = function()
              return checkCFunc(ns.PlayerReturnPendingGuildsList)
            end,
            PostClub = function()
              return checkCFunc(ns.PostClub)
            end,
            RequestApplicantList = function()
              return checkCFunc(ns.RequestApplicantList)
            end,
            RequestClubsList = function()
              return checkCFunc(ns.RequestClubsList)
            end,
            RequestMembershipToClub = function()
              return checkCFunc(ns.RequestMembershipToClub)
            end,
            RequestNextCommunityPage = function()
              return checkCFunc(ns.RequestNextCommunityPage)
            end,
            RequestNextGuildPage = function()
              return checkCFunc(ns.RequestNextGuildPage)
            end,
            RequestPostingInformationFromClubId = function()
              return checkCFunc(ns.RequestPostingInformationFromClubId)
            end,
            RequestSubscribedClubPostingIDs = function()
              return checkCFunc(ns.RequestSubscribedClubPostingIDs)
            end,
            ResetClubPostingMapCache = function()
              return checkCFunc(ns.ResetClubPostingMapCache)
            end,
            RespondToApplicant = function()
              return checkCFunc(ns.RespondToApplicant)
            end,
            ReturnClubApplicantList = function()
              return checkCFunc(ns.ReturnClubApplicantList)
            end,
            ReturnMatchingCommunityList = function()
              return checkCFunc(ns.ReturnMatchingCommunityList)
            end,
            ReturnMatchingGuildList = function()
              return checkCFunc(ns.ReturnMatchingGuildList)
            end,
            ReturnPendingClubApplicantList = function()
              return checkCFunc(ns.ReturnPendingClubApplicantList)
            end,
            SendChatWhisper = function()
              return checkCFunc(ns.SendChatWhisper)
            end,
            SetAllRecruitmentSettings = function()
              return checkCFunc(ns.SetAllRecruitmentSettings)
            end,
            SetPlayerApplicantLocaleFlags = function()
              return checkCFunc(ns.SetPlayerApplicantLocaleFlags)
            end,
            SetPlayerApplicantSettings = function()
              return checkCFunc(ns.SetPlayerApplicantSettings)
            end,
            SetRecruitmentLocale = function()
              return checkCFunc(ns.SetRecruitmentLocale)
            end,
            SetRecruitmentSettings = function()
              return checkCFunc(ns.SetRecruitmentSettings)
            end,
            ShouldShowClubFinder = function()
              return checkCFunc(ns.ShouldShowClubFinder)
            end,
          })
        end,
        C_Commentator = function()
          local ns = _G.C_Commentator
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AddPlayerOverrideName = function()
              return checkCFunc(ns.AddPlayerOverrideName)
            end,
            AddTrackedDefensiveAuras = function()
              return checkCFunc(ns.AddTrackedDefensiveAuras)
            end,
            AddTrackedOffensiveAuras = function()
              return checkCFunc(ns.AddTrackedOffensiveAuras)
            end,
            AreTeamsSwapped = function()
              return checkCFunc(ns.AreTeamsSwapped)
            end,
            AssignPlayerToTeam = function()
              return checkCFunc(ns.AssignPlayerToTeam)
            end,
            AssignPlayersToTeam = function()
              return checkCFunc(ns.AssignPlayersToTeam)
            end,
            AssignPlayersToTeamInCurrentInstance = function()
              return checkCFunc(ns.AssignPlayersToTeamInCurrentInstance)
            end,
            CanUseCommentatorCheats = function()
              return checkCFunc(ns.CanUseCommentatorCheats)
            end,
            ClearCameraTarget = function()
              return checkCFunc(ns.ClearCameraTarget)
            end,
            ClearFollowTarget = function()
              return checkCFunc(ns.ClearFollowTarget)
            end,
            ClearLookAtTarget = function()
              return checkCFunc(ns.ClearLookAtTarget)
            end,
            EnterInstance = function()
              return checkCFunc(ns.EnterInstance)
            end,
            ExitInstance = function()
              return checkCFunc(ns.ExitInstance)
            end,
            FindSpectatedUnit = function()
              return checkCFunc(ns.FindSpectatedUnit)
            end,
            FindTeamNameInCurrentInstance = function()
              return checkCFunc(ns.FindTeamNameInCurrentInstance)
            end,
            FindTeamNameInDirectory = function()
              return checkCFunc(ns.FindTeamNameInDirectory)
            end,
            FlushCommentatorHistory = function()
              return checkCFunc(ns.FlushCommentatorHistory)
            end,
            FollowPlayer = function()
              return checkCFunc(ns.FollowPlayer)
            end,
            FollowUnit = function()
              return checkCFunc(ns.FollowUnit)
            end,
            ForceFollowTransition = function()
              return checkCFunc(ns.ForceFollowTransition)
            end,
            GetAdditionalCameraWeight = function()
              return checkCFunc(ns.GetAdditionalCameraWeight)
            end,
            GetAdditionalCameraWeightByToken = function()
              return checkCFunc(ns.GetAdditionalCameraWeightByToken)
            end,
            GetAllPlayerOverrideNames = function()
              return checkCFunc(ns.GetAllPlayerOverrideNames)
            end,
            GetCamera = function()
              return checkCFunc(ns.GetCamera)
            end,
            GetCameraCollision = function()
              return checkCFunc(ns.GetCameraCollision)
            end,
            GetCameraPosition = function()
              return checkCFunc(ns.GetCameraPosition)
            end,
            GetCommentatorHistory = function()
              return checkCFunc(ns.GetCommentatorHistory)
            end,
            GetCurrentMapID = function()
              return checkCFunc(ns.GetCurrentMapID)
            end,
            GetDampeningPercent = function()
              return checkCFunc(ns.GetDampeningPercent)
            end,
            GetDistanceBeforeForcedHorizontalConvergence = function()
              return checkCFunc(ns.GetDistanceBeforeForcedHorizontalConvergence)
            end,
            GetDurationToForceHorizontalConvergence = function()
              return checkCFunc(ns.GetDurationToForceHorizontalConvergence)
            end,
            GetExcludeDistance = function()
              return checkCFunc(ns.GetExcludeDistance)
            end,
            GetHardlockWeight = function()
              return checkCFunc(ns.GetHardlockWeight)
            end,
            GetHorizontalAngleThresholdToSmooth = function()
              return checkCFunc(ns.GetHorizontalAngleThresholdToSmooth)
            end,
            GetIndirectSpellID = function()
              return checkCFunc(ns.GetIndirectSpellID)
            end,
            GetInstanceInfo = function()
              return checkCFunc(ns.GetInstanceInfo)
            end,
            GetLookAtLerpAmount = function()
              return checkCFunc(ns.GetLookAtLerpAmount)
            end,
            GetMapInfo = function()
              return checkCFunc(ns.GetMapInfo)
            end,
            GetMatchDuration = function()
              return checkCFunc(ns.GetMatchDuration)
            end,
            GetMaxNumPlayersPerTeam = function()
              return checkCFunc(ns.GetMaxNumPlayersPerTeam)
            end,
            GetMaxNumTeams = function()
              return checkCFunc(ns.GetMaxNumTeams)
            end,
            GetMode = function()
              return checkCFunc(ns.GetMode)
            end,
            GetMsToHoldForHorizontalMovement = function()
              return checkCFunc(ns.GetMsToHoldForHorizontalMovement)
            end,
            GetMsToHoldForVerticalMovement = function()
              return checkCFunc(ns.GetMsToHoldForVerticalMovement)
            end,
            GetMsToSmoothHorizontalChange = function()
              return checkCFunc(ns.GetMsToSmoothHorizontalChange)
            end,
            GetMsToSmoothVerticalChange = function()
              return checkCFunc(ns.GetMsToSmoothVerticalChange)
            end,
            GetNumMaps = function()
              return checkCFunc(ns.GetNumMaps)
            end,
            GetNumPlayers = function()
              return checkCFunc(ns.GetNumPlayers)
            end,
            GetOrCreateSeries = function()
              return checkCFunc(ns.GetOrCreateSeries)
            end,
            GetPlayerAuraInfo = function()
              return checkCFunc(ns.GetPlayerAuraInfo)
            end,
            GetPlayerAuraInfoByUnit = function()
              return checkCFunc(ns.GetPlayerAuraInfoByUnit)
            end,
            GetPlayerCooldownInfo = function()
              return checkCFunc(ns.GetPlayerCooldownInfo)
            end,
            GetPlayerCooldownInfoByUnit = function()
              return checkCFunc(ns.GetPlayerCooldownInfoByUnit)
            end,
            GetPlayerCrowdControlInfo = function()
              return checkCFunc(ns.GetPlayerCrowdControlInfo)
            end,
            GetPlayerCrowdControlInfoByUnit = function()
              return checkCFunc(ns.GetPlayerCrowdControlInfoByUnit)
            end,
            GetPlayerData = function()
              return checkCFunc(ns.GetPlayerData)
            end,
            GetPlayerFlagInfo = function()
              return checkCFunc(ns.GetPlayerFlagInfo)
            end,
            GetPlayerFlagInfoByUnit = function()
              return checkCFunc(ns.GetPlayerFlagInfoByUnit)
            end,
            GetPlayerOverrideName = function()
              return checkCFunc(ns.GetPlayerOverrideName)
            end,
            GetPlayerSpellCharges = function()
              return checkCFunc(ns.GetPlayerSpellCharges)
            end,
            GetPlayerSpellChargesByUnit = function()
              return checkCFunc(ns.GetPlayerSpellChargesByUnit)
            end,
            GetPositionLerpAmount = function()
              return checkCFunc(ns.GetPositionLerpAmount)
            end,
            GetSmoothFollowTransitioning = function()
              return checkCFunc(ns.GetSmoothFollowTransitioning)
            end,
            GetSoftlockWeight = function()
              return checkCFunc(ns.GetSoftlockWeight)
            end,
            GetSpeedFactor = function()
              return checkCFunc(ns.GetSpeedFactor)
            end,
            GetStartLocation = function()
              return checkCFunc(ns.GetStartLocation)
            end,
            GetTeamColor = function()
              return checkCFunc(ns.GetTeamColor)
            end,
            GetTeamColorByUnit = function()
              return checkCFunc(ns.GetTeamColorByUnit)
            end,
            GetTimeLeftInMatch = function()
              return checkCFunc(ns.GetTimeLeftInMatch)
            end,
            GetTrackedSpellID = function()
              return checkCFunc(ns.GetTrackedSpellID)
            end,
            GetTrackedSpells = function()
              return checkCFunc(ns.GetTrackedSpells)
            end,
            GetTrackedSpellsByUnit = function()
              return checkCFunc(ns.GetTrackedSpellsByUnit)
            end,
            GetUnitData = function()
              return checkCFunc(ns.GetUnitData)
            end,
            GetWargameInfo = function()
              return checkCFunc(ns.GetWargameInfo)
            end,
            HasTrackedAuras = function()
              return checkCFunc(ns.HasTrackedAuras)
            end,
            IsSmartCameraLocked = function()
              return checkCFunc(ns.IsSmartCameraLocked)
            end,
            IsSpectating = function()
              return checkCFunc(ns.IsSpectating)
            end,
            IsTrackedDefensiveAura = function()
              return checkCFunc(ns.IsTrackedDefensiveAura)
            end,
            IsTrackedOffensiveAura = function()
              return checkCFunc(ns.IsTrackedOffensiveAura)
            end,
            IsTrackedSpell = function()
              return checkCFunc(ns.IsTrackedSpell)
            end,
            IsTrackedSpellByUnit = function()
              return checkCFunc(ns.IsTrackedSpellByUnit)
            end,
            IsUsingSmartCamera = function()
              return checkCFunc(ns.IsUsingSmartCamera)
            end,
            LookAtPlayer = function()
              return checkCFunc(ns.LookAtPlayer)
            end,
            RemoveAllOverrideNames = function()
              return checkCFunc(ns.RemoveAllOverrideNames)
            end,
            RemovePlayerOverrideName = function()
              return checkCFunc(ns.RemovePlayerOverrideName)
            end,
            RequestPlayerCooldownInfo = function()
              return checkCFunc(ns.RequestPlayerCooldownInfo)
            end,
            ResetFoVTarget = function()
              return checkCFunc(ns.ResetFoVTarget)
            end,
            ResetSeriesScores = function()
              return checkCFunc(ns.ResetSeriesScores)
            end,
            ResetSettings = function()
              return checkCFunc(ns.ResetSettings)
            end,
            ResetTrackedAuras = function()
              return checkCFunc(ns.ResetTrackedAuras)
            end,
            SetAdditionalCameraWeight = function()
              return checkCFunc(ns.SetAdditionalCameraWeight)
            end,
            SetAdditionalCameraWeightByToken = function()
              return checkCFunc(ns.SetAdditionalCameraWeightByToken)
            end,
            SetBlocklistedAuras = function()
              return checkCFunc(ns.SetBlocklistedAuras)
            end,
            SetBlocklistedCooldowns = function()
              return checkCFunc(ns.SetBlocklistedCooldowns)
            end,
            SetCamera = function()
              return checkCFunc(ns.SetCamera)
            end,
            SetCameraCollision = function()
              return checkCFunc(ns.SetCameraCollision)
            end,
            SetCameraPosition = function()
              return checkCFunc(ns.SetCameraPosition)
            end,
            SetCheatsEnabled = function()
              return checkCFunc(ns.SetCheatsEnabled)
            end,
            SetCommentatorHistory = function()
              return checkCFunc(ns.SetCommentatorHistory)
            end,
            SetDistanceBeforeForcedHorizontalConvergence = function()
              return checkCFunc(ns.SetDistanceBeforeForcedHorizontalConvergence)
            end,
            SetDurationToForceHorizontalConvergence = function()
              return checkCFunc(ns.SetDurationToForceHorizontalConvergence)
            end,
            SetExcludeDistance = function()
              return checkCFunc(ns.SetExcludeDistance)
            end,
            SetFollowCameraSpeeds = function()
              return checkCFunc(ns.SetFollowCameraSpeeds)
            end,
            SetHardlockWeight = function()
              return checkCFunc(ns.SetHardlockWeight)
            end,
            SetHorizontalAngleThresholdToSmooth = function()
              return checkCFunc(ns.SetHorizontalAngleThresholdToSmooth)
            end,
            SetLookAtLerpAmount = function()
              return checkCFunc(ns.SetLookAtLerpAmount)
            end,
            SetMapAndInstanceIndex = function()
              return checkCFunc(ns.SetMapAndInstanceIndex)
            end,
            SetMouseDisabled = function()
              return checkCFunc(ns.SetMouseDisabled)
            end,
            SetMoveSpeed = function()
              return checkCFunc(ns.SetMoveSpeed)
            end,
            SetMsToHoldForHorizontalMovement = function()
              return checkCFunc(ns.SetMsToHoldForHorizontalMovement)
            end,
            SetMsToHoldForVerticalMovement = function()
              return checkCFunc(ns.SetMsToHoldForVerticalMovement)
            end,
            SetMsToSmoothHorizontalChange = function()
              return checkCFunc(ns.SetMsToSmoothHorizontalChange)
            end,
            SetMsToSmoothVerticalChange = function()
              return checkCFunc(ns.SetMsToSmoothVerticalChange)
            end,
            SetPositionLerpAmount = function()
              return checkCFunc(ns.SetPositionLerpAmount)
            end,
            SetRequestedDebuffCooldowns = function()
              return checkCFunc(ns.SetRequestedDebuffCooldowns)
            end,
            SetRequestedDefensiveCooldowns = function()
              return checkCFunc(ns.SetRequestedDefensiveCooldowns)
            end,
            SetRequestedOffensiveCooldowns = function()
              return checkCFunc(ns.SetRequestedOffensiveCooldowns)
            end,
            SetSeriesScore = function()
              return checkCFunc(ns.SetSeriesScore)
            end,
            SetSeriesScores = function()
              return checkCFunc(ns.SetSeriesScores)
            end,
            SetSmartCameraLocked = function()
              return checkCFunc(ns.SetSmartCameraLocked)
            end,
            SetSmoothFollowTransitioning = function()
              return checkCFunc(ns.SetSmoothFollowTransitioning)
            end,
            SetSoftlockWeight = function()
              return checkCFunc(ns.SetSoftlockWeight)
            end,
            SetSpeedFactor = function()
              return checkCFunc(ns.SetSpeedFactor)
            end,
            SetTargetHeightOffset = function()
              return checkCFunc(ns.SetTargetHeightOffset)
            end,
            SetUseSmartCamera = function()
              return checkCFunc(ns.SetUseSmartCamera)
            end,
            SnapCameraLookAtPoint = function()
              return checkCFunc(ns.SnapCameraLookAtPoint)
            end,
            StartWargame = function()
              return checkCFunc(ns.StartWargame)
            end,
            SwapTeamSides = function()
              return checkCFunc(ns.SwapTeamSides)
            end,
            ToggleCheats = function()
              return checkCFunc(ns.ToggleCheats)
            end,
            UpdateMapInfo = function()
              return checkCFunc(ns.UpdateMapInfo)
            end,
            UpdatePlayerInfo = function()
              return checkCFunc(ns.UpdatePlayerInfo)
            end,
            ZoomIn = function()
              return checkCFunc(ns.ZoomIn)
            end,
            ZoomOut = function()
              return checkCFunc(ns.ZoomOut)
            end,
          })
        end,
        C_Console = function()
          local ns = _G.C_Console
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetAllCommands = function()
              return checkCFunc(ns.GetAllCommands)
            end,
            GetColorFromType = function()
              return checkCFunc(ns.GetColorFromType)
            end,
            GetFontHeight = function()
              return checkCFunc(ns.GetFontHeight)
            end,
            PrintAllMatchingCommands = function()
              return checkCFunc(ns.PrintAllMatchingCommands)
            end,
            SetFontHeight = function()
              return checkCFunc(ns.SetFontHeight)
            end,
          })
        end,
        C_ContributionCollector = function()
          local ns = _G.C_ContributionCollector
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            Close = function()
              return checkCFunc(ns.Close)
            end,
            Contribute = function()
              return checkCFunc(ns.Contribute)
            end,
            GetActive = function()
              return checkCFunc(ns.GetActive)
            end,
            GetAtlases = function()
              return checkCFunc(ns.GetAtlases)
            end,
            GetBuffs = function()
              return checkCFunc(ns.GetBuffs)
            end,
            GetContributionAppearance = function()
              return checkCFunc(ns.GetContributionAppearance)
            end,
            GetContributionCollectorsForMap = function()
              return checkCFunc(ns.GetContributionCollectorsForMap)
            end,
            GetContributionResult = function()
              return checkCFunc(ns.GetContributionResult)
            end,
            GetDescription = function()
              return checkCFunc(ns.GetDescription)
            end,
            GetManagedContributionsForCreatureID = function()
              return checkCFunc(ns.GetManagedContributionsForCreatureID)
            end,
            GetName = function()
              return checkCFunc(ns.GetName)
            end,
            GetOrderIndex = function()
              return checkCFunc(ns.GetOrderIndex)
            end,
            GetRequiredContributionCurrency = function()
              return checkCFunc(ns.GetRequiredContributionCurrency)
            end,
            GetRequiredContributionItem = function()
              return checkCFunc(ns.GetRequiredContributionItem)
            end,
            GetRewardQuestID = function()
              return checkCFunc(ns.GetRewardQuestID)
            end,
            GetState = function()
              return checkCFunc(ns.GetState)
            end,
            HasPendingContribution = function()
              return checkCFunc(ns.HasPendingContribution)
            end,
            IsAwaitingRewardQuestData = function()
              return checkCFunc(ns.IsAwaitingRewardQuestData)
            end,
          })
        end,
        C_CovenantCallings = function()
          local ns = _G.C_CovenantCallings
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AreCallingsUnlocked = function()
              return checkCFunc(ns.AreCallingsUnlocked)
            end,
            RequestCallings = function()
              return checkCFunc(ns.RequestCallings)
            end,
          })
        end,
        C_CovenantPreview = function()
          local ns = _G.C_CovenantPreview
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CloseFromUI = function()
              return checkCFunc(ns.CloseFromUI)
            end,
            GetCovenantInfoForPlayerChoiceResponseID = function()
              return checkCFunc(ns.GetCovenantInfoForPlayerChoiceResponseID)
            end,
          })
        end,
        C_CovenantSanctumUI = function()
          local ns = _G.C_CovenantSanctumUI
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanAccessReservoir = function()
              return checkCFunc(ns.CanAccessReservoir)
            end,
            CanDepositAnima = function()
              return checkCFunc(ns.CanDepositAnima)
            end,
            DepositAnima = function()
              return checkCFunc(ns.DepositAnima)
            end,
            EndInteraction = function()
              return checkCFunc(ns.EndInteraction)
            end,
            GetAnimaInfo = function()
              return checkCFunc(ns.GetAnimaInfo)
            end,
            GetCurrentTalentTreeID = function()
              return checkCFunc(ns.GetCurrentTalentTreeID)
            end,
            GetFeatures = function()
              return checkCFunc(ns.GetFeatures)
            end,
            GetRenownLevel = function()
              return checkCFunc(ns.GetRenownLevel)
            end,
            GetRenownLevels = function()
              return checkCFunc(ns.GetRenownLevels)
            end,
            GetRenownRewardsForLevel = function()
              return checkCFunc(ns.GetRenownRewardsForLevel)
            end,
            GetSanctumType = function()
              return checkCFunc(ns.GetSanctumType)
            end,
            GetSoulCurrencies = function()
              return checkCFunc(ns.GetSoulCurrencies)
            end,
            HasMaximumRenown = function()
              return checkCFunc(ns.HasMaximumRenown)
            end,
            IsPlayerInRenownCatchUpMode = function()
              return checkCFunc(ns.IsPlayerInRenownCatchUpMode)
            end,
            IsWeeklyRenownCapped = function()
              return checkCFunc(ns.IsWeeklyRenownCapped)
            end,
            RequestCatchUpState = function()
              return checkCFunc(ns.RequestCatchUpState)
            end,
          })
        end,
        C_Covenants = function()
          local ns = _G.C_Covenants
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetActiveCovenantID = function()
              return checkCFunc(ns.GetActiveCovenantID)
            end,
            GetCovenantData = function()
              return checkCFunc(ns.GetCovenantData)
            end,
            GetCovenantIDs = function()
              return checkCFunc(ns.GetCovenantIDs)
            end,
          })
        end,
        C_CreatureInfo = function()
          local ns = _G.C_CreatureInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetClassInfo = function()
              return checkCFunc(ns.GetClassInfo)
            end,
            GetFactionInfo = function()
              return checkCFunc(ns.GetFactionInfo)
            end,
            GetRaceInfo = function()
              return checkCFunc(ns.GetRaceInfo)
            end,
          })
        end,
        C_CurrencyInfo = function()
          local ns = _G.C_CurrencyInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            DoesWarModeBonusApply = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.DoesWarModeBonusApply)
              end
              return checkCFunc(ns.DoesWarModeBonusApply)
            end,
            ExpandCurrencyList = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ExpandCurrencyList)
              end
              return checkCFunc(ns.ExpandCurrencyList)
            end,
            GetAzeriteCurrencyID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAzeriteCurrencyID)
              end
              return checkCFunc(ns.GetAzeriteCurrencyID)
            end,
            GetBackpackCurrencyInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBackpackCurrencyInfo)
              end
              return checkCFunc(ns.GetBackpackCurrencyInfo)
            end,
            GetBasicCurrencyInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBasicCurrencyInfo)
              end
              return checkCFunc(ns.GetBasicCurrencyInfo)
            end,
            GetCurrencyContainerInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCurrencyContainerInfo)
              end
              return checkCFunc(ns.GetCurrencyContainerInfo)
            end,
            GetCurrencyIDFromLink = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCurrencyIDFromLink)
              end
              return checkCFunc(ns.GetCurrencyIDFromLink)
            end,
            GetCurrencyInfo = function()
              return checkCFunc(ns.GetCurrencyInfo)
            end,
            GetCurrencyInfoFromLink = function()
              return checkCFunc(ns.GetCurrencyInfoFromLink)
            end,
            GetCurrencyLink = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCurrencyLink)
              end
              return checkCFunc(ns.GetCurrencyLink)
            end,
            GetCurrencyListInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCurrencyListInfo)
              end
              return checkCFunc(ns.GetCurrencyListInfo)
            end,
            GetCurrencyListLink = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCurrencyListLink)
              end
              return checkCFunc(ns.GetCurrencyListLink)
            end,
            GetCurrencyListSize = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCurrencyListSize)
              end
              return checkCFunc(ns.GetCurrencyListSize)
            end,
            GetFactionGrantedByCurrency = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetFactionGrantedByCurrency)
              end
              return checkCFunc(ns.GetFactionGrantedByCurrency)
            end,
            GetWarResourcesCurrencyID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetWarResourcesCurrencyID)
              end
              return checkCFunc(ns.GetWarResourcesCurrencyID)
            end,
            IsCurrencyContainer = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsCurrencyContainer)
              end
              return checkCFunc(ns.IsCurrencyContainer)
            end,
            PickupCurrency = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.PickupCurrency)
              end
              return checkCFunc(ns.PickupCurrency)
            end,
            SetCurrencyBackpack = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetCurrencyBackpack)
              end
              return checkCFunc(ns.SetCurrencyBackpack)
            end,
            SetCurrencyUnused = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetCurrencyUnused)
              end
              return checkCFunc(ns.SetCurrencyUnused)
            end,
          })
        end,
        C_Cursor = function()
          local ns = _G.C_Cursor
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            DropCursorCommunitiesStream = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.DropCursorCommunitiesStream)
              end
              return checkCFunc(ns.DropCursorCommunitiesStream)
            end,
            GetCursorCommunitiesStream = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCursorCommunitiesStream)
              end
              return checkCFunc(ns.GetCursorCommunitiesStream)
            end,
            GetCursorItem = function()
              return checkCFunc(ns.GetCursorItem)
            end,
            SetCursorCommunitiesStream = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetCursorCommunitiesStream)
              end
              return checkCFunc(ns.SetCursorCommunitiesStream)
            end,
          })
        end,
        C_DateAndTime = function()
          local ns = _G.C_DateAndTime
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AdjustTimeByDays = function()
              return checkCFunc(ns.AdjustTimeByDays)
            end,
            AdjustTimeByMinutes = function()
              return checkCFunc(ns.AdjustTimeByMinutes)
            end,
            CompareCalendarTime = function()
              return checkCFunc(ns.CompareCalendarTime)
            end,
            GetCalendarTimeFromEpoch = function()
              return checkCFunc(ns.GetCalendarTimeFromEpoch)
            end,
            GetCurrentCalendarTime = function()
              return checkCFunc(ns.GetCurrentCalendarTime)
            end,
            GetSecondsUntilDailyReset = function()
              return checkCFunc(ns.GetSecondsUntilDailyReset)
            end,
            GetSecondsUntilWeeklyReset = function()
              return checkCFunc(ns.GetSecondsUntilWeeklyReset)
            end,
            GetServerTimeLocal = function()
              return checkCFunc(ns.GetServerTimeLocal)
            end,
          })
        end,
        C_DeathInfo = function()
          local ns = _G.C_DeathInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetCorpseMapPosition = function()
              return checkCFunc(ns.GetCorpseMapPosition)
            end,
            GetDeathReleasePosition = function()
              return checkCFunc(ns.GetDeathReleasePosition)
            end,
            GetGraveyardsForMap = function()
              return checkCFunc(ns.GetGraveyardsForMap)
            end,
            GetSelfResurrectOptions = function()
              return checkCFunc(ns.GetSelfResurrectOptions)
            end,
            UseSelfResurrectOption = function()
              return checkCFunc(ns.UseSelfResurrectOption)
            end,
          })
        end,
        C_EncounterJournal = function()
          local ns = _G.C_EncounterJournal
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetDungeonEntrancesForMap = function()
              return checkCFunc(ns.GetDungeonEntrancesForMap)
            end,
            GetEncountersOnMap = function()
              return checkCFunc(ns.GetEncountersOnMap)
            end,
            GetLootInfo = function()
              return checkCFunc(ns.GetLootInfo)
            end,
            GetLootInfoByIndex = function()
              return checkCFunc(ns.GetLootInfoByIndex)
            end,
            GetSectionIconFlags = function()
              return checkCFunc(ns.GetSectionIconFlags)
            end,
            GetSectionInfo = function()
              return checkCFunc(ns.GetSectionInfo)
            end,
            GetSlotFilter = function()
              return checkCFunc(ns.GetSlotFilter)
            end,
            InstanceHasLoot = function()
              return checkCFunc(ns.InstanceHasLoot)
            end,
            IsEncounterComplete = function()
              return checkCFunc(ns.IsEncounterComplete)
            end,
            ResetSlotFilter = function()
              return checkCFunc(ns.ResetSlotFilter)
            end,
            SetPreviewMythicPlusLevel = function()
              return checkCFunc(ns.SetPreviewMythicPlusLevel)
            end,
            SetPreviewPvpTier = function()
              return checkCFunc(ns.SetPreviewPvpTier)
            end,
            SetSlotFilter = function()
              return checkCFunc(ns.SetSlotFilter)
            end,
          })
        end,
        C_EquipmentSet = function()
          local ns = _G.C_EquipmentSet
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AssignSpecToEquipmentSet = function()
              return checkCFunc(ns.AssignSpecToEquipmentSet)
            end,
            CanUseEquipmentSets = function()
              return checkCFunc(ns.CanUseEquipmentSets)
            end,
            ClearIgnoredSlotsForSave = function()
              return checkCFunc(ns.ClearIgnoredSlotsForSave)
            end,
            CreateEquipmentSet = function()
              return checkCFunc(ns.CreateEquipmentSet)
            end,
            DeleteEquipmentSet = function()
              return checkCFunc(ns.DeleteEquipmentSet)
            end,
            EquipmentSetContainsLockedItems = function()
              return checkCFunc(ns.EquipmentSetContainsLockedItems)
            end,
            GetEquipmentSetAssignedSpec = function()
              return checkCFunc(ns.GetEquipmentSetAssignedSpec)
            end,
            GetEquipmentSetForSpec = function()
              return checkCFunc(ns.GetEquipmentSetForSpec)
            end,
            GetEquipmentSetID = function()
              return checkCFunc(ns.GetEquipmentSetID)
            end,
            GetEquipmentSetIDs = function()
              return checkCFunc(ns.GetEquipmentSetIDs)
            end,
            GetEquipmentSetInfo = function()
              return checkCFunc(ns.GetEquipmentSetInfo)
            end,
            GetIgnoredSlots = function()
              return checkCFunc(ns.GetIgnoredSlots)
            end,
            GetItemIDs = function()
              return checkCFunc(ns.GetItemIDs)
            end,
            GetItemLocations = function()
              return checkCFunc(ns.GetItemLocations)
            end,
            GetNumEquipmentSets = function()
              return checkCFunc(ns.GetNumEquipmentSets)
            end,
            IgnoreSlotForSave = function()
              return checkCFunc(ns.IgnoreSlotForSave)
            end,
            IsSlotIgnoredForSave = function()
              return checkCFunc(ns.IsSlotIgnoredForSave)
            end,
            ModifyEquipmentSet = function()
              return checkCFunc(ns.ModifyEquipmentSet)
            end,
            PickupEquipmentSet = function()
              return checkCFunc(ns.PickupEquipmentSet)
            end,
            SaveEquipmentSet = function()
              return checkCFunc(ns.SaveEquipmentSet)
            end,
            UnassignEquipmentSetSpec = function()
              return checkCFunc(ns.UnassignEquipmentSetSpec)
            end,
            UnignoreSlotForSave = function()
              return checkCFunc(ns.UnignoreSlotForSave)
            end,
            UseEquipmentSet = function()
              return checkCFunc(ns.UseEquipmentSet)
            end,
          })
        end,
        C_EventToastManager = function()
          local ns = _G.C_EventToastManager
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetLevelUpDisplayToastsFromLevel = function()
              return checkCFunc(ns.GetLevelUpDisplayToastsFromLevel)
            end,
            GetNextToastToDisplay = function()
              return checkCFunc(ns.GetNextToastToDisplay)
            end,
            RemoveCurrentToast = function()
              return checkCFunc(ns.RemoveCurrentToast)
            end,
          })
        end,
        C_FogOfWar = function()
          local ns = _G.C_FogOfWar
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetFogOfWarForMap = function()
              return checkCFunc(ns.GetFogOfWarForMap)
            end,
            GetFogOfWarInfo = function()
              return checkCFunc(ns.GetFogOfWarInfo)
            end,
          })
        end,
        C_FrameManager = function()
          local ns = _G.C_FrameManager
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetFrameVisibilityState = function()
              return checkCFunc(ns.GetFrameVisibilityState)
            end,
          })
        end,
        C_FriendList = function()
          local ns = _G.C_FriendList
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AddFriend = function()
              return checkCFunc(ns.AddFriend)
            end,
            AddIgnore = function()
              return checkCFunc(ns.AddIgnore)
            end,
            AddOrDelIgnore = function()
              return checkCFunc(ns.AddOrDelIgnore)
            end,
            AddOrRemoveFriend = function()
              return checkCFunc(ns.AddOrRemoveFriend)
            end,
            DelIgnore = function()
              return checkCFunc(ns.DelIgnore)
            end,
            DelIgnoreByIndex = function()
              return checkCFunc(ns.DelIgnoreByIndex)
            end,
            GetFriendInfo = function()
              return checkCFunc(ns.GetFriendInfo)
            end,
            GetFriendInfoByIndex = function()
              return checkCFunc(ns.GetFriendInfoByIndex)
            end,
            GetIgnoreName = function()
              return checkCFunc(ns.GetIgnoreName)
            end,
            GetNumFriends = function()
              return checkCFunc(ns.GetNumFriends)
            end,
            GetNumIgnores = function()
              return checkCFunc(ns.GetNumIgnores)
            end,
            GetNumOnlineFriends = function()
              return checkCFunc(ns.GetNumOnlineFriends)
            end,
            GetNumWhoResults = function()
              return checkCFunc(ns.GetNumWhoResults)
            end,
            GetSelectedFriend = function()
              return checkCFunc(ns.GetSelectedFriend)
            end,
            GetSelectedIgnore = function()
              return checkCFunc(ns.GetSelectedIgnore)
            end,
            GetWhoInfo = function()
              return checkCFunc(ns.GetWhoInfo)
            end,
            IsFriend = function()
              return checkCFunc(ns.IsFriend)
            end,
            IsIgnored = function()
              return checkCFunc(ns.IsIgnored)
            end,
            IsIgnoredByGuid = function()
              return checkCFunc(ns.IsIgnoredByGuid)
            end,
            IsOnIgnoredList = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsOnIgnoredList)
              end
              return checkCFunc(ns.IsOnIgnoredList)
            end,
            RemoveFriend = function()
              return checkCFunc(ns.RemoveFriend)
            end,
            RemoveFriendByIndex = function()
              return checkCFunc(ns.RemoveFriendByIndex)
            end,
            SendWho = function()
              return checkCFunc(ns.SendWho)
            end,
            SetFriendNotes = function()
              return checkCFunc(ns.SetFriendNotes)
            end,
            SetFriendNotesByIndex = function()
              return checkCFunc(ns.SetFriendNotesByIndex)
            end,
            SetSelectedFriend = function()
              return checkCFunc(ns.SetSelectedFriend)
            end,
            SetSelectedIgnore = function()
              return checkCFunc(ns.SetSelectedIgnore)
            end,
            SetWhoToUi = function()
              return checkCFunc(ns.SetWhoToUi)
            end,
            ShowFriends = function()
              return checkCFunc(ns.ShowFriends)
            end,
            SortWho = function()
              return checkCFunc(ns.SortWho)
            end,
          })
        end,
        C_GamePad = function()
          local ns = _G.C_GamePad
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AddSDLMapping = function()
              return checkCFunc(ns.AddSDLMapping)
            end,
            ApplyConfigs = function()
              return checkCFunc(ns.ApplyConfigs)
            end,
            AxisIndexToConfigName = function()
              return checkCFunc(ns.AxisIndexToConfigName)
            end,
            ButtonBindingToIndex = function()
              return checkCFunc(ns.ButtonBindingToIndex)
            end,
            ButtonIndexToBinding = function()
              return checkCFunc(ns.ButtonIndexToBinding)
            end,
            ButtonIndexToConfigName = function()
              return checkCFunc(ns.ButtonIndexToConfigName)
            end,
            ClearLedColor = function()
              return checkCFunc(ns.ClearLedColor)
            end,
            DeleteConfig = function()
              return checkCFunc(ns.DeleteConfig)
            end,
            GetActiveDeviceID = function()
              return checkCFunc(ns.GetActiveDeviceID)
            end,
            GetAllConfigIDs = function()
              return checkCFunc(ns.GetAllConfigIDs)
            end,
            GetAllDeviceIDs = function()
              return checkCFunc(ns.GetAllDeviceIDs)
            end,
            GetCombinedDeviceID = function()
              return checkCFunc(ns.GetCombinedDeviceID)
            end,
            GetConfig = function()
              return checkCFunc(ns.GetConfig)
            end,
            GetDeviceMappedState = function()
              return checkCFunc(ns.GetDeviceMappedState)
            end,
            GetDeviceRawState = function()
              return checkCFunc(ns.GetDeviceRawState)
            end,
            GetLedColor = function()
              return checkCFunc(ns.GetLedColor)
            end,
            GetPowerLevel = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetPowerLevel)
              end
              return checkCFunc(ns.GetPowerLevel)
            end,
            IsEnabled = function()
              return checkCFunc(ns.IsEnabled)
            end,
            SetConfig = function()
              return checkCFunc(ns.SetConfig)
            end,
            SetLedColor = function()
              return checkCFunc(ns.SetLedColor)
            end,
            SetVibration = function()
              return checkCFunc(ns.SetVibration)
            end,
            StickIndexToConfigName = function()
              return checkCFunc(ns.StickIndexToConfigName)
            end,
            StopVibration = function()
              return checkCFunc(ns.StopVibration)
            end,
          })
        end,
        C_Garrison = function()
          local ns = _G.C_Garrison
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AddFollowerToMission = function()
              return checkCFunc(ns.AddFollowerToMission)
            end,
            AllowMissionStartAboveSoftCap = function()
              return checkCFunc(ns.AllowMissionStartAboveSoftCap)
            end,
            AreMissionFollowerRequirementsMet = function()
              return checkCFunc(ns.AreMissionFollowerRequirementsMet)
            end,
            AssignFollowerToBuilding = function()
              return checkCFunc(ns.AssignFollowerToBuilding)
            end,
            CanGenerateRecruits = function()
              return checkCFunc(ns.CanGenerateRecruits)
            end,
            CanOpenMissionChest = function()
              return checkCFunc(ns.CanOpenMissionChest)
            end,
            CanSetRecruitmentPreference = function()
              return checkCFunc(ns.CanSetRecruitmentPreference)
            end,
            CanSpellTargetFollowerIDWithAddAbility = function()
              return checkCFunc(ns.CanSpellTargetFollowerIDWithAddAbility)
            end,
            CanUpgradeGarrison = function()
              return checkCFunc(ns.CanUpgradeGarrison)
            end,
            CancelConstruction = function()
              return checkCFunc(ns.CancelConstruction)
            end,
            CastItemSpellOnFollowerAbility = function()
              return checkCFunc(ns.CastItemSpellOnFollowerAbility)
            end,
            CastSpellOnFollower = function()
              return checkCFunc(ns.CastSpellOnFollower)
            end,
            CastSpellOnFollowerAbility = function()
              return checkCFunc(ns.CastSpellOnFollowerAbility)
            end,
            CastSpellOnMission = function()
              return checkCFunc(ns.CastSpellOnMission)
            end,
            ClearCompleteTalent = function()
              return checkCFunc(ns.ClearCompleteTalent)
            end,
            CloseArchitect = function()
              return checkCFunc(ns.CloseArchitect)
            end,
            CloseGarrisonTradeskillNPC = function()
              return checkCFunc(ns.CloseGarrisonTradeskillNPC)
            end,
            CloseMissionNPC = function()
              return checkCFunc(ns.CloseMissionNPC)
            end,
            CloseRecruitmentNPC = function()
              return checkCFunc(ns.CloseRecruitmentNPC)
            end,
            CloseTalentNPC = function()
              return checkCFunc(ns.CloseTalentNPC)
            end,
            CloseTradeskillCrafter = function()
              return checkCFunc(ns.CloseTradeskillCrafter)
            end,
            GenerateRecruits = function()
              return checkCFunc(ns.GenerateRecruits)
            end,
            GetAllBonusAbilityEffects = function()
              return checkCFunc(ns.GetAllBonusAbilityEffects)
            end,
            GetAllEncounterThreats = function()
              return checkCFunc(ns.GetAllEncounterThreats)
            end,
            GetAutoCombatDamageClassValues = function()
              return checkCFunc(ns.GetAutoCombatDamageClassValues)
            end,
            GetAutoMissionBoardState = function()
              return checkCFunc(ns.GetAutoMissionBoardState)
            end,
            GetAutoMissionEnvironmentEffect = function()
              return checkCFunc(ns.GetAutoMissionEnvironmentEffect)
            end,
            GetAutoMissionTargetingInfo = function()
              return checkCFunc(ns.GetAutoMissionTargetingInfo)
            end,
            GetAutoMissionTargetingInfoForSpell = function()
              return checkCFunc(ns.GetAutoMissionTargetingInfoForSpell)
            end,
            GetAutoTroops = function()
              return checkCFunc(ns.GetAutoTroops)
            end,
            GetAvailableMissions = function()
              return checkCFunc(ns.GetAvailableMissions)
            end,
            GetAvailableRecruits = function()
              return checkCFunc(ns.GetAvailableRecruits)
            end,
            GetBasicMissionInfo = function()
              return checkCFunc(ns.GetBasicMissionInfo)
            end,
            GetBuffedFollowersForMission = function()
              return checkCFunc(ns.GetBuffedFollowersForMission)
            end,
            GetBuildingInfo = function()
              return checkCFunc(ns.GetBuildingInfo)
            end,
            GetBuildingLockInfo = function()
              return checkCFunc(ns.GetBuildingLockInfo)
            end,
            GetBuildingSizes = function()
              return checkCFunc(ns.GetBuildingSizes)
            end,
            GetBuildingSpecInfo = function()
              return checkCFunc(ns.GetBuildingSpecInfo)
            end,
            GetBuildingTimeRemaining = function()
              return checkCFunc(ns.GetBuildingTimeRemaining)
            end,
            GetBuildingTooltip = function()
              return checkCFunc(ns.GetBuildingTooltip)
            end,
            GetBuildingUpgradeInfo = function()
              return checkCFunc(ns.GetBuildingUpgradeInfo)
            end,
            GetBuildings = function()
              return checkCFunc(ns.GetBuildings)
            end,
            GetBuildingsForPlot = function()
              return checkCFunc(ns.GetBuildingsForPlot)
            end,
            GetBuildingsForSize = function()
              return checkCFunc(ns.GetBuildingsForSize)
            end,
            GetClassSpecCategoryInfo = function()
              return checkCFunc(ns.GetClassSpecCategoryInfo)
            end,
            GetCombatAllyMission = function()
              return checkCFunc(ns.GetCombatAllyMission)
            end,
            GetCombatLogSpellInfo = function()
              return checkCFunc(ns.GetCombatLogSpellInfo)
            end,
            GetCompleteMissions = function()
              return checkCFunc(ns.GetCompleteMissions)
            end,
            GetCompleteTalent = function()
              return checkCFunc(ns.GetCompleteTalent)
            end,
            GetCurrencyTypes = function()
              return checkCFunc(ns.GetCurrencyTypes)
            end,
            GetCurrentCypherEquipmentLevel = function()
              return checkCFunc(ns.GetCurrentCypherEquipmentLevel)
            end,
            GetCurrentGarrTalentTreeFriendshipFactionID = function()
              return checkCFunc(ns.GetCurrentGarrTalentTreeFriendshipFactionID)
            end,
            GetCurrentGarrTalentTreeID = function()
              return checkCFunc(ns.GetCurrentGarrTalentTreeID)
            end,
            GetCyphersToNextEquipmentLevel = function()
              return checkCFunc(ns.GetCyphersToNextEquipmentLevel)
            end,
            GetFollowerAbilities = function()
              return checkCFunc(ns.GetFollowerAbilities)
            end,
            GetFollowerAbilityAtIndex = function()
              return checkCFunc(ns.GetFollowerAbilityAtIndex)
            end,
            GetFollowerAbilityAtIndexByID = function()
              return checkCFunc(ns.GetFollowerAbilityAtIndexByID)
            end,
            GetFollowerAbilityCounterMechanicInfo = function()
              return checkCFunc(ns.GetFollowerAbilityCounterMechanicInfo)
            end,
            GetFollowerAbilityCountersForMechanicTypes = function()
              return checkCFunc(ns.GetFollowerAbilityCountersForMechanicTypes)
            end,
            GetFollowerAbilityDescription = function()
              return checkCFunc(ns.GetFollowerAbilityDescription)
            end,
            GetFollowerAbilityIcon = function()
              return checkCFunc(ns.GetFollowerAbilityIcon)
            end,
            GetFollowerAbilityInfo = function()
              return checkCFunc(ns.GetFollowerAbilityInfo)
            end,
            GetFollowerAbilityIsTrait = function()
              return checkCFunc(ns.GetFollowerAbilityIsTrait)
            end,
            GetFollowerAbilityLink = function()
              return checkCFunc(ns.GetFollowerAbilityLink)
            end,
            GetFollowerAbilityName = function()
              return checkCFunc(ns.GetFollowerAbilityName)
            end,
            GetFollowerActivationCost = function()
              return checkCFunc(ns.GetFollowerActivationCost)
            end,
            GetFollowerAutoCombatSpells = function()
              return checkCFunc(ns.GetFollowerAutoCombatSpells)
            end,
            GetFollowerAutoCombatStats = function()
              return checkCFunc(ns.GetFollowerAutoCombatStats)
            end,
            GetFollowerBiasForMission = function()
              return checkCFunc(ns.GetFollowerBiasForMission)
            end,
            GetFollowerClassSpec = function()
              return checkCFunc(ns.GetFollowerClassSpec)
            end,
            GetFollowerClassSpecAtlas = function()
              return checkCFunc(ns.GetFollowerClassSpecAtlas)
            end,
            GetFollowerClassSpecByID = function()
              return checkCFunc(ns.GetFollowerClassSpecByID)
            end,
            GetFollowerClassSpecName = function()
              return checkCFunc(ns.GetFollowerClassSpecName)
            end,
            GetFollowerDisplayID = function()
              return checkCFunc(ns.GetFollowerDisplayID)
            end,
            GetFollowerInfo = function()
              return checkCFunc(ns.GetFollowerInfo)
            end,
            GetFollowerInfoForBuilding = function()
              return checkCFunc(ns.GetFollowerInfoForBuilding)
            end,
            GetFollowerIsTroop = function()
              return checkCFunc(ns.GetFollowerIsTroop)
            end,
            GetFollowerItemLevelAverage = function()
              return checkCFunc(ns.GetFollowerItemLevelAverage)
            end,
            GetFollowerItems = function()
              return checkCFunc(ns.GetFollowerItems)
            end,
            GetFollowerLevel = function()
              return checkCFunc(ns.GetFollowerLevel)
            end,
            GetFollowerLevelXP = function()
              return checkCFunc(ns.GetFollowerLevelXP)
            end,
            GetFollowerLink = function()
              return checkCFunc(ns.GetFollowerLink)
            end,
            GetFollowerLinkByID = function()
              return checkCFunc(ns.GetFollowerLinkByID)
            end,
            GetFollowerMissionCompleteInfo = function()
              return checkCFunc(ns.GetFollowerMissionCompleteInfo)
            end,
            GetFollowerMissionTimeLeft = function()
              return checkCFunc(ns.GetFollowerMissionTimeLeft)
            end,
            GetFollowerMissionTimeLeftSeconds = function()
              return checkCFunc(ns.GetFollowerMissionTimeLeftSeconds)
            end,
            GetFollowerModelItems = function()
              return checkCFunc(ns.GetFollowerModelItems)
            end,
            GetFollowerName = function()
              return checkCFunc(ns.GetFollowerName)
            end,
            GetFollowerNameByID = function()
              return checkCFunc(ns.GetFollowerNameByID)
            end,
            GetFollowerPortraitIconID = function()
              return checkCFunc(ns.GetFollowerPortraitIconID)
            end,
            GetFollowerPortraitIconIDByID = function()
              return checkCFunc(ns.GetFollowerPortraitIconIDByID)
            end,
            GetFollowerQuality = function()
              return checkCFunc(ns.GetFollowerQuality)
            end,
            GetFollowerQualityTable = function()
              return checkCFunc(ns.GetFollowerQualityTable)
            end,
            GetFollowerRecentlyGainedAbilityIDs = function()
              return checkCFunc(ns.GetFollowerRecentlyGainedAbilityIDs)
            end,
            GetFollowerRecentlyGainedTraitIDs = function()
              return checkCFunc(ns.GetFollowerRecentlyGainedTraitIDs)
            end,
            GetFollowerShipments = function()
              return checkCFunc(ns.GetFollowerShipments)
            end,
            GetFollowerSoftCap = function()
              return checkCFunc(ns.GetFollowerSoftCap)
            end,
            GetFollowerSourceTextByID = function()
              return checkCFunc(ns.GetFollowerSourceTextByID)
            end,
            GetFollowerSpecializationAtIndex = function()
              return checkCFunc(ns.GetFollowerSpecializationAtIndex)
            end,
            GetFollowerStatus = function()
              return checkCFunc(ns.GetFollowerStatus)
            end,
            GetFollowerTraitAtIndex = function()
              return checkCFunc(ns.GetFollowerTraitAtIndex)
            end,
            GetFollowerTraitAtIndexByID = function()
              return checkCFunc(ns.GetFollowerTraitAtIndexByID)
            end,
            GetFollowerTypeByID = function()
              return checkCFunc(ns.GetFollowerTypeByID)
            end,
            GetFollowerTypeByMissionID = function()
              return checkCFunc(ns.GetFollowerTypeByMissionID)
            end,
            GetFollowerUnderBiasReason = function()
              return checkCFunc(ns.GetFollowerUnderBiasReason)
            end,
            GetFollowerXP = function()
              return checkCFunc(ns.GetFollowerXP)
            end,
            GetFollowerXPTable = function()
              return checkCFunc(ns.GetFollowerXPTable)
            end,
            GetFollowerZoneSupportAbilities = function()
              return checkCFunc(ns.GetFollowerZoneSupportAbilities)
            end,
            GetFollowers = function()
              return checkCFunc(ns.GetFollowers)
            end,
            GetFollowersSpellsForMission = function()
              return checkCFunc(ns.GetFollowersSpellsForMission)
            end,
            GetFollowersTraitsForMission = function()
              return checkCFunc(ns.GetFollowersTraitsForMission)
            end,
            GetGarrisonInfo = function()
              return checkCFunc(ns.GetGarrisonInfo)
            end,
            GetGarrisonPlotsInstancesForMap = function()
              return checkCFunc(ns.GetGarrisonPlotsInstancesForMap)
            end,
            GetGarrisonTalentTreeCurrencyTypes = function()
              return checkCFunc(ns.GetGarrisonTalentTreeCurrencyTypes)
            end,
            GetGarrisonTalentTreeType = function()
              return checkCFunc(ns.GetGarrisonTalentTreeType)
            end,
            GetGarrisonUpgradeCost = function()
              return checkCFunc(ns.GetGarrisonUpgradeCost)
            end,
            GetInProgressMissions = function()
              return checkCFunc(ns.GetInProgressMissions)
            end,
            GetLandingPageGarrisonType = function()
              return checkCFunc(ns.GetLandingPageGarrisonType)
            end,
            GetLandingPageItems = function()
              return checkCFunc(ns.GetLandingPageItems)
            end,
            GetLandingPageShipmentCount = function()
              return checkCFunc(ns.GetLandingPageShipmentCount)
            end,
            GetLandingPageShipmentInfo = function()
              return checkCFunc(ns.GetLandingPageShipmentInfo)
            end,
            GetLandingPageShipmentInfoByContainerID = function()
              return checkCFunc(ns.GetLandingPageShipmentInfoByContainerID)
            end,
            GetLooseShipments = function()
              return checkCFunc(ns.GetLooseShipments)
            end,
            GetMaxCypherEquipmentLevel = function()
              return checkCFunc(ns.GetMaxCypherEquipmentLevel)
            end,
            GetMissionBonusAbilityEffects = function()
              return checkCFunc(ns.GetMissionBonusAbilityEffects)
            end,
            GetMissionCompleteEncounters = function()
              return checkCFunc(ns.GetMissionCompleteEncounters)
            end,
            GetMissionCost = function()
              return checkCFunc(ns.GetMissionCost)
            end,
            GetMissionDeploymentInfo = function()
              return checkCFunc(ns.GetMissionDeploymentInfo)
            end,
            GetMissionDisplayIDs = function()
              return checkCFunc(ns.GetMissionDisplayIDs)
            end,
            GetMissionEncounterIconInfo = function()
              return checkCFunc(ns.GetMissionEncounterIconInfo)
            end,
            GetMissionLink = function()
              return checkCFunc(ns.GetMissionLink)
            end,
            GetMissionMaxFollowers = function()
              return checkCFunc(ns.GetMissionMaxFollowers)
            end,
            GetMissionName = function()
              return checkCFunc(ns.GetMissionName)
            end,
            GetMissionRewardInfo = function()
              return checkCFunc(ns.GetMissionRewardInfo)
            end,
            GetMissionSuccessChance = function()
              return checkCFunc(ns.GetMissionSuccessChance)
            end,
            GetMissionTexture = function()
              return checkCFunc(ns.GetMissionTexture)
            end,
            GetMissionTimes = function()
              return checkCFunc(ns.GetMissionTimes)
            end,
            GetMissionUncounteredMechanics = function()
              return checkCFunc(ns.GetMissionUncounteredMechanics)
            end,
            GetNumActiveFollowers = function()
              return checkCFunc(ns.GetNumActiveFollowers)
            end,
            GetNumFollowerActivationsRemaining = function()
              return checkCFunc(ns.GetNumFollowerActivationsRemaining)
            end,
            GetNumFollowerDailyActivations = function()
              return checkCFunc(ns.GetNumFollowerDailyActivations)
            end,
            GetNumFollowers = function()
              return checkCFunc(ns.GetNumFollowers)
            end,
            GetNumFollowersForMechanic = function()
              return checkCFunc(ns.GetNumFollowersForMechanic)
            end,
            GetNumFollowersOnMission = function()
              return checkCFunc(ns.GetNumFollowersOnMission)
            end,
            GetNumPendingShipments = function()
              return checkCFunc(ns.GetNumPendingShipments)
            end,
            GetNumShipmentCurrencies = function()
              return checkCFunc(ns.GetNumShipmentCurrencies)
            end,
            GetNumShipmentReagents = function()
              return checkCFunc(ns.GetNumShipmentReagents)
            end,
            GetOwnedBuildingInfo = function()
              return checkCFunc(ns.GetOwnedBuildingInfo)
            end,
            GetOwnedBuildingInfoAbbrev = function()
              return checkCFunc(ns.GetOwnedBuildingInfoAbbrev)
            end,
            GetPartyBuffs = function()
              return checkCFunc(ns.GetPartyBuffs)
            end,
            GetPartyMentorLevels = function()
              return checkCFunc(ns.GetPartyMentorLevels)
            end,
            GetPartyMissionInfo = function()
              return checkCFunc(ns.GetPartyMissionInfo)
            end,
            GetPendingShipmentInfo = function()
              return checkCFunc(ns.GetPendingShipmentInfo)
            end,
            GetPlots = function()
              return checkCFunc(ns.GetPlots)
            end,
            GetPlotsForBuilding = function()
              return checkCFunc(ns.GetPlotsForBuilding)
            end,
            GetPossibleFollowersForBuilding = function()
              return checkCFunc(ns.GetPossibleFollowersForBuilding)
            end,
            GetRecruitAbilities = function()
              return checkCFunc(ns.GetRecruitAbilities)
            end,
            GetRecruiterAbilityCategories = function()
              return checkCFunc(ns.GetRecruiterAbilityCategories)
            end,
            GetRecruiterAbilityList = function()
              return checkCFunc(ns.GetRecruiterAbilityList)
            end,
            GetRecruitmentPreferences = function()
              return checkCFunc(ns.GetRecruitmentPreferences)
            end,
            GetShipDeathAnimInfo = function()
              return checkCFunc(ns.GetShipDeathAnimInfo)
            end,
            GetShipmentContainerInfo = function()
              return checkCFunc(ns.GetShipmentContainerInfo)
            end,
            GetShipmentItemInfo = function()
              return checkCFunc(ns.GetShipmentItemInfo)
            end,
            GetShipmentReagentCurrencyInfo = function()
              return checkCFunc(ns.GetShipmentReagentCurrencyInfo)
            end,
            GetShipmentReagentInfo = function()
              return checkCFunc(ns.GetShipmentReagentInfo)
            end,
            GetShipmentReagentItemLink = function()
              return checkCFunc(ns.GetShipmentReagentItemLink)
            end,
            GetSpecChangeCost = function()
              return checkCFunc(ns.GetSpecChangeCost)
            end,
            GetTabForPlot = function()
              return checkCFunc(ns.GetTabForPlot)
            end,
            GetTalentInfo = function()
              return checkCFunc(ns.GetTalentInfo)
            end,
            GetTalentPointsSpentInTalentTree = function()
              return checkCFunc(ns.GetTalentPointsSpentInTalentTree)
            end,
            GetTalentTreeIDsByClassID = function()
              return checkCFunc(ns.GetTalentTreeIDsByClassID)
            end,
            GetTalentTreeInfo = function()
              return checkCFunc(ns.GetTalentTreeInfo)
            end,
            GetTalentTreeResetInfo = function()
              return checkCFunc(ns.GetTalentTreeResetInfo)
            end,
            GetTalentTreeTalentPointResearchInfo = function()
              return checkCFunc(ns.GetTalentTreeTalentPointResearchInfo)
            end,
            GetTalentUnlockWorldQuest = function()
              return checkCFunc(ns.GetTalentUnlockWorldQuest)
            end,
            HasAdventures = function()
              return checkCFunc(ns.HasAdventures)
            end,
            HasGarrison = function()
              return checkCFunc(ns.HasGarrison)
            end,
            HasShipyard = function()
              return checkCFunc(ns.HasShipyard)
            end,
            IsAboveFollowerSoftCap = function()
              return checkCFunc(ns.IsAboveFollowerSoftCap)
            end,
            IsAtGarrisonMissionNPC = function()
              return checkCFunc(ns.IsAtGarrisonMissionNPC)
            end,
            IsEnvironmentCountered = function()
              return checkCFunc(ns.IsEnvironmentCountered)
            end,
            IsFollowerCollected = function()
              return checkCFunc(ns.IsFollowerCollected)
            end,
            IsFollowerOnCompletedMission = function()
              return checkCFunc(ns.IsFollowerOnCompletedMission)
            end,
            IsInvasionAvailable = function()
              return checkCFunc(ns.IsInvasionAvailable)
            end,
            IsMechanicFullyCountered = function()
              return checkCFunc(ns.IsMechanicFullyCountered)
            end,
            IsOnGarrisonMap = function()
              return checkCFunc(ns.IsOnGarrisonMap)
            end,
            IsOnShipmentQuestForNPC = function()
              return checkCFunc(ns.IsOnShipmentQuestForNPC)
            end,
            IsOnShipyardMap = function()
              return checkCFunc(ns.IsOnShipyardMap)
            end,
            IsPlayerInGarrison = function()
              return checkCFunc(ns.IsPlayerInGarrison)
            end,
            IsTalentConditionMet = function()
              return checkCFunc(ns.IsTalentConditionMet)
            end,
            IsUsingPartyGarrison = function()
              return checkCFunc(ns.IsUsingPartyGarrison)
            end,
            IsVisitGarrisonAvailable = function()
              return checkCFunc(ns.IsVisitGarrisonAvailable)
            end,
            MarkMissionComplete = function()
              return checkCFunc(ns.MarkMissionComplete)
            end,
            MissionBonusRoll = function()
              return checkCFunc(ns.MissionBonusRoll)
            end,
            PlaceBuilding = function()
              return checkCFunc(ns.PlaceBuilding)
            end,
            RecruitFollower = function()
              return checkCFunc(ns.RecruitFollower)
            end,
            RegenerateCombatLog = function()
              return checkCFunc(ns.RegenerateCombatLog)
            end,
            RemoveFollower = function()
              return checkCFunc(ns.RemoveFollower)
            end,
            RemoveFollowerFromBuilding = function()
              return checkCFunc(ns.RemoveFollowerFromBuilding)
            end,
            RemoveFollowerFromMission = function()
              return checkCFunc(ns.RemoveFollowerFromMission)
            end,
            RenameFollower = function()
              return checkCFunc(ns.RenameFollower)
            end,
            RequestClassSpecCategoryInfo = function()
              return checkCFunc(ns.RequestClassSpecCategoryInfo)
            end,
            RequestGarrisonUpgradeable = function()
              return checkCFunc(ns.RequestGarrisonUpgradeable)
            end,
            RequestLandingPageShipmentInfo = function()
              return checkCFunc(ns.RequestLandingPageShipmentInfo)
            end,
            RequestShipmentCreation = function()
              return checkCFunc(ns.RequestShipmentCreation)
            end,
            RequestShipmentInfo = function()
              return checkCFunc(ns.RequestShipmentInfo)
            end,
            ResearchTalent = function()
              return checkCFunc(ns.ResearchTalent)
            end,
            RushHealAllFollowers = function()
              return checkCFunc(ns.RushHealAllFollowers)
            end,
            RushHealFollower = function()
              return checkCFunc(ns.RushHealFollower)
            end,
            SearchForFollower = function()
              return checkCFunc(ns.SearchForFollower)
            end,
            SetAutoCombatSpellFastForward = function()
              return checkCFunc(ns.SetAutoCombatSpellFastForward)
            end,
            SetBuildingActive = function()
              return checkCFunc(ns.SetBuildingActive)
            end,
            SetBuildingSpecialization = function()
              return checkCFunc(ns.SetBuildingSpecialization)
            end,
            SetFollowerFavorite = function()
              return checkCFunc(ns.SetFollowerFavorite)
            end,
            SetFollowerInactive = function()
              return checkCFunc(ns.SetFollowerInactive)
            end,
            SetRecruitmentPreferences = function()
              return checkCFunc(ns.SetRecruitmentPreferences)
            end,
            SetUsingPartyGarrison = function()
              return checkCFunc(ns.SetUsingPartyGarrison)
            end,
            ShouldShowMapTab = function()
              return checkCFunc(ns.ShouldShowMapTab)
            end,
            ShowFollowerNameInErrorMessage = function()
              return checkCFunc(ns.ShowFollowerNameInErrorMessage)
            end,
            StartMission = function()
              return checkCFunc(ns.StartMission)
            end,
            SwapBuildings = function()
              return checkCFunc(ns.SwapBuildings)
            end,
            TargetSpellHasFollowerItemLevelUpgrade = function()
              return checkCFunc(ns.TargetSpellHasFollowerItemLevelUpgrade)
            end,
            TargetSpellHasFollowerReroll = function()
              return checkCFunc(ns.TargetSpellHasFollowerReroll)
            end,
            TargetSpellHasFollowerTemporaryAbility = function()
              return checkCFunc(ns.TargetSpellHasFollowerTemporaryAbility)
            end,
            UpgradeBuilding = function()
              return checkCFunc(ns.UpgradeBuilding)
            end,
            UpgradeGarrison = function()
              return checkCFunc(ns.UpgradeGarrison)
            end,
          })
        end,
        C_GossipInfo = function()
          local ns = _G.C_GossipInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CloseGossip = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CloseGossip)
              end
              return checkCFunc(ns.CloseGossip)
            end,
            ForceGossip = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ForceGossip)
              end
              return checkCFunc(ns.ForceGossip)
            end,
            GetActiveQuests = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetActiveQuests)
              end
              return checkCFunc(ns.GetActiveQuests)
            end,
            GetAvailableQuests = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAvailableQuests)
              end
              return checkCFunc(ns.GetAvailableQuests)
            end,
            GetCompletedOptionDescriptionString = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCompletedOptionDescriptionString)
              end
              return checkCFunc(ns.GetCompletedOptionDescriptionString)
            end,
            GetCustomGossipDescriptionString = function()
              return checkCFunc(ns.GetCustomGossipDescriptionString)
            end,
            GetNumActiveQuests = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumActiveQuests)
              end
              return checkCFunc(ns.GetNumActiveQuests)
            end,
            GetNumAvailableQuests = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumAvailableQuests)
              end
              return checkCFunc(ns.GetNumAvailableQuests)
            end,
            GetNumOptions = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumOptions)
              end
              return checkCFunc(ns.GetNumOptions)
            end,
            GetOptions = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetOptions)
              end
              return checkCFunc(ns.GetOptions)
            end,
            GetPoiForUiMapID = function()
              return checkCFunc(ns.GetPoiForUiMapID)
            end,
            GetPoiInfo = function()
              return checkCFunc(ns.GetPoiInfo)
            end,
            GetText = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetText)
              end
              return checkCFunc(ns.GetText)
            end,
            RefreshOptions = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.RefreshOptions)
              end
              return checkCFunc(ns.RefreshOptions)
            end,
            SelectActiveQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SelectActiveQuest)
              end
              return checkCFunc(ns.SelectActiveQuest)
            end,
            SelectAvailableQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SelectAvailableQuest)
              end
              return checkCFunc(ns.SelectAvailableQuest)
            end,
            SelectOption = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SelectOption)
              end
              return checkCFunc(ns.SelectOption)
            end,
          })
        end,
        C_GuildInfo = function()
          local ns = _G.C_GuildInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanEditOfficerNote = function()
              return checkCFunc(ns.CanEditOfficerNote)
            end,
            CanSpeakInGuildChat = function()
              return checkCFunc(ns.CanSpeakInGuildChat)
            end,
            CanViewOfficerNote = function()
              return checkCFunc(ns.CanViewOfficerNote)
            end,
            GetGuildNewsInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetGuildNewsInfo)
              end
              return checkCFunc(ns.GetGuildNewsInfo)
            end,
            GetGuildRankOrder = function()
              return checkCFunc(ns.GetGuildRankOrder)
            end,
            GetGuildTabardInfo = function()
              return checkCFunc(ns.GetGuildTabardInfo)
            end,
            GuildControlGetRankFlags = function()
              return checkCFunc(ns.GuildControlGetRankFlags)
            end,
            GuildRoster = function()
              return checkCFunc(ns.GuildRoster)
            end,
            IsGuildOfficer = function()
              return checkCFunc(ns.IsGuildOfficer)
            end,
            IsGuildRankAssignmentAllowed = function()
              return checkCFunc(ns.IsGuildRankAssignmentAllowed)
            end,
            QueryGuildMemberRecipes = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.QueryGuildMemberRecipes)
              end
              return checkCFunc(ns.QueryGuildMemberRecipes)
            end,
            QueryGuildMembersForRecipe = function()
              return checkCFunc(ns.QueryGuildMembersForRecipe)
            end,
            RemoveFromGuild = function()
              return checkCFunc(ns.RemoveFromGuild)
            end,
            SetGuildRankOrder = function()
              return checkCFunc(ns.SetGuildRankOrder)
            end,
            SetNote = function()
              return checkCFunc(ns.SetNote)
            end,
          })
        end,
        C_Heirloom = function()
          local ns = _G.C_Heirloom
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanHeirloomUpgradeFromPending = function()
              return checkCFunc(ns.CanHeirloomUpgradeFromPending)
            end,
            CreateHeirloom = function()
              return checkCFunc(ns.CreateHeirloom)
            end,
            GetClassAndSpecFilters = function()
              return checkCFunc(ns.GetClassAndSpecFilters)
            end,
            GetCollectedHeirloomFilter = function()
              return checkCFunc(ns.GetCollectedHeirloomFilter)
            end,
            GetHeirloomInfo = function()
              return checkCFunc(ns.GetHeirloomInfo)
            end,
            GetHeirloomItemIDFromDisplayedIndex = function()
              return checkCFunc(ns.GetHeirloomItemIDFromDisplayedIndex)
            end,
            GetHeirloomItemIDs = function()
              return checkCFunc(ns.GetHeirloomItemIDs)
            end,
            GetHeirloomLink = function()
              return checkCFunc(ns.GetHeirloomLink)
            end,
            GetHeirloomMaxUpgradeLevel = function()
              return checkCFunc(ns.GetHeirloomMaxUpgradeLevel)
            end,
            GetHeirloomSourceFilter = function()
              return checkCFunc(ns.GetHeirloomSourceFilter)
            end,
            GetNumDisplayedHeirlooms = function()
              return checkCFunc(ns.GetNumDisplayedHeirlooms)
            end,
            GetNumHeirlooms = function()
              return checkCFunc(ns.GetNumHeirlooms)
            end,
            GetNumKnownHeirlooms = function()
              return checkCFunc(ns.GetNumKnownHeirlooms)
            end,
            GetUncollectedHeirloomFilter = function()
              return checkCFunc(ns.GetUncollectedHeirloomFilter)
            end,
            IsItemHeirloom = function()
              return checkCFunc(ns.IsItemHeirloom)
            end,
            IsPendingHeirloomUpgrade = function()
              return checkCFunc(ns.IsPendingHeirloomUpgrade)
            end,
            PlayerHasHeirloom = function()
              return checkCFunc(ns.PlayerHasHeirloom)
            end,
            SetClassAndSpecFilters = function()
              return checkCFunc(ns.SetClassAndSpecFilters)
            end,
            SetCollectedHeirloomFilter = function()
              return checkCFunc(ns.SetCollectedHeirloomFilter)
            end,
            SetHeirloomSourceFilter = function()
              return checkCFunc(ns.SetHeirloomSourceFilter)
            end,
            SetSearch = function()
              return checkCFunc(ns.SetSearch)
            end,
            SetUncollectedHeirloomFilter = function()
              return checkCFunc(ns.SetUncollectedHeirloomFilter)
            end,
            ShouldShowHeirloomHelp = function()
              return checkCFunc(ns.ShouldShowHeirloomHelp)
            end,
            UpgradeHeirloom = function()
              return checkCFunc(ns.UpgradeHeirloom)
            end,
          })
        end,
        C_HeirloomInfo = function()
          local ns = _G.C_HeirloomInfo
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AreAllCollectionFiltersChecked = function()
              return checkCFunc(ns.AreAllCollectionFiltersChecked)
            end,
            AreAllSourceFiltersChecked = function()
              return checkCFunc(ns.AreAllSourceFiltersChecked)
            end,
            IsHeirloomSourceValid = function()
              return checkCFunc(ns.IsHeirloomSourceValid)
            end,
            IsUsingDefaultFilters = function()
              return checkCFunc(ns.IsUsingDefaultFilters)
            end,
            SetAllCollectionFilters = function()
              return checkCFunc(ns.SetAllCollectionFilters)
            end,
            SetAllSourceFilters = function()
              return checkCFunc(ns.SetAllSourceFilters)
            end,
            SetDefaultFilters = function()
              return checkCFunc(ns.SetDefaultFilters)
            end,
          })
        end,
        C_IncomingSummon = function()
          local ns = _G.C_IncomingSummon
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            HasIncomingSummon = function()
              return checkCFunc(ns.HasIncomingSummon)
            end,
            IncomingSummonStatus = function()
              return checkCFunc(ns.IncomingSummonStatus)
            end,
          })
        end,
        C_InvasionInfo = function()
          local ns = _G.C_InvasionInfo
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AreInvasionsAvailable = function()
              return checkCFunc(ns.AreInvasionsAvailable)
            end,
            GetInvasionForUiMapID = function()
              return checkCFunc(ns.GetInvasionForUiMapID)
            end,
            GetInvasionInfo = function()
              return checkCFunc(ns.GetInvasionInfo)
            end,
            GetInvasionTimeLeft = function()
              return checkCFunc(ns.GetInvasionTimeLeft)
            end,
          })
        end,
        C_IslandsQueue = function()
          local ns = _G.C_IslandsQueue
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CloseIslandsQueueScreen = function()
              return checkCFunc(ns.CloseIslandsQueueScreen)
            end,
            GetIslandDifficultyInfo = function()
              return checkCFunc(ns.GetIslandDifficultyInfo)
            end,
            GetIslandsMaxGroupSize = function()
              return checkCFunc(ns.GetIslandsMaxGroupSize)
            end,
            GetIslandsWeeklyQuestID = function()
              return checkCFunc(ns.GetIslandsWeeklyQuestID)
            end,
            QueueForIsland = function()
              return checkCFunc(ns.QueueForIsland)
            end,
            RequestPreloadRewardData = function()
              return checkCFunc(ns.RequestPreloadRewardData)
            end,
          })
        end,
        C_Item = function()
          local ns = _G.C_Item
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanItemTransmogAppearance = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanItemTransmogAppearance)
              end
              return checkCFunc(ns.CanItemTransmogAppearance)
            end,
            CanScrapItem = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanScrapItem)
              end
              return checkCFunc(ns.CanScrapItem)
            end,
            CanViewItemPowers = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanViewItemPowers)
              end
              return checkCFunc(ns.CanViewItemPowers)
            end,
            DoesItemExist = function()
              return checkCFunc(ns.DoesItemExist)
            end,
            DoesItemExistByID = function()
              return checkCFunc(ns.DoesItemExistByID)
            end,
            DoesItemMatchBonusTreeReplacement = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.DoesItemMatchBonusTreeReplacement)
              end
              return checkCFunc(ns.DoesItemMatchBonusTreeReplacement)
            end,
            GetAppliedItemTransmogInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAppliedItemTransmogInfo)
              end
              return checkCFunc(ns.GetAppliedItemTransmogInfo)
            end,
            GetBaseItemTransmogInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBaseItemTransmogInfo)
              end
              return checkCFunc(ns.GetBaseItemTransmogInfo)
            end,
            GetCurrentItemLevel = function()
              return checkCFunc(ns.GetCurrentItemLevel)
            end,
            GetCurrentItemTransmogInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCurrentItemTransmogInfo)
              end
              return checkCFunc(ns.GetCurrentItemTransmogInfo)
            end,
            GetItemConversionOutputIcon = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetItemConversionOutputIcon)
              end
              return checkCFunc(ns.GetItemConversionOutputIcon)
            end,
            GetItemGUID = function()
              return checkCFunc(ns.GetItemGUID)
            end,
            GetItemID = function()
              return checkCFunc(ns.GetItemID)
            end,
            GetItemIcon = function()
              return checkCFunc(ns.GetItemIcon)
            end,
            GetItemIconByID = function()
              return checkCFunc(ns.GetItemIconByID)
            end,
            GetItemInventoryType = function()
              return checkCFunc(ns.GetItemInventoryType)
            end,
            GetItemInventoryTypeByID = function()
              return checkCFunc(ns.GetItemInventoryTypeByID)
            end,
            GetItemLink = function()
              return checkCFunc(ns.GetItemLink)
            end,
            GetItemName = function()
              return checkCFunc(ns.GetItemName)
            end,
            GetItemNameByID = function()
              return checkCFunc(ns.GetItemNameByID)
            end,
            GetItemQuality = function()
              return checkCFunc(ns.GetItemQuality)
            end,
            GetItemQualityByID = function()
              return checkCFunc(ns.GetItemQualityByID)
            end,
            GetItemUniquenessByID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetItemUniquenessByID)
              end
              return checkCFunc(ns.GetItemUniquenessByID)
            end,
            GetLimitedCurrencyItemInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetLimitedCurrencyItemInfo)
              end
              return checkCFunc(ns.GetLimitedCurrencyItemInfo)
            end,
            GetStackCount = function()
              return checkCFunc(ns.GetStackCount)
            end,
            IsAnimaItemByID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsAnimaItemByID)
              end
              return checkCFunc(ns.IsAnimaItemByID)
            end,
            IsBound = function()
              return checkCFunc(ns.IsBound)
            end,
            IsDressableItemByID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsDressableItemByID)
              end
              return checkCFunc(ns.IsDressableItemByID)
            end,
            IsItemConduit = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsItemConduit)
              end
              return checkCFunc(ns.IsItemConduit)
            end,
            IsItemConvertibleAndValidForPlayer = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsItemConvertibleAndValidForPlayer)
              end
              return checkCFunc(ns.IsItemConvertibleAndValidForPlayer)
            end,
            IsItemCorrupted = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsItemCorrupted)
              end
              return checkCFunc(ns.IsItemCorrupted)
            end,
            IsItemCorruptionRelated = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsItemCorruptionRelated)
              end
              return checkCFunc(ns.IsItemCorruptionRelated)
            end,
            IsItemCorruptionResistant = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsItemCorruptionResistant)
              end
              return checkCFunc(ns.IsItemCorruptionResistant)
            end,
            IsItemDataCached = function()
              return checkCFunc(ns.IsItemDataCached)
            end,
            IsItemDataCachedByID = function()
              return checkCFunc(ns.IsItemDataCachedByID)
            end,
            IsItemKeystoneByID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsItemKeystoneByID)
              end
              return checkCFunc(ns.IsItemKeystoneByID)
            end,
            IsItemSpecificToPlayerClass = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsItemSpecificToPlayerClass)
              end
              return checkCFunc(ns.IsItemSpecificToPlayerClass)
            end,
            IsLocked = function()
              return checkCFunc(ns.IsLocked)
            end,
            LockItem = function()
              return checkCFunc(ns.LockItem)
            end,
            LockItemByGUID = function()
              return checkCFunc(ns.LockItemByGUID)
            end,
            RequestLoadItemData = function()
              return checkCFunc(ns.RequestLoadItemData)
            end,
            RequestLoadItemDataByID = function()
              return checkCFunc(ns.RequestLoadItemDataByID)
            end,
            UnlockItem = function()
              return checkCFunc(ns.UnlockItem)
            end,
            UnlockItemByGUID = function()
              return checkCFunc(ns.UnlockItemByGUID)
            end,
          })
        end,
        C_ItemInteraction = function()
          local ns = _G.C_ItemInteraction
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ClearPendingItem = function()
              return checkCFunc(ns.ClearPendingItem)
            end,
            CloseUI = function()
              return checkCFunc(ns.CloseUI)
            end,
            GetChargeInfo = function()
              return checkCFunc(ns.GetChargeInfo)
            end,
            GetItemConversionCurrencyCost = function()
              return checkCFunc(ns.GetItemConversionCurrencyCost)
            end,
            GetItemInteractionInfo = function()
              return checkCFunc(ns.GetItemInteractionInfo)
            end,
            GetItemInteractionSpellId = function()
              return checkCFunc(ns.GetItemInteractionSpellId)
            end,
            InitializeFrame = function()
              return checkCFunc(ns.InitializeFrame)
            end,
            PerformItemInteraction = function()
              return checkCFunc(ns.PerformItemInteraction)
            end,
            Reset = function()
              return checkCFunc(ns.Reset)
            end,
            SetCorruptionReforgerItemTooltip = function()
              return checkCFunc(ns.SetCorruptionReforgerItemTooltip)
            end,
            SetItemConversionOutputTooltip = function()
              return checkCFunc(ns.SetItemConversionOutputTooltip)
            end,
            SetPendingItem = function()
              return checkCFunc(ns.SetPendingItem)
            end,
          })
        end,
        C_ItemSocketInfo = function()
          local ns = _G.C_ItemSocketInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CompleteSocketing = function()
              return checkCFunc(ns.CompleteSocketing)
            end,
          })
        end,
        C_ItemUpgrade = function()
          local ns = _G.C_ItemUpgrade
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanUpgradeItem = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanUpgradeItem)
              end
              return checkCFunc(ns.CanUpgradeItem)
            end,
            ClearItemUpgrade = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ClearItemUpgrade)
              end
              return checkCFunc(ns.ClearItemUpgrade)
            end,
            CloseItemUpgrade = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CloseItemUpgrade)
              end
              return checkCFunc(ns.CloseItemUpgrade)
            end,
            GetItemHyperlink = function()
              return checkCFunc(ns.GetItemHyperlink)
            end,
            GetItemUpgradeCurrentLevel = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetItemUpgradeCurrentLevel)
              end
              return checkCFunc(ns.GetItemUpgradeCurrentLevel)
            end,
            GetItemUpgradeEffect = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetItemUpgradeEffect)
              end
              return checkCFunc(ns.GetItemUpgradeEffect)
            end,
            GetItemUpgradeItemInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetItemUpgradeItemInfo)
              end
              return checkCFunc(ns.GetItemUpgradeItemInfo)
            end,
            GetItemUpgradePvpItemLevelDeltaValues = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetItemUpgradePvpItemLevelDeltaValues)
              end
              return checkCFunc(ns.GetItemUpgradePvpItemLevelDeltaValues)
            end,
            GetNumItemUpgradeEffects = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumItemUpgradeEffects)
              end
              return checkCFunc(ns.GetNumItemUpgradeEffects)
            end,
            SetItemUpgradeFromCursorItem = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetItemUpgradeFromCursorItem)
              end
              return checkCFunc(ns.SetItemUpgradeFromCursorItem)
            end,
            SetItemUpgradeFromLocation = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetItemUpgradeFromLocation)
              end
              return checkCFunc(ns.SetItemUpgradeFromLocation)
            end,
            UpgradeItem = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.UpgradeItem)
              end
              return checkCFunc(ns.UpgradeItem)
            end,
          })
        end,
        C_KeyBindings = function()
          local ns = _G.C_KeyBindings
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetCustomBindingType = function()
              return checkCFunc(ns.GetCustomBindingType)
            end,
          })
        end,
        C_LFGInfo = function()
          local ns = _G.C_LFGInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanPlayerUseGroupFinder = function()
              return checkCFunc(ns.CanPlayerUseGroupFinder)
            end,
            CanPlayerUseLFD = function()
              return checkCFunc(ns.CanPlayerUseLFD)
            end,
            CanPlayerUseLFR = function()
              return checkCFunc(ns.CanPlayerUseLFR)
            end,
            CanPlayerUsePVP = function()
              return checkCFunc(ns.CanPlayerUsePVP)
            end,
            CanPlayerUsePremadeGroup = function()
              return checkCFunc(ns.CanPlayerUsePremadeGroup)
            end,
            ConfirmLfgExpandSearch = function()
              return checkCFunc(ns.ConfirmLfgExpandSearch)
            end,
            GetAllEntriesForCategory = function()
              return checkCFunc(ns.GetAllEntriesForCategory)
            end,
            GetDungeonInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetDungeonInfo)
              end
              return checkCFunc(ns.GetDungeonInfo)
            end,
            GetLFDLockStates = function()
              return checkCFunc(ns.GetLFDLockStates)
            end,
            GetRoleCheckDifficultyDetails = function()
              return checkCFunc(ns.GetRoleCheckDifficultyDetails)
            end,
            HideNameFromUI = function()
              return checkCFunc(ns.HideNameFromUI)
            end,
          })
        end,
        C_LFGList = function()
          local ns = _G.C_LFGList
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AcceptInvite = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.AcceptInvite)
              end
              return checkCFunc(ns.AcceptInvite)
            end,
            ApplyToGroup = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ApplyToGroup)
              end
              return checkCFunc(ns.ApplyToGroup)
            end,
            CanActiveEntryUseAutoAccept = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanActiveEntryUseAutoAccept)
              end
              return checkCFunc(ns.CanActiveEntryUseAutoAccept)
            end,
            CanCreateQuestGroup = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanCreateQuestGroup)
              end
              return checkCFunc(ns.CanCreateQuestGroup)
            end,
            CancelApplication = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CancelApplication)
              end
              return checkCFunc(ns.CancelApplication)
            end,
            ClearApplicationTextFields = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ClearApplicationTextFields)
              end
              return checkCFunc(ns.ClearApplicationTextFields)
            end,
            ClearCreationTextFields = function()
              return checkCFunc(ns.ClearCreationTextFields)
            end,
            ClearSearchResults = function()
              return checkCFunc(ns.ClearSearchResults)
            end,
            ClearSearchTextFields = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ClearSearchTextFields)
              end
              return checkCFunc(ns.ClearSearchTextFields)
            end,
            CopyActiveEntryInfoToCreationFields = function()
              return checkCFunc(ns.CopyActiveEntryInfoToCreationFields)
            end,
            CreateListing = function()
              return checkCFunc(ns.CreateListing)
            end,
            DeclineApplicant = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.DeclineApplicant)
              end
              return checkCFunc(ns.DeclineApplicant)
            end,
            DeclineInvite = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.DeclineInvite)
              end
              return checkCFunc(ns.DeclineInvite)
            end,
            DoesEntryTitleMatchPrebuiltTitle = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.DoesEntryTitleMatchPrebuiltTitle)
              end
              return checkCFunc(ns.DoesEntryTitleMatchPrebuiltTitle)
            end,
            GetActiveEntryInfo = function()
              return checkCFunc(ns.GetActiveEntryInfo)
            end,
            GetActivityFullName = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetActivityFullName)
              end
              return checkCFunc(ns.GetActivityFullName)
            end,
            GetActivityGroupInfo = function()
              return checkCFunc(ns.GetActivityGroupInfo)
            end,
            GetActivityIDForQuestID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetActivityIDForQuestID)
              end
              return checkCFunc(ns.GetActivityIDForQuestID)
            end,
            GetActivityInfo = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetActivityInfo)
              end
              return checkCFunc(ns.GetActivityInfo)
            end,
            GetActivityInfoExpensive = function()
              return checkCFunc(ns.GetActivityInfoExpensive)
            end,
            GetActivityInfoTable = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetActivityInfoTable)
              end
              return checkCFunc(ns.GetActivityInfoTable)
            end,
            GetApplicantDungeonScoreForListing = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetApplicantDungeonScoreForListing)
              end
              return checkCFunc(ns.GetApplicantDungeonScoreForListing)
            end,
            GetApplicantInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetApplicantInfo)
              end
              return checkCFunc(ns.GetApplicantInfo)
            end,
            GetApplicantMemberInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetApplicantMemberInfo)
              end
              return checkCFunc(ns.GetApplicantMemberInfo)
            end,
            GetApplicantMemberStats = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetApplicantMemberStats)
              end
              return checkCFunc(ns.GetApplicantMemberStats)
            end,
            GetApplicantPvpRatingInfoForListing = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetApplicantPvpRatingInfoForListing)
              end
              return checkCFunc(ns.GetApplicantPvpRatingInfoForListing)
            end,
            GetApplicants = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetApplicants)
              end
              return checkCFunc(ns.GetApplicants)
            end,
            GetApplicationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetApplicationInfo)
              end
              return checkCFunc(ns.GetApplicationInfo)
            end,
            GetApplications = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetApplications)
              end
              return checkCFunc(ns.GetApplications)
            end,
            GetAvailableActivities = function()
              return checkCFunc(ns.GetAvailableActivities)
            end,
            GetAvailableActivityGroups = function()
              return checkCFunc(ns.GetAvailableActivityGroups)
            end,
            GetAvailableCategories = function()
              return checkCFunc(ns.GetAvailableCategories)
            end,
            GetAvailableLanguageSearchFilter = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAvailableLanguageSearchFilter)
              end
              return checkCFunc(ns.GetAvailableLanguageSearchFilter)
            end,
            GetAvailableRoles = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAvailableRoles)
              end
              return checkCFunc(ns.GetAvailableRoles)
            end,
            GetCategoryInfo = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCategoryInfo)
              end
              return checkCFunc(ns.GetCategoryInfo)
            end,
            GetDefaultLanguageSearchFilter = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetDefaultLanguageSearchFilter)
              end
              return checkCFunc(ns.GetDefaultLanguageSearchFilter)
            end,
            GetFilteredSearchResults = function()
              return checkCFunc(ns.GetFilteredSearchResults)
            end,
            GetKeystoneForActivity = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetKeystoneForActivity)
              end
              return checkCFunc(ns.GetKeystoneForActivity)
            end,
            GetLanguageSearchFilter = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetLanguageSearchFilter)
              end
              return checkCFunc(ns.GetLanguageSearchFilter)
            end,
            GetLfgCategoryInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetLfgCategoryInfo)
              end
              return checkCFunc(ns.GetLfgCategoryInfo)
            end,
            GetNumApplicants = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumApplicants)
              end
              return checkCFunc(ns.GetNumApplicants)
            end,
            GetNumApplications = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumApplications)
              end
              return checkCFunc(ns.GetNumApplications)
            end,
            GetNumInvitedApplicantMembers = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumInvitedApplicantMembers)
              end
              return checkCFunc(ns.GetNumInvitedApplicantMembers)
            end,
            GetNumPendingApplicantMembers = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumPendingApplicantMembers)
              end
              return checkCFunc(ns.GetNumPendingApplicantMembers)
            end,
            GetOwnedKeystoneActivityAndGroupAndLevel = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetOwnedKeystoneActivityAndGroupAndLevel)
              end
              return checkCFunc(ns.GetOwnedKeystoneActivityAndGroupAndLevel)
            end,
            GetPlaystyleString = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetPlaystyleString)
              end
              return checkCFunc(ns.GetPlaystyleString)
            end,
            GetRoleCheckInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetRoleCheckInfo)
              end
              return checkCFunc(ns.GetRoleCheckInfo)
            end,
            GetSearchResultEncounterInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetSearchResultEncounterInfo)
              end
              return checkCFunc(ns.GetSearchResultEncounterInfo)
            end,
            GetSearchResultFriends = function()
              return checkCFunc(ns.GetSearchResultFriends)
            end,
            GetSearchResultInfo = function()
              return checkCFunc(ns.GetSearchResultInfo)
            end,
            GetSearchResultLeaderInfo = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetSearchResultLeaderInfo)
              end
              return checkCFunc(ns.GetSearchResultLeaderInfo)
            end,
            GetSearchResultMemberCounts = function()
              return checkCFunc(ns.GetSearchResultMemberCounts)
            end,
            GetSearchResultMemberInfo = function()
              return checkCFunc(ns.GetSearchResultMemberInfo)
            end,
            GetSearchResults = function()
              return checkCFunc(ns.GetSearchResults)
            end,
            HasActiveEntryInfo = function()
              return checkCFunc(ns.HasActiveEntryInfo)
            end,
            HasActivityList = function()
              return checkCFunc(ns.HasActivityList)
            end,
            HasSearchResultInfo = function()
              return checkCFunc(ns.HasSearchResultInfo)
            end,
            InviteApplicant = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.InviteApplicant)
              end
              return checkCFunc(ns.InviteApplicant)
            end,
            IsCurrentlyApplying = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsCurrentlyApplying)
              end
              return checkCFunc(ns.IsCurrentlyApplying)
            end,
            IsLookingForGroupEnabled = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsLookingForGroupEnabled)
              end
              return checkCFunc(ns.IsLookingForGroupEnabled)
            end,
            IsPlayerAuthenticatedForLFG = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsPlayerAuthenticatedForLFG)
              end
              return checkCFunc(ns.IsPlayerAuthenticatedForLFG)
            end,
            RefreshApplicants = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.RefreshApplicants)
              end
              return checkCFunc(ns.RefreshApplicants)
            end,
            RemoveApplicant = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.RemoveApplicant)
              end
              return checkCFunc(ns.RemoveApplicant)
            end,
            RemoveListing = function()
              return checkCFunc(ns.RemoveListing)
            end,
            ReportSearchResult = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ReportSearchResult)
              end
              return checkCFunc(ns.ReportSearchResult)
            end,
            RequestAvailableActivities = function()
              return checkCFunc(ns.RequestAvailableActivities)
            end,
            SaveLanguageSearchFilter = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SaveLanguageSearchFilter)
              end
              return checkCFunc(ns.SaveLanguageSearchFilter)
            end,
            Search = function()
              return checkCFunc(ns.Search)
            end,
            SetApplicantMemberRole = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetApplicantMemberRole)
              end
              return checkCFunc(ns.SetApplicantMemberRole)
            end,
            SetEntryTitle = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetEntryTitle)
              end
              return checkCFunc(ns.SetEntryTitle)
            end,
            SetSearchToActivity = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetSearchToActivity)
              end
              return checkCFunc(ns.SetSearchToActivity)
            end,
            SetSearchToQuestID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetSearchToQuestID)
              end
              return checkCFunc(ns.SetSearchToQuestID)
            end,
            UpdateListing = function()
              return checkCFunc(ns.UpdateListing)
            end,
            ValidateRequiredDungeonScore = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ValidateRequiredDungeonScore)
              end
              return checkCFunc(ns.ValidateRequiredDungeonScore)
            end,
            ValidateRequiredPvpRatingForActivity = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ValidateRequiredPvpRatingForActivity)
              end
              return checkCFunc(ns.ValidateRequiredPvpRatingForActivity)
            end,
          })
        end,
        C_LegendaryCrafting = function()
          local ns = _G.C_LegendaryCrafting
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CloseRuneforgeInteraction = function()
              return checkCFunc(ns.CloseRuneforgeInteraction)
            end,
            CraftRuneforgeLegendary = function()
              return checkCFunc(ns.CraftRuneforgeLegendary)
            end,
            GetRuneforgeItemPreviewInfo = function()
              return checkCFunc(ns.GetRuneforgeItemPreviewInfo)
            end,
            GetRuneforgeLegendaryComponentInfo = function()
              return checkCFunc(ns.GetRuneforgeLegendaryComponentInfo)
            end,
            GetRuneforgeLegendaryCost = function()
              return checkCFunc(ns.GetRuneforgeLegendaryCost)
            end,
            GetRuneforgeLegendaryCraftSpellID = function()
              return checkCFunc(ns.GetRuneforgeLegendaryCraftSpellID)
            end,
            GetRuneforgeLegendaryCurrencies = function()
              return checkCFunc(ns.GetRuneforgeLegendaryCurrencies)
            end,
            GetRuneforgeLegendaryUpgradeCost = function()
              return checkCFunc(ns.GetRuneforgeLegendaryUpgradeCost)
            end,
            GetRuneforgeModifierInfo = function()
              return checkCFunc(ns.GetRuneforgeModifierInfo)
            end,
            GetRuneforgeModifiers = function()
              return checkCFunc(ns.GetRuneforgeModifiers)
            end,
            GetRuneforgePowerInfo = function()
              return checkCFunc(ns.GetRuneforgePowerInfo)
            end,
            GetRuneforgePowerSlots = function()
              return checkCFunc(ns.GetRuneforgePowerSlots)
            end,
            GetRuneforgePowers = function()
              return checkCFunc(ns.GetRuneforgePowers)
            end,
            GetRuneforgePowersByClassSpecAndCovenant = function()
              return checkCFunc(ns.GetRuneforgePowersByClassSpecAndCovenant)
            end,
            IsRuneforgeLegendary = function()
              return checkCFunc(ns.IsRuneforgeLegendary)
            end,
            IsRuneforgeLegendaryMaxLevel = function()
              return checkCFunc(ns.IsRuneforgeLegendaryMaxLevel)
            end,
            IsUpgradeItemValidForRuneforgeLegendary = function()
              return checkCFunc(ns.IsUpgradeItemValidForRuneforgeLegendary)
            end,
            IsValidRuneforgeBaseItem = function()
              return checkCFunc(ns.IsValidRuneforgeBaseItem)
            end,
            MakeRuneforgeCraftDescription = function()
              return checkCFunc(ns.MakeRuneforgeCraftDescription)
            end,
            UpgradeRuneforgeLegendary = function()
              return checkCFunc(ns.UpgradeRuneforgeLegendary)
            end,
          })
        end,
        C_LevelLink = function()
          local ns = _G.C_LevelLink
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            IsActionLocked = function()
              return checkCFunc(ns.IsActionLocked)
            end,
            IsSpellLocked = function()
              return checkCFunc(ns.IsSpellLocked)
            end,
          })
        end,
        C_LevelSquish = function()
          local ns = _G.C_LevelSquish
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ConvertFollowerLevel = function()
              return checkCFunc(ns.ConvertFollowerLevel)
            end,
            ConvertPlayerLevel = function()
              return checkCFunc(ns.ConvertPlayerLevel)
            end,
          })
        end,
        C_Loot = function()
          local ns = _G.C_Loot
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            IsLegacyLootModeEnabled = function()
              return checkCFunc(ns.IsLegacyLootModeEnabled)
            end,
          })
        end,
        C_LootHistory = function()
          local ns = _G.C_LootHistory
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanMasterLoot = function()
              return checkCFunc(ns.CanMasterLoot)
            end,
            GetExpiration = function()
              return checkCFunc(ns.GetExpiration)
            end,
            GetItem = function()
              return checkCFunc(ns.GetItem)
            end,
            GetNumItems = function()
              return checkCFunc(ns.GetNumItems)
            end,
            GetPlayerInfo = function()
              return checkCFunc(ns.GetPlayerInfo)
            end,
            GiveMasterLoot = function()
              return checkCFunc(ns.GiveMasterLoot)
            end,
            SetExpiration = function()
              return checkCFunc(ns.SetExpiration)
            end,
          })
        end,
        C_LootJournal = function()
          local ns = _G.C_LootJournal
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetItemSetItems = function()
              return checkCFunc(ns.GetItemSetItems)
            end,
            GetItemSets = function()
              return checkCFunc(ns.GetItemSets)
            end,
          })
        end,
        C_LoreText = function()
          local ns = _G.C_LoreText
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            RequestLoreTextForCampaignID = function()
              return checkCFunc(ns.RequestLoreTextForCampaignID)
            end,
          })
        end,
        C_LossOfControl = function()
          local ns = _G.C_LossOfControl
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetActiveLossOfControlData = function()
              return checkCFunc(ns.GetActiveLossOfControlData)
            end,
            GetActiveLossOfControlDataByUnit = function()
              return checkCFunc(ns.GetActiveLossOfControlDataByUnit)
            end,
            GetActiveLossOfControlDataCount = function()
              return checkCFunc(ns.GetActiveLossOfControlDataCount)
            end,
            GetActiveLossOfControlDataCountByUnit = function()
              return checkCFunc(ns.GetActiveLossOfControlDataCountByUnit)
            end,
          })
        end,
        C_Mail = function()
          local ns = _G.C_Mail
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanCheckInbox = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanCheckInbox)
              end
              return checkCFunc(ns.CanCheckInbox)
            end,
            HasInboxMoney = function()
              return checkCFunc(ns.HasInboxMoney)
            end,
            IsCommandPending = function()
              return checkCFunc(ns.IsCommandPending)
            end,
          })
        end,
        C_Map = function()
          local ns = _G.C_Map
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanSetUserWaypointOnMap = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanSetUserWaypointOnMap)
              end
              return checkCFunc(ns.CanSetUserWaypointOnMap)
            end,
            ClearUserWaypoint = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ClearUserWaypoint)
              end
              return checkCFunc(ns.ClearUserWaypoint)
            end,
            CloseWorldMapInteraction = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CloseWorldMapInteraction)
              end
              return checkCFunc(ns.CloseWorldMapInteraction)
            end,
            GetAreaInfo = function()
              return checkCFunc(ns.GetAreaInfo)
            end,
            GetBestMapForUnit = function()
              return checkCFunc(ns.GetBestMapForUnit)
            end,
            GetBountySetIDForMap = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBountySetIDForMap)
              end
              return checkCFunc(ns.GetBountySetIDForMap)
            end,
            GetBountySetMaps = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBountySetMaps)
              end
              return checkCFunc(ns.GetBountySetMaps)
            end,
            GetFallbackWorldMapID = function()
              return checkCFunc(ns.GetFallbackWorldMapID)
            end,
            GetMapArtBackgroundAtlas = function()
              return checkCFunc(ns.GetMapArtBackgroundAtlas)
            end,
            GetMapArtHelpTextPosition = function()
              return checkCFunc(ns.GetMapArtHelpTextPosition)
            end,
            GetMapArtID = function()
              return checkCFunc(ns.GetMapArtID)
            end,
            GetMapArtLayerTextures = function()
              return checkCFunc(ns.GetMapArtLayerTextures)
            end,
            GetMapArtLayers = function()
              return checkCFunc(ns.GetMapArtLayers)
            end,
            GetMapBannersForMap = function()
              return checkCFunc(ns.GetMapBannersForMap)
            end,
            GetMapChildrenInfo = function()
              return checkCFunc(ns.GetMapChildrenInfo)
            end,
            GetMapDisplayInfo = function()
              return checkCFunc(ns.GetMapDisplayInfo)
            end,
            GetMapGroupID = function()
              return checkCFunc(ns.GetMapGroupID)
            end,
            GetMapGroupMembersInfo = function()
              return checkCFunc(ns.GetMapGroupMembersInfo)
            end,
            GetMapHighlightInfoAtPosition = function()
              return checkCFunc(ns.GetMapHighlightInfoAtPosition)
            end,
            GetMapInfo = function()
              return checkCFunc(ns.GetMapInfo)
            end,
            GetMapInfoAtPosition = function()
              return checkCFunc(ns.GetMapInfoAtPosition)
            end,
            GetMapLevels = function()
              return checkCFunc(ns.GetMapLevels)
            end,
            GetMapLinksForMap = function()
              return checkCFunc(ns.GetMapLinksForMap)
            end,
            GetMapPosFromWorldPos = function()
              return checkCFunc(ns.GetMapPosFromWorldPos)
            end,
            GetMapRectOnMap = function()
              return checkCFunc(ns.GetMapRectOnMap)
            end,
            GetMapWorldSize = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMapWorldSize)
              end
              return checkCFunc(ns.GetMapWorldSize)
            end,
            GetPlayerMapPosition = function()
              return checkCFunc(ns.GetPlayerMapPosition)
            end,
            GetUserWaypoint = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetUserWaypoint)
              end
              return checkCFunc(ns.GetUserWaypoint)
            end,
            GetUserWaypointFromHyperlink = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetUserWaypointFromHyperlink)
              end
              return checkCFunc(ns.GetUserWaypointFromHyperlink)
            end,
            GetUserWaypointHyperlink = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetUserWaypointHyperlink)
              end
              return checkCFunc(ns.GetUserWaypointHyperlink)
            end,
            GetUserWaypointPositionForMap = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetUserWaypointPositionForMap)
              end
              return checkCFunc(ns.GetUserWaypointPositionForMap)
            end,
            GetWorldPosFromMapPos = function()
              return checkCFunc(ns.GetWorldPosFromMapPos)
            end,
            HasUserWaypoint = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.HasUserWaypoint)
              end
              return checkCFunc(ns.HasUserWaypoint)
            end,
            IsMapValidForNavBarDropDown = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsMapValidForNavBarDropDown)
              end
              return checkCFunc(ns.IsMapValidForNavBarDropDown)
            end,
            MapHasArt = function()
              return checkCFunc(ns.MapHasArt)
            end,
            RequestPreloadMap = function()
              return checkCFunc(ns.RequestPreloadMap)
            end,
            SetUserWaypoint = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetUserWaypoint)
              end
              return checkCFunc(ns.SetUserWaypoint)
            end,
          })
        end,
        C_MapExplorationInfo = function()
          local ns = _G.C_MapExplorationInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetExploredAreaIDsAtPosition = function()
              return checkCFunc(ns.GetExploredAreaIDsAtPosition)
            end,
            GetExploredMapTextures = function()
              return checkCFunc(ns.GetExploredMapTextures)
            end,
          })
        end,
        C_MerchantFrame = function()
          local ns = _G.C_MerchantFrame
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetBuybackItemID = function()
              return checkCFunc(ns.GetBuybackItemID)
            end,
            IsMerchantItemRefundable = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsMerchantItemRefundable)
              end
              return checkCFunc(ns.IsMerchantItemRefundable)
            end,
          })
        end,
        C_Minimap = function()
          local ns = _G.C_Minimap
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetDrawGroundTextures = function()
              return checkCFunc(ns.GetDrawGroundTextures)
            end,
            GetUiMapID = function()
              return checkCFunc(ns.GetUiMapID)
            end,
            GetViewRadius = function()
              return checkCFunc(ns.GetViewRadius)
            end,
            IsRotateMinimapIgnored = function()
              return checkCFunc(ns.IsRotateMinimapIgnored)
            end,
            SetDrawGroundTextures = function()
              return checkCFunc(ns.SetDrawGroundTextures)
            end,
            SetIgnoreRotateMinimap = function()
              return checkCFunc(ns.SetIgnoreRotateMinimap)
            end,
            ShouldUseHybridMinimap = function()
              return checkCFunc(ns.ShouldUseHybridMinimap)
            end,
          })
        end,
        C_ModelInfo = function()
          local ns = _G.C_ModelInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AddActiveModelScene = function()
              return checkCFunc(ns.AddActiveModelScene)
            end,
            AddActiveModelSceneActor = function()
              return checkCFunc(ns.AddActiveModelSceneActor)
            end,
            ClearActiveModelScene = function()
              return checkCFunc(ns.ClearActiveModelScene)
            end,
            ClearActiveModelSceneActor = function()
              return checkCFunc(ns.ClearActiveModelSceneActor)
            end,
            GetModelSceneActorDisplayInfoByID = function()
              return checkCFunc(ns.GetModelSceneActorDisplayInfoByID)
            end,
            GetModelSceneActorInfoByID = function()
              return checkCFunc(ns.GetModelSceneActorInfoByID)
            end,
            GetModelSceneCameraInfoByID = function()
              return checkCFunc(ns.GetModelSceneCameraInfoByID)
            end,
            GetModelSceneInfoByID = function()
              return checkCFunc(ns.GetModelSceneInfoByID)
            end,
          })
        end,
        C_ModifiedInstance = function()
          local ns = _G.C_ModifiedInstance
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetModifiedInstanceInfoFromMapID = function()
              return checkCFunc(ns.GetModifiedInstanceInfoFromMapID)
            end,
          })
        end,
        C_MountJournal = function()
          local ns = _G.C_MountJournal
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ApplyMountEquipment = function()
              return checkCFunc(ns.ApplyMountEquipment)
            end,
            AreMountEquipmentEffectsSuppressed = function()
              return checkCFunc(ns.AreMountEquipmentEffectsSuppressed)
            end,
            ClearFanfare = function()
              return checkCFunc(ns.ClearFanfare)
            end,
            ClearRecentFanfares = function()
              return checkCFunc(ns.ClearRecentFanfares)
            end,
            Dismiss = function()
              return checkCFunc(ns.Dismiss)
            end,
            GetAppliedMountEquipmentID = function()
              return checkCFunc(ns.GetAppliedMountEquipmentID)
            end,
            GetCollectedFilterSetting = function()
              return checkCFunc(ns.GetCollectedFilterSetting)
            end,
            GetDisplayedMountAllCreatureDisplayInfo = function()
              return checkCFunc(ns.GetDisplayedMountAllCreatureDisplayInfo)
            end,
            GetDisplayedMountInfo = function()
              return checkCFunc(ns.GetDisplayedMountInfo)
            end,
            GetDisplayedMountInfoExtra = function()
              return checkCFunc(ns.GetDisplayedMountInfoExtra)
            end,
            GetIsFavorite = function()
              return checkCFunc(ns.GetIsFavorite)
            end,
            GetMountAllCreatureDisplayInfoByID = function()
              return checkCFunc(ns.GetMountAllCreatureDisplayInfoByID)
            end,
            GetMountEquipmentUnlockLevel = function()
              return checkCFunc(ns.GetMountEquipmentUnlockLevel)
            end,
            GetMountFromItem = function()
              return checkCFunc(ns.GetMountFromItem)
            end,
            GetMountFromSpell = function()
              return checkCFunc(ns.GetMountFromSpell)
            end,
            GetMountIDs = function()
              return checkCFunc(ns.GetMountIDs)
            end,
            GetMountInfoByID = function()
              return checkCFunc(ns.GetMountInfoByID)
            end,
            GetMountInfoExtraByID = function()
              return checkCFunc(ns.GetMountInfoExtraByID)
            end,
            GetMountUsabilityByID = function()
              return checkCFunc(ns.GetMountUsabilityByID)
            end,
            GetNumDisplayedMounts = function()
              return checkCFunc(ns.GetNumDisplayedMounts)
            end,
            GetNumMounts = function()
              return checkCFunc(ns.GetNumMounts)
            end,
            GetNumMountsNeedingFanfare = function()
              return checkCFunc(ns.GetNumMountsNeedingFanfare)
            end,
            IsItemMountEquipment = function()
              return checkCFunc(ns.IsItemMountEquipment)
            end,
            IsMountEquipmentApplied = function()
              return checkCFunc(ns.IsMountEquipmentApplied)
            end,
            IsSourceChecked = function()
              return checkCFunc(ns.IsSourceChecked)
            end,
            IsTypeChecked = function()
              return checkCFunc(ns.IsTypeChecked)
            end,
            IsUsingDefaultFilters = function()
              return checkCFunc(ns.IsUsingDefaultFilters)
            end,
            IsValidSourceFilter = function()
              return checkCFunc(ns.IsValidSourceFilter)
            end,
            IsValidTypeFilter = function()
              return checkCFunc(ns.IsValidTypeFilter)
            end,
            NeedsFanfare = function()
              return checkCFunc(ns.NeedsFanfare)
            end,
            Pickup = function()
              return checkCFunc(ns.Pickup)
            end,
            SetAllSourceFilters = function()
              return checkCFunc(ns.SetAllSourceFilters)
            end,
            SetAllTypeFilters = function()
              return checkCFunc(ns.SetAllTypeFilters)
            end,
            SetCollectedFilterSetting = function()
              return checkCFunc(ns.SetCollectedFilterSetting)
            end,
            SetDefaultFilters = function()
              return checkCFunc(ns.SetDefaultFilters)
            end,
            SetIsFavorite = function()
              return checkCFunc(ns.SetIsFavorite)
            end,
            SetSearch = function()
              return checkCFunc(ns.SetSearch)
            end,
            SetSourceFilter = function()
              return checkCFunc(ns.SetSourceFilter)
            end,
            SetTypeFilter = function()
              return checkCFunc(ns.SetTypeFilter)
            end,
            SummonByID = function()
              return checkCFunc(ns.SummonByID)
            end,
          })
        end,
        C_MythicPlus = function()
          local ns = _G.C_MythicPlus
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetCurrentAffixes = function()
              return checkCFunc(ns.GetCurrentAffixes)
            end,
            GetCurrentSeason = function()
              return checkCFunc(ns.GetCurrentSeason)
            end,
            GetCurrentSeasonValues = function()
              return checkCFunc(ns.GetCurrentSeasonValues)
            end,
            GetLastWeeklyBestInformation = function()
              return checkCFunc(ns.GetLastWeeklyBestInformation)
            end,
            GetOwnedKeystoneChallengeMapID = function()
              return checkCFunc(ns.GetOwnedKeystoneChallengeMapID)
            end,
            GetOwnedKeystoneLevel = function()
              return checkCFunc(ns.GetOwnedKeystoneLevel)
            end,
            GetOwnedKeystoneMapID = function()
              return checkCFunc(ns.GetOwnedKeystoneMapID)
            end,
            GetRewardLevelForDifficultyLevel = function()
              return checkCFunc(ns.GetRewardLevelForDifficultyLevel)
            end,
            GetRewardLevelFromKeystoneLevel = function()
              return checkCFunc(ns.GetRewardLevelFromKeystoneLevel)
            end,
            GetRunHistory = function()
              return checkCFunc(ns.GetRunHistory)
            end,
            GetSeasonBestAffixScoreInfoForMap = function()
              return checkCFunc(ns.GetSeasonBestAffixScoreInfoForMap)
            end,
            GetSeasonBestForMap = function()
              return checkCFunc(ns.GetSeasonBestForMap)
            end,
            GetSeasonBestMythicRatingFromThisExpansion = function()
              return checkCFunc(ns.GetSeasonBestMythicRatingFromThisExpansion)
            end,
            GetWeeklyBestForMap = function()
              return checkCFunc(ns.GetWeeklyBestForMap)
            end,
            GetWeeklyChestRewardLevel = function()
              return checkCFunc(ns.GetWeeklyChestRewardLevel)
            end,
            IsMythicPlusActive = function()
              return checkCFunc(ns.IsMythicPlusActive)
            end,
            IsWeeklyRewardAvailable = function()
              return checkCFunc(ns.IsWeeklyRewardAvailable)
            end,
            RequestCurrentAffixes = function()
              return checkCFunc(ns.RequestCurrentAffixes)
            end,
            RequestMapInfo = function()
              return checkCFunc(ns.RequestMapInfo)
            end,
            RequestRewards = function()
              return checkCFunc(ns.RequestRewards)
            end,
          })
        end,
        C_NamePlate = function()
          local ns = _G.C_NamePlate
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetNamePlateEnemyClickThrough = function()
              return checkCFunc(ns.GetNamePlateEnemyClickThrough)
            end,
            GetNamePlateEnemyPreferredClickInsets = function()
              return checkCFunc(ns.GetNamePlateEnemyPreferredClickInsets)
            end,
            GetNamePlateEnemySize = function()
              return checkCFunc(ns.GetNamePlateEnemySize)
            end,
            GetNamePlateForUnit = function()
              return checkCFunc(ns.GetNamePlateForUnit)
            end,
            GetNamePlateFriendlyClickThrough = function()
              return checkCFunc(ns.GetNamePlateFriendlyClickThrough)
            end,
            GetNamePlateFriendlyPreferredClickInsets = function()
              return checkCFunc(ns.GetNamePlateFriendlyPreferredClickInsets)
            end,
            GetNamePlateFriendlySize = function()
              return checkCFunc(ns.GetNamePlateFriendlySize)
            end,
            GetNamePlateSelfClickThrough = function()
              return checkCFunc(ns.GetNamePlateSelfClickThrough)
            end,
            GetNamePlateSelfPreferredClickInsets = function()
              return checkCFunc(ns.GetNamePlateSelfPreferredClickInsets)
            end,
            GetNamePlateSelfSize = function()
              return checkCFunc(ns.GetNamePlateSelfSize)
            end,
            GetNamePlates = function()
              return checkCFunc(ns.GetNamePlates)
            end,
            GetNumNamePlateMotionTypes = function()
              return checkCFunc(ns.GetNumNamePlateMotionTypes)
            end,
            GetTargetClampingInsets = function()
              return checkCFunc(ns.GetTargetClampingInsets)
            end,
            SetNamePlateEnemyClickThrough = function()
              return checkCFunc(ns.SetNamePlateEnemyClickThrough)
            end,
            SetNamePlateEnemyPreferredClickInsets = function()
              return checkCFunc(ns.SetNamePlateEnemyPreferredClickInsets)
            end,
            SetNamePlateEnemySize = function()
              return checkCFunc(ns.SetNamePlateEnemySize)
            end,
            SetNamePlateFriendlyClickThrough = function()
              return checkCFunc(ns.SetNamePlateFriendlyClickThrough)
            end,
            SetNamePlateFriendlyPreferredClickInsets = function()
              return checkCFunc(ns.SetNamePlateFriendlyPreferredClickInsets)
            end,
            SetNamePlateFriendlySize = function()
              return checkCFunc(ns.SetNamePlateFriendlySize)
            end,
            SetNamePlateSelfClickThrough = function()
              return checkCFunc(ns.SetNamePlateSelfClickThrough)
            end,
            SetNamePlateSelfPreferredClickInsets = function()
              return checkCFunc(ns.SetNamePlateSelfPreferredClickInsets)
            end,
            SetNamePlateSelfSize = function()
              return checkCFunc(ns.SetNamePlateSelfSize)
            end,
            SetTargetClampingInsets = function()
              return checkCFunc(ns.SetTargetClampingInsets)
            end,
          })
        end,
        C_Navigation = function()
          local ns = _G.C_Navigation
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetDistance = function()
              return checkCFunc(ns.GetDistance)
            end,
            GetFrame = function()
              return checkCFunc(ns.GetFrame)
            end,
            GetTargetState = function()
              return checkCFunc(ns.GetTargetState)
            end,
            HasValidScreenPosition = function()
              return checkCFunc(ns.HasValidScreenPosition)
            end,
            WasClampedToScreen = function()
              return checkCFunc(ns.WasClampedToScreen)
            end,
          })
        end,
        C_NewItems = function()
          local ns = _G.C_NewItems
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ClearAll = function()
              return checkCFunc(ns.ClearAll)
            end,
            IsNewItem = function()
              return checkCFunc(ns.IsNewItem)
            end,
            RemoveNewItem = function()
              return checkCFunc(ns.RemoveNewItem)
            end,
          })
        end,
        C_PaperDollInfo = function()
          local ns = _G.C_PaperDollInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetArmorEffectiveness = function()
              return checkCFunc(ns.GetArmorEffectiveness)
            end,
            GetArmorEffectivenessAgainstTarget = function()
              return checkCFunc(ns.GetArmorEffectivenessAgainstTarget)
            end,
            GetInspectAzeriteItemEmpoweredChoices = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetInspectAzeriteItemEmpoweredChoices)
              end
              return checkCFunc(ns.GetInspectAzeriteItemEmpoweredChoices)
            end,
            GetInspectItemLevel = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetInspectItemLevel)
              end
              return checkCFunc(ns.GetInspectItemLevel)
            end,
            GetMinItemLevel = function()
              return checkCFunc(ns.GetMinItemLevel)
            end,
            GetStaggerPercentage = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetStaggerPercentage)
              end
              return checkCFunc(ns.GetStaggerPercentage)
            end,
            OffhandHasShield = function()
              return checkCFunc(ns.OffhandHasShield)
            end,
            OffhandHasWeapon = function()
              return checkCFunc(ns.OffhandHasWeapon)
            end,
          })
        end,
        C_PartyInfo = function()
          local ns = _G.C_PartyInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AllowedToDoPartyConversion = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.AllowedToDoPartyConversion)
              end
              return checkCFunc(ns.AllowedToDoPartyConversion)
            end,
            CanFormCrossFactionParties = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanFormCrossFactionParties)
              end
              return checkCFunc(ns.CanFormCrossFactionParties)
            end,
            CanInvite = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanInvite)
              end
              return checkCFunc(ns.CanInvite)
            end,
            ConfirmConvertToRaid = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ConfirmConvertToRaid)
              end
              return checkCFunc(ns.ConfirmConvertToRaid)
            end,
            ConfirmInviteTravelPass = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ConfirmInviteTravelPass)
              end
              return checkCFunc(ns.ConfirmInviteTravelPass)
            end,
            ConfirmInviteUnit = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ConfirmInviteUnit)
              end
              return checkCFunc(ns.ConfirmInviteUnit)
            end,
            ConfirmLeaveParty = function()
              return checkCFunc(ns.ConfirmLeaveParty)
            end,
            ConfirmRequestInviteFromUnit = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ConfirmRequestInviteFromUnit)
              end
              return checkCFunc(ns.ConfirmRequestInviteFromUnit)
            end,
            ConvertToParty = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ConvertToParty)
              end
              return checkCFunc(ns.ConvertToParty)
            end,
            ConvertToRaid = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ConvertToRaid)
              end
              return checkCFunc(ns.ConvertToRaid)
            end,
            DoCountdown = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.DoCountdown)
              end
              return checkCFunc(ns.DoCountdown)
            end,
            GetActiveCategories = function()
              return checkCFunc(ns.GetActiveCategories)
            end,
            GetInviteConfirmationInvalidQueues = function()
              return checkCFunc(ns.GetInviteConfirmationInvalidQueues)
            end,
            GetInviteReferralInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetInviteReferralInfo)
              end
              return checkCFunc(ns.GetInviteReferralInfo)
            end,
            GetMinLevel = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMinLevel)
              end
              return checkCFunc(ns.GetMinLevel)
            end,
            InviteUnit = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.InviteUnit)
              end
              return checkCFunc(ns.InviteUnit)
            end,
            IsCrossFactionParty = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsCrossFactionParty)
              end
              return checkCFunc(ns.IsCrossFactionParty)
            end,
            IsPartyFull = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsPartyFull)
              end
              return checkCFunc(ns.IsPartyFull)
            end,
            IsPartyInJailersTower = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsPartyInJailersTower)
              end
              return checkCFunc(ns.IsPartyInJailersTower)
            end,
            LeaveParty = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.LeaveParty)
              end
              return checkCFunc(ns.LeaveParty)
            end,
            RequestInviteFromUnit = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.RequestInviteFromUnit)
              end
              return checkCFunc(ns.RequestInviteFromUnit)
            end,
          })
        end,
        C_PartyPose = function()
          local ns = _G.C_PartyPose
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetPartyPoseInfoByMapID = function()
              return checkCFunc(ns.GetPartyPoseInfoByMapID)
            end,
          })
        end,
        C_PetBattles = function()
          local ns = _G.C_PetBattles
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AcceptPVPDuel = function()
              return checkCFunc(ns.AcceptPVPDuel)
            end,
            AcceptQueuedPVPMatch = function()
              return checkCFunc(ns.AcceptQueuedPVPMatch)
            end,
            CanAcceptQueuedPVPMatch = function()
              return checkCFunc(ns.CanAcceptQueuedPVPMatch)
            end,
            CanActivePetSwapOut = function()
              return checkCFunc(ns.CanActivePetSwapOut)
            end,
            CanPetSwapIn = function()
              return checkCFunc(ns.CanPetSwapIn)
            end,
            CancelPVPDuel = function()
              return checkCFunc(ns.CancelPVPDuel)
            end,
            ChangePet = function()
              return checkCFunc(ns.ChangePet)
            end,
            DeclineQueuedPVPMatch = function()
              return checkCFunc(ns.DeclineQueuedPVPMatch)
            end,
            ForfeitGame = function()
              return checkCFunc(ns.ForfeitGame)
            end,
            GetAbilityEffectInfo = function()
              return checkCFunc(ns.GetAbilityEffectInfo)
            end,
            GetAbilityInfo = function()
              return checkCFunc(ns.GetAbilityInfo)
            end,
            GetAbilityInfoByID = function()
              return checkCFunc(ns.GetAbilityInfoByID)
            end,
            GetAbilityProcTurnIndex = function()
              return checkCFunc(ns.GetAbilityProcTurnIndex)
            end,
            GetAbilityState = function()
              return checkCFunc(ns.GetAbilityState)
            end,
            GetAbilityStateModification = function()
              return checkCFunc(ns.GetAbilityStateModification)
            end,
            GetActivePet = function()
              return checkCFunc(ns.GetActivePet)
            end,
            GetAllEffectNames = function()
              return checkCFunc(ns.GetAllEffectNames)
            end,
            GetAllStates = function()
              return checkCFunc(ns.GetAllStates)
            end,
            GetAttackModifier = function()
              return checkCFunc(ns.GetAttackModifier)
            end,
            GetAuraInfo = function()
              return checkCFunc(ns.GetAuraInfo)
            end,
            GetBattleState = function()
              return checkCFunc(ns.GetBattleState)
            end,
            GetBreedQuality = function()
              return checkCFunc(ns.GetBreedQuality)
            end,
            GetDisplayID = function()
              return checkCFunc(ns.GetDisplayID)
            end,
            GetForfeitPenalty = function()
              return checkCFunc(ns.GetForfeitPenalty)
            end,
            GetHealth = function()
              return checkCFunc(ns.GetHealth)
            end,
            GetIcon = function()
              return checkCFunc(ns.GetIcon)
            end,
            GetLevel = function()
              return checkCFunc(ns.GetLevel)
            end,
            GetMaxHealth = function()
              return checkCFunc(ns.GetMaxHealth)
            end,
            GetName = function()
              return checkCFunc(ns.GetName)
            end,
            GetNumAuras = function()
              return checkCFunc(ns.GetNumAuras)
            end,
            GetNumPets = function()
              return checkCFunc(ns.GetNumPets)
            end,
            GetPVPMatchmakingInfo = function()
              return checkCFunc(ns.GetPVPMatchmakingInfo)
            end,
            GetPetSpeciesID = function()
              return checkCFunc(ns.GetPetSpeciesID)
            end,
            GetPetType = function()
              return checkCFunc(ns.GetPetType)
            end,
            GetPlayerTrapAbility = function()
              return checkCFunc(ns.GetPlayerTrapAbility)
            end,
            GetPower = function()
              return checkCFunc(ns.GetPower)
            end,
            GetSelectedAction = function()
              return checkCFunc(ns.GetSelectedAction)
            end,
            GetSpeed = function()
              return checkCFunc(ns.GetSpeed)
            end,
            GetStateValue = function()
              return checkCFunc(ns.GetStateValue)
            end,
            GetTurnTimeInfo = function()
              return checkCFunc(ns.GetTurnTimeInfo)
            end,
            GetXP = function()
              return checkCFunc(ns.GetXP)
            end,
            IsInBattle = function()
              return checkCFunc(ns.IsInBattle)
            end,
            IsPlayerNPC = function()
              return checkCFunc(ns.IsPlayerNPC)
            end,
            IsSkipAvailable = function()
              return checkCFunc(ns.IsSkipAvailable)
            end,
            IsTrapAvailable = function()
              return checkCFunc(ns.IsTrapAvailable)
            end,
            IsWaitingOnOpponent = function()
              return checkCFunc(ns.IsWaitingOnOpponent)
            end,
            IsWildBattle = function()
              return checkCFunc(ns.IsWildBattle)
            end,
            SetPendingReportBattlePetTarget = function()
              return checkCFunc(ns.SetPendingReportBattlePetTarget)
            end,
            SetPendingReportTargetFromUnit = function()
              return checkCFunc(ns.SetPendingReportTargetFromUnit)
            end,
            ShouldShowPetSelect = function()
              return checkCFunc(ns.ShouldShowPetSelect)
            end,
            SkipTurn = function()
              return checkCFunc(ns.SkipTurn)
            end,
            StartPVPDuel = function()
              return checkCFunc(ns.StartPVPDuel)
            end,
            StartPVPMatchmaking = function()
              return checkCFunc(ns.StartPVPMatchmaking)
            end,
            StopPVPMatchmaking = function()
              return checkCFunc(ns.StopPVPMatchmaking)
            end,
            UseAbility = function()
              return checkCFunc(ns.UseAbility)
            end,
            UseTrap = function()
              return checkCFunc(ns.UseTrap)
            end,
          })
        end,
        C_PetInfo = function()
          local ns = _G.C_PetInfo
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetPetTamersForMap = function()
              return checkCFunc(ns.GetPetTamersForMap)
            end,
          })
        end,
        C_PetJournal = function()
          local ns = _G.C_PetJournal
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CagePetByID = function()
              return checkCFunc(ns.CagePetByID)
            end,
            ClearFanfare = function()
              return checkCFunc(ns.ClearFanfare)
            end,
            ClearRecentFanfares = function()
              return checkCFunc(ns.ClearRecentFanfares)
            end,
            ClearSearchFilter = function()
              return checkCFunc(ns.ClearSearchFilter)
            end,
            FindPetIDByName = function()
              return checkCFunc(ns.FindPetIDByName)
            end,
            GetBattlePetLink = function()
              return checkCFunc(ns.GetBattlePetLink)
            end,
            GetDisplayIDByIndex = function()
              return checkCFunc(ns.GetDisplayIDByIndex)
            end,
            GetDisplayProbabilityByIndex = function()
              return checkCFunc(ns.GetDisplayProbabilityByIndex)
            end,
            GetNumCollectedInfo = function()
              return checkCFunc(ns.GetNumCollectedInfo)
            end,
            GetNumDisplays = function()
              return checkCFunc(ns.GetNumDisplays)
            end,
            GetNumPetSources = function()
              return checkCFunc(ns.GetNumPetSources)
            end,
            GetNumPetTypes = function()
              return checkCFunc(ns.GetNumPetTypes)
            end,
            GetNumPets = function()
              return checkCFunc(ns.GetNumPets)
            end,
            GetNumPetsNeedingFanfare = function()
              return checkCFunc(ns.GetNumPetsNeedingFanfare)
            end,
            GetOwnedBattlePetString = function()
              return checkCFunc(ns.GetOwnedBattlePetString)
            end,
            GetPetAbilityInfo = function()
              return checkCFunc(ns.GetPetAbilityInfo)
            end,
            GetPetAbilityList = function()
              return checkCFunc(ns.GetPetAbilityList)
            end,
            GetPetAbilityListTable = function()
              return checkCFunc(ns.GetPetAbilityListTable)
            end,
            GetPetCooldownByGUID = function()
              return checkCFunc(ns.GetPetCooldownByGUID)
            end,
            GetPetInfoByIndex = function()
              return checkCFunc(ns.GetPetInfoByIndex)
            end,
            GetPetInfoByItemID = function()
              return checkCFunc(ns.GetPetInfoByItemID)
            end,
            GetPetInfoByPetID = function()
              return checkCFunc(ns.GetPetInfoByPetID)
            end,
            GetPetInfoBySpeciesID = function()
              return checkCFunc(ns.GetPetInfoBySpeciesID)
            end,
            GetPetInfoTableByPetID = function()
              return checkCFunc(ns.GetPetInfoTableByPetID)
            end,
            GetPetLoadOutInfo = function()
              return checkCFunc(ns.GetPetLoadOutInfo)
            end,
            GetPetModelSceneInfoBySpeciesID = function()
              return checkCFunc(ns.GetPetModelSceneInfoBySpeciesID)
            end,
            GetPetSortParameter = function()
              return checkCFunc(ns.GetPetSortParameter)
            end,
            GetPetStats = function()
              return checkCFunc(ns.GetPetStats)
            end,
            GetPetSummonInfo = function()
              return checkCFunc(ns.GetPetSummonInfo)
            end,
            GetPetTeamAverageLevel = function()
              return checkCFunc(ns.GetPetTeamAverageLevel)
            end,
            GetSummonBattlePetCooldown = function()
              return checkCFunc(ns.GetSummonBattlePetCooldown)
            end,
            GetSummonRandomFavoritePetGUID = function()
              return checkCFunc(ns.GetSummonRandomFavoritePetGUID)
            end,
            GetSummonedPetGUID = function()
              return checkCFunc(ns.GetSummonedPetGUID)
            end,
            IsFilterChecked = function()
              return checkCFunc(ns.IsFilterChecked)
            end,
            IsFindBattleEnabled = function()
              return checkCFunc(ns.IsFindBattleEnabled)
            end,
            IsJournalReadOnly = function()
              return checkCFunc(ns.IsJournalReadOnly)
            end,
            IsJournalUnlocked = function()
              return checkCFunc(ns.IsJournalUnlocked)
            end,
            IsPetSourceChecked = function()
              return checkCFunc(ns.IsPetSourceChecked)
            end,
            IsPetTypeChecked = function()
              return checkCFunc(ns.IsPetTypeChecked)
            end,
            IsUsingDefaultFilters = function()
              return checkCFunc(ns.IsUsingDefaultFilters)
            end,
            PetCanBeReleased = function()
              return checkCFunc(ns.PetCanBeReleased)
            end,
            PetIsCapturable = function()
              return checkCFunc(ns.PetIsCapturable)
            end,
            PetIsFavorite = function()
              return checkCFunc(ns.PetIsFavorite)
            end,
            PetIsHurt = function()
              return checkCFunc(ns.PetIsHurt)
            end,
            PetIsLockedForConvert = function()
              return checkCFunc(ns.PetIsLockedForConvert)
            end,
            PetIsRevoked = function()
              return checkCFunc(ns.PetIsRevoked)
            end,
            PetIsSlotted = function()
              return checkCFunc(ns.PetIsSlotted)
            end,
            PetIsSummonable = function()
              return checkCFunc(ns.PetIsSummonable)
            end,
            PetIsTradable = function()
              return checkCFunc(ns.PetIsTradable)
            end,
            PetIsUsable = function()
              return checkCFunc(ns.PetIsUsable)
            end,
            PetNeedsFanfare = function()
              return checkCFunc(ns.PetNeedsFanfare)
            end,
            PetUsesRandomDisplay = function()
              return checkCFunc(ns.PetUsesRandomDisplay)
            end,
            PickupPet = function()
              return checkCFunc(ns.PickupPet)
            end,
            PickupSummonRandomPet = function()
              return checkCFunc(ns.PickupSummonRandomPet)
            end,
            ReleasePetByID = function()
              return checkCFunc(ns.ReleasePetByID)
            end,
            SetAbility = function()
              return checkCFunc(ns.SetAbility)
            end,
            SetAllPetSourcesChecked = function()
              return checkCFunc(ns.SetAllPetSourcesChecked)
            end,
            SetAllPetTypesChecked = function()
              return checkCFunc(ns.SetAllPetTypesChecked)
            end,
            SetCustomName = function()
              return checkCFunc(ns.SetCustomName)
            end,
            SetDefaultFilters = function()
              return checkCFunc(ns.SetDefaultFilters)
            end,
            SetFavorite = function()
              return checkCFunc(ns.SetFavorite)
            end,
            SetFilterChecked = function()
              return checkCFunc(ns.SetFilterChecked)
            end,
            SetPetLoadOutInfo = function()
              return checkCFunc(ns.SetPetLoadOutInfo)
            end,
            SetPetSortParameter = function()
              return checkCFunc(ns.SetPetSortParameter)
            end,
            SetPetSourceChecked = function()
              return checkCFunc(ns.SetPetSourceChecked)
            end,
            SetPetTypeFilter = function()
              return checkCFunc(ns.SetPetTypeFilter)
            end,
            SetSearchFilter = function()
              return checkCFunc(ns.SetSearchFilter)
            end,
            SummonPetByGUID = function()
              return checkCFunc(ns.SummonPetByGUID)
            end,
            SummonRandomPet = function()
              return checkCFunc(ns.SummonRandomPet)
            end,
          })
        end,
        C_PlayerChoice = function()
          local ns = _G.C_PlayerChoice
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetCurrentPlayerChoiceInfo = function()
              return checkCFunc(ns.GetCurrentPlayerChoiceInfo)
            end,
            GetNumRerolls = function()
              return checkCFunc(ns.GetNumRerolls)
            end,
            GetRemainingTime = function()
              return checkCFunc(ns.GetRemainingTime)
            end,
            IsWaitingForPlayerChoiceResponse = function()
              return checkCFunc(ns.IsWaitingForPlayerChoiceResponse)
            end,
            OnUIClosed = function()
              return checkCFunc(ns.OnUIClosed)
            end,
            RequestRerollPlayerChoice = function()
              return checkCFunc(ns.RequestRerollPlayerChoice)
            end,
            SendPlayerChoiceResponse = function()
              return checkCFunc(ns.SendPlayerChoiceResponse)
            end,
          })
        end,
        C_PlayerInfo = function()
          local ns = _G.C_PlayerInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanPlayerEnterChromieTime = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanPlayerEnterChromieTime)
              end
              return checkCFunc(ns.CanPlayerEnterChromieTime)
            end,
            CanPlayerUseAreaLoot = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanPlayerUseAreaLoot)
              end
              return checkCFunc(ns.CanPlayerUseAreaLoot)
            end,
            CanPlayerUseMountEquipment = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanPlayerUseMountEquipment)
              end
              return checkCFunc(ns.CanPlayerUseMountEquipment)
            end,
            GUIDIsPlayer = function()
              return checkCFunc(ns.GUIDIsPlayer)
            end,
            GetAlternateFormInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAlternateFormInfo)
              end
              return checkCFunc(ns.GetAlternateFormInfo)
            end,
            GetClass = function()
              return checkCFunc(ns.GetClass)
            end,
            GetContentDifficultyCreatureForPlayer = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetContentDifficultyCreatureForPlayer)
              end
              return checkCFunc(ns.GetContentDifficultyCreatureForPlayer)
            end,
            GetContentDifficultyQuestForPlayer = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetContentDifficultyQuestForPlayer)
              end
              return checkCFunc(ns.GetContentDifficultyQuestForPlayer)
            end,
            GetInstancesUnlockedAtLevel = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetInstancesUnlockedAtLevel)
              end
              return checkCFunc(ns.GetInstancesUnlockedAtLevel)
            end,
            GetName = function()
              return checkCFunc(ns.GetName)
            end,
            GetPlayerMythicPlusRatingSummary = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetPlayerMythicPlusRatingSummary)
              end
              return checkCFunc(ns.GetPlayerMythicPlusRatingSummary)
            end,
            GetRace = function()
              return checkCFunc(ns.GetRace)
            end,
            GetSex = function()
              return checkCFunc(ns.GetSex)
            end,
            IsConnected = function()
              return checkCFunc(ns.IsConnected)
            end,
            IsPlayerEligibleForNPE = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsPlayerEligibleForNPE)
              end
              return checkCFunc(ns.IsPlayerEligibleForNPE)
            end,
            IsPlayerEligibleForNPEv2 = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsPlayerEligibleForNPEv2)
              end
              return checkCFunc(ns.IsPlayerEligibleForNPEv2)
            end,
            IsPlayerInChromieTime = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsPlayerInChromieTime)
              end
              return checkCFunc(ns.IsPlayerInChromieTime)
            end,
            IsPlayerInGuildFromGUID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsPlayerInGuildFromGUID)
              end
              return checkCFunc(ns.IsPlayerInGuildFromGUID)
            end,
            IsPlayerNPERestricted = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsPlayerNPERestricted)
              end
              return checkCFunc(ns.IsPlayerNPERestricted)
            end,
            UnitIsSameServer = function()
              return checkCFunc(ns.UnitIsSameServer)
            end,
          })
        end,
        C_PlayerMentorship = function()
          local ns = _G.C_PlayerMentorship
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetMentorLevelRequirement = function()
              return checkCFunc(ns.GetMentorLevelRequirement)
            end,
            GetMentorRequirements = function()
              return checkCFunc(ns.GetMentorRequirements)
            end,
            GetMentorshipStatus = function()
              return checkCFunc(ns.GetMentorshipStatus)
            end,
            IsActivePlayerConsideredNewcomer = function()
              return checkCFunc(ns.IsActivePlayerConsideredNewcomer)
            end,
            IsMentorRestricted = function()
              return checkCFunc(ns.IsMentorRestricted)
            end,
          })
        end,
        C_ProductChoice = function()
          local ns = _G.C_ProductChoice
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetChoices = function()
              return checkCFunc(ns.GetChoices)
            end,
            GetNumSuppressed = function()
              return checkCFunc(ns.GetNumSuppressed)
            end,
            GetProducts = function()
              return checkCFunc(ns.GetProducts)
            end,
            MakeSelection = function()
              return checkCFunc(ns.MakeSelection)
            end,
          })
        end,
        C_PvP = function()
          local ns = _G.C_PvP
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanDisplayDamage = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanDisplayDamage)
              end
              return checkCFunc(ns.CanDisplayDamage)
            end,
            CanDisplayDeaths = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanDisplayDeaths)
              end
              return checkCFunc(ns.CanDisplayDeaths)
            end,
            CanDisplayHealing = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanDisplayHealing)
              end
              return checkCFunc(ns.CanDisplayHealing)
            end,
            CanDisplayHonorableKills = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanDisplayHonorableKills)
              end
              return checkCFunc(ns.CanDisplayHonorableKills)
            end,
            CanDisplayKillingBlows = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanDisplayKillingBlows)
              end
              return checkCFunc(ns.CanDisplayKillingBlows)
            end,
            CanPlayerUseRatedPVPUI = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanPlayerUseRatedPVPUI)
              end
              return checkCFunc(ns.CanPlayerUseRatedPVPUI)
            end,
            CanToggleWarMode = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanToggleWarMode)
              end
              return checkCFunc(ns.CanToggleWarMode)
            end,
            CanToggleWarModeInArea = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanToggleWarModeInArea)
              end
              return checkCFunc(ns.CanToggleWarModeInArea)
            end,
            DoesMatchOutcomeAffectRating = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.DoesMatchOutcomeAffectRating)
              end
              return checkCFunc(ns.DoesMatchOutcomeAffectRating)
            end,
            GetActiveBrawlInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetActiveBrawlInfo)
              end
              return checkCFunc(ns.GetActiveBrawlInfo)
            end,
            GetActiveMatchBracket = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetActiveMatchBracket)
              end
              return checkCFunc(ns.GetActiveMatchBracket)
            end,
            GetActiveMatchDuration = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetActiveMatchDuration)
              end
              return checkCFunc(ns.GetActiveMatchDuration)
            end,
            GetActiveMatchState = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetActiveMatchState)
              end
              return checkCFunc(ns.GetActiveMatchState)
            end,
            GetActiveMatchWinner = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetActiveMatchWinner)
              end
              return checkCFunc(ns.GetActiveMatchWinner)
            end,
            GetArenaCrowdControlInfo = function()
              return checkCFunc(ns.GetArenaCrowdControlInfo)
            end,
            GetArenaRewards = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetArenaRewards)
              end
              return checkCFunc(ns.GetArenaRewards)
            end,
            GetArenaSkirmishRewards = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetArenaSkirmishRewards)
              end
              return checkCFunc(ns.GetArenaSkirmishRewards)
            end,
            GetAvailableBrawlInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAvailableBrawlInfo)
              end
              return checkCFunc(ns.GetAvailableBrawlInfo)
            end,
            GetBattlefieldFlagPosition = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBattlefieldFlagPosition)
              end
              return checkCFunc(ns.GetBattlefieldFlagPosition)
            end,
            GetBattlefieldVehicleInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBattlefieldVehicleInfo)
              end
              return checkCFunc(ns.GetBattlefieldVehicleInfo)
            end,
            GetBattlefieldVehicles = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBattlefieldVehicles)
              end
              return checkCFunc(ns.GetBattlefieldVehicles)
            end,
            GetBrawlRewards = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBrawlRewards)
              end
              return checkCFunc(ns.GetBrawlRewards)
            end,
            GetCustomVictoryStatID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCustomVictoryStatID)
              end
              return checkCFunc(ns.GetCustomVictoryStatID)
            end,
            GetGlobalPvpScalingInfoForSpecID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetGlobalPvpScalingInfoForSpecID)
              end
              return checkCFunc(ns.GetGlobalPvpScalingInfoForSpecID)
            end,
            GetHonorRewardInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetHonorRewardInfo)
              end
              return checkCFunc(ns.GetHonorRewardInfo)
            end,
            GetLevelUpBattlegrounds = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetLevelUpBattlegrounds)
              end
              return checkCFunc(ns.GetLevelUpBattlegrounds)
            end,
            GetMatchPVPStatColumn = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMatchPVPStatColumn)
              end
              return checkCFunc(ns.GetMatchPVPStatColumn)
            end,
            GetMatchPVPStatColumns = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMatchPVPStatColumns)
              end
              return checkCFunc(ns.GetMatchPVPStatColumns)
            end,
            GetNextHonorLevelForReward = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNextHonorLevelForReward)
              end
              return checkCFunc(ns.GetNextHonorLevelForReward)
            end,
            GetOutdoorPvPWaitTime = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetOutdoorPvPWaitTime)
              end
              return checkCFunc(ns.GetOutdoorPvPWaitTime)
            end,
            GetPVPActiveMatchPersonalRatedInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetPVPActiveMatchPersonalRatedInfo)
              end
              return checkCFunc(ns.GetPVPActiveMatchPersonalRatedInfo)
            end,
            GetPVPSeasonRewardAchievementID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetPVPSeasonRewardAchievementID)
              end
              return checkCFunc(ns.GetPVPSeasonRewardAchievementID)
            end,
            GetPostMatchCurrencyRewards = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetPostMatchCurrencyRewards)
              end
              return checkCFunc(ns.GetPostMatchCurrencyRewards)
            end,
            GetPostMatchItemRewards = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetPostMatchItemRewards)
              end
              return checkCFunc(ns.GetPostMatchItemRewards)
            end,
            GetPvpTierID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetPvpTierID)
              end
              return checkCFunc(ns.GetPvpTierID)
            end,
            GetPvpTierInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetPvpTierInfo)
              end
              return checkCFunc(ns.GetPvpTierInfo)
            end,
            GetRandomBGInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetRandomBGInfo)
              end
              return checkCFunc(ns.GetRandomBGInfo)
            end,
            GetRandomBGRewards = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetRandomBGRewards)
              end
              return checkCFunc(ns.GetRandomBGRewards)
            end,
            GetRandomEpicBGInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetRandomEpicBGInfo)
              end
              return checkCFunc(ns.GetRandomEpicBGInfo)
            end,
            GetRandomEpicBGRewards = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetRandomEpicBGRewards)
              end
              return checkCFunc(ns.GetRandomEpicBGRewards)
            end,
            GetRatedBGRewards = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetRatedBGRewards)
              end
              return checkCFunc(ns.GetRatedBGRewards)
            end,
            GetRewardItemLevelsByTierEnum = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetRewardItemLevelsByTierEnum)
              end
              return checkCFunc(ns.GetRewardItemLevelsByTierEnum)
            end,
            GetScoreInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetScoreInfo)
              end
              return checkCFunc(ns.GetScoreInfo)
            end,
            GetScoreInfoByPlayerGuid = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetScoreInfoByPlayerGuid)
              end
              return checkCFunc(ns.GetScoreInfoByPlayerGuid)
            end,
            GetSeasonBestInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetSeasonBestInfo)
              end
              return checkCFunc(ns.GetSeasonBestInfo)
            end,
            GetSkirmishInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetSkirmishInfo)
              end
              return checkCFunc(ns.GetSkirmishInfo)
            end,
            GetSpecialEventBrawlInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetSpecialEventBrawlInfo)
              end
              return checkCFunc(ns.GetSpecialEventBrawlInfo)
            end,
            GetTeamInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetTeamInfo)
              end
              return checkCFunc(ns.GetTeamInfo)
            end,
            GetWarModeRewardBonus = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetWarModeRewardBonus)
              end
              return checkCFunc(ns.GetWarModeRewardBonus)
            end,
            GetWarModeRewardBonusDefault = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetWarModeRewardBonusDefault)
              end
              return checkCFunc(ns.GetWarModeRewardBonusDefault)
            end,
            GetWeeklyChestInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetWeeklyChestInfo)
              end
              return checkCFunc(ns.GetWeeklyChestInfo)
            end,
            HasArenaSkirmishWinToday = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.HasArenaSkirmishWinToday)
              end
              return checkCFunc(ns.HasArenaSkirmishWinToday)
            end,
            IsActiveBattlefield = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsActiveBattlefield)
              end
              return checkCFunc(ns.IsActiveBattlefield)
            end,
            IsActiveMatchRegistered = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsActiveMatchRegistered)
              end
              return checkCFunc(ns.IsActiveMatchRegistered)
            end,
            IsArena = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsArena)
              end
              return checkCFunc(ns.IsArena)
            end,
            IsBattleground = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsBattleground)
              end
              return checkCFunc(ns.IsBattleground)
            end,
            IsBattlegroundEnlistmentBonusActive = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsBattlegroundEnlistmentBonusActive)
              end
              return checkCFunc(ns.IsBattlegroundEnlistmentBonusActive)
            end,
            IsInBrawl = function()
              return checkCFunc(ns.IsInBrawl)
            end,
            IsMatchConsideredArena = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsMatchConsideredArena)
              end
              return checkCFunc(ns.IsMatchConsideredArena)
            end,
            IsMatchFactional = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsMatchFactional)
              end
              return checkCFunc(ns.IsMatchFactional)
            end,
            IsPVPMap = function()
              return checkCFunc(ns.IsPVPMap)
            end,
            IsRatedArena = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsRatedArena)
              end
              return checkCFunc(ns.IsRatedArena)
            end,
            IsRatedBattleground = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsRatedBattleground)
              end
              return checkCFunc(ns.IsRatedBattleground)
            end,
            IsRatedMap = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsRatedMap)
              end
              return checkCFunc(ns.IsRatedMap)
            end,
            IsSoloShuffle = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsSoloShuffle)
              end
              return checkCFunc(ns.IsSoloShuffle)
            end,
            IsWarModeActive = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsWarModeActive)
              end
              return checkCFunc(ns.IsWarModeActive)
            end,
            IsWarModeDesired = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsWarModeDesired)
              end
              return checkCFunc(ns.IsWarModeDesired)
            end,
            IsWarModeFeatureEnabled = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsWarModeFeatureEnabled)
              end
              return checkCFunc(ns.IsWarModeFeatureEnabled)
            end,
            JoinBrawl = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.JoinBrawl)
              end
              return checkCFunc(ns.JoinBrawl)
            end,
            RequestCrowdControlSpell = function()
              return checkCFunc(ns.RequestCrowdControlSpell)
            end,
            SetWarModeDesired = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetWarModeDesired)
              end
              return checkCFunc(ns.SetWarModeDesired)
            end,
            ToggleWarMode = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ToggleWarMode)
              end
              return checkCFunc(ns.ToggleWarMode)
            end,
          })
        end,
        C_QuestLine = function()
          local ns = _G.C_QuestLine
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetAvailableQuestLines = function()
              return checkCFunc(ns.GetAvailableQuestLines)
            end,
            GetQuestLineInfo = function()
              return checkCFunc(ns.GetQuestLineInfo)
            end,
            GetQuestLineQuests = function()
              return checkCFunc(ns.GetQuestLineQuests)
            end,
            IsComplete = function()
              return checkCFunc(ns.IsComplete)
            end,
            RequestQuestLinesForMap = function()
              return checkCFunc(ns.RequestQuestLinesForMap)
            end,
          })
        end,
        C_QuestLog = function()
          local ns = _G.C_QuestLog
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AbandonQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.AbandonQuest)
              end
              return checkCFunc(ns.AbandonQuest)
            end,
            AddQuestWatch = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.AddQuestWatch)
              end
              return checkCFunc(ns.AddQuestWatch)
            end,
            AddWorldQuestWatch = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.AddWorldQuestWatch)
              end
              return checkCFunc(ns.AddWorldQuestWatch)
            end,
            CanAbandonQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.CanAbandonQuest)
              end
              return checkCFunc(ns.CanAbandonQuest)
            end,
            GetAbandonQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAbandonQuest)
              end
              return checkCFunc(ns.GetAbandonQuest)
            end,
            GetAbandonQuestItems = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAbandonQuestItems)
              end
              return checkCFunc(ns.GetAbandonQuestItems)
            end,
            GetActiveThreatMaps = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetActiveThreatMaps)
              end
              return checkCFunc(ns.GetActiveThreatMaps)
            end,
            GetAllCompletedQuestIDs = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetAllCompletedQuestIDs)
              end
              return checkCFunc(ns.GetAllCompletedQuestIDs)
            end,
            GetBountiesForMapID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBountiesForMapID)
              end
              return checkCFunc(ns.GetBountiesForMapID)
            end,
            GetBountySetInfoForMapID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetBountySetInfoForMapID)
              end
              return checkCFunc(ns.GetBountySetInfoForMapID)
            end,
            GetDistanceSqToQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetDistanceSqToQuest)
              end
              return checkCFunc(ns.GetDistanceSqToQuest)
            end,
            GetInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetInfo)
              end
              return checkCFunc(ns.GetInfo)
            end,
            GetLogIndexForQuestID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetLogIndexForQuestID)
              end
              return checkCFunc(ns.GetLogIndexForQuestID)
            end,
            GetMapForQuestPOIs = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMapForQuestPOIs)
              end
              return checkCFunc(ns.GetMapForQuestPOIs)
            end,
            GetMaxNumQuests = function()
              return checkCFunc(ns.GetMaxNumQuests)
            end,
            GetMaxNumQuestsCanAccept = function()
              return checkCFunc(ns.GetMaxNumQuestsCanAccept)
            end,
            GetNextWaypoint = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNextWaypoint)
              end
              return checkCFunc(ns.GetNextWaypoint)
            end,
            GetNextWaypointForMap = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNextWaypointForMap)
              end
              return checkCFunc(ns.GetNextWaypointForMap)
            end,
            GetNextWaypointText = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNextWaypointText)
              end
              return checkCFunc(ns.GetNextWaypointText)
            end,
            GetNumQuestLogEntries = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumQuestLogEntries)
              end
              return checkCFunc(ns.GetNumQuestLogEntries)
            end,
            GetNumQuestObjectives = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumQuestObjectives)
              end
              return checkCFunc(ns.GetNumQuestObjectives)
            end,
            GetNumQuestWatches = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumQuestWatches)
              end
              return checkCFunc(ns.GetNumQuestWatches)
            end,
            GetNumWorldQuestWatches = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumWorldQuestWatches)
              end
              return checkCFunc(ns.GetNumWorldQuestWatches)
            end,
            GetQuestAdditionalHighlights = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestAdditionalHighlights)
              end
              return checkCFunc(ns.GetQuestAdditionalHighlights)
            end,
            GetQuestDetailsTheme = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestDetailsTheme)
              end
              return checkCFunc(ns.GetQuestDetailsTheme)
            end,
            GetQuestDifficultyLevel = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestDifficultyLevel)
              end
              return checkCFunc(ns.GetQuestDifficultyLevel)
            end,
            GetQuestIDForLogIndex = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestIDForLogIndex)
              end
              return checkCFunc(ns.GetQuestIDForLogIndex)
            end,
            GetQuestIDForQuestWatchIndex = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestIDForQuestWatchIndex)
              end
              return checkCFunc(ns.GetQuestIDForQuestWatchIndex)
            end,
            GetQuestIDForWorldQuestWatchIndex = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestIDForWorldQuestWatchIndex)
              end
              return checkCFunc(ns.GetQuestIDForWorldQuestWatchIndex)
            end,
            GetQuestInfo = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestInfo)
              end
              return checkCFunc(ns.GetQuestInfo)
            end,
            GetQuestLogPortraitGiver = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestLogPortraitGiver)
              end
              return checkCFunc(ns.GetQuestLogPortraitGiver)
            end,
            GetQuestObjectives = function()
              return checkCFunc(ns.GetQuestObjectives)
            end,
            GetQuestTagInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestTagInfo)
              end
              return checkCFunc(ns.GetQuestTagInfo)
            end,
            GetQuestType = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestType)
              end
              return checkCFunc(ns.GetQuestType)
            end,
            GetQuestWatchType = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestWatchType)
              end
              return checkCFunc(ns.GetQuestWatchType)
            end,
            GetQuestsOnMap = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetQuestsOnMap)
              end
              return checkCFunc(ns.GetQuestsOnMap)
            end,
            GetRequiredMoney = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetRequiredMoney)
              end
              return checkCFunc(ns.GetRequiredMoney)
            end,
            GetSelectedQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetSelectedQuest)
              end
              return checkCFunc(ns.GetSelectedQuest)
            end,
            GetSuggestedGroupSize = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetSuggestedGroupSize)
              end
              return checkCFunc(ns.GetSuggestedGroupSize)
            end,
            GetTimeAllowed = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetTimeAllowed)
              end
              return checkCFunc(ns.GetTimeAllowed)
            end,
            GetTitleForLogIndex = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetTitleForLogIndex)
              end
              return checkCFunc(ns.GetTitleForLogIndex)
            end,
            GetTitleForQuestID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetTitleForQuestID)
              end
              return checkCFunc(ns.GetTitleForQuestID)
            end,
            GetZoneStoryInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetZoneStoryInfo)
              end
              return checkCFunc(ns.GetZoneStoryInfo)
            end,
            HasActiveThreats = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.HasActiveThreats)
              end
              return checkCFunc(ns.HasActiveThreats)
            end,
            IsAccountQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsAccountQuest)
              end
              return checkCFunc(ns.IsAccountQuest)
            end,
            IsComplete = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsComplete)
              end
              return checkCFunc(ns.IsComplete)
            end,
            IsFailed = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsFailed)
              end
              return checkCFunc(ns.IsFailed)
            end,
            IsLegendaryQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsLegendaryQuest)
              end
              return checkCFunc(ns.IsLegendaryQuest)
            end,
            IsOnMap = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsOnMap)
              end
              return checkCFunc(ns.IsOnMap)
            end,
            IsOnQuest = function()
              return checkCFunc(ns.IsOnQuest)
            end,
            IsPushableQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsPushableQuest)
              end
              return checkCFunc(ns.IsPushableQuest)
            end,
            IsQuestBounty = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsQuestBounty)
              end
              return checkCFunc(ns.IsQuestBounty)
            end,
            IsQuestCalling = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsQuestCalling)
              end
              return checkCFunc(ns.IsQuestCalling)
            end,
            IsQuestCriteriaForBounty = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsQuestCriteriaForBounty)
              end
              return checkCFunc(ns.IsQuestCriteriaForBounty)
            end,
            IsQuestDisabledForSession = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsQuestDisabledForSession)
              end
              return checkCFunc(ns.IsQuestDisabledForSession)
            end,
            IsQuestFlaggedCompleted = function()
              return checkCFunc(ns.IsQuestFlaggedCompleted)
            end,
            IsQuestInvasion = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsQuestInvasion)
              end
              return checkCFunc(ns.IsQuestInvasion)
            end,
            IsQuestReplayable = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsQuestReplayable)
              end
              return checkCFunc(ns.IsQuestReplayable)
            end,
            IsQuestReplayedRecently = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsQuestReplayedRecently)
              end
              return checkCFunc(ns.IsQuestReplayedRecently)
            end,
            IsQuestTask = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsQuestTask)
              end
              return checkCFunc(ns.IsQuestTask)
            end,
            IsQuestTrivial = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsQuestTrivial)
              end
              return checkCFunc(ns.IsQuestTrivial)
            end,
            IsRepeatableQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsRepeatableQuest)
              end
              return checkCFunc(ns.IsRepeatableQuest)
            end,
            IsThreatQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsThreatQuest)
              end
              return checkCFunc(ns.IsThreatQuest)
            end,
            IsUnitOnQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsUnitOnQuest)
              end
              return checkCFunc(ns.IsUnitOnQuest)
            end,
            IsWorldQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsWorldQuest)
              end
              return checkCFunc(ns.IsWorldQuest)
            end,
            QuestCanHaveWarModeBonus = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.QuestCanHaveWarModeBonus)
              end
              return checkCFunc(ns.QuestCanHaveWarModeBonus)
            end,
            QuestHasQuestSessionBonus = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.QuestHasQuestSessionBonus)
              end
              return checkCFunc(ns.QuestHasQuestSessionBonus)
            end,
            QuestHasWarModeBonus = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.QuestHasWarModeBonus)
              end
              return checkCFunc(ns.QuestHasWarModeBonus)
            end,
            ReadyForTurnIn = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ReadyForTurnIn)
              end
              return checkCFunc(ns.ReadyForTurnIn)
            end,
            RemoveQuestWatch = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.RemoveQuestWatch)
              end
              return checkCFunc(ns.RemoveQuestWatch)
            end,
            RemoveWorldQuestWatch = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.RemoveWorldQuestWatch)
              end
              return checkCFunc(ns.RemoveWorldQuestWatch)
            end,
            RequestLoadQuestByID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.RequestLoadQuestByID)
              end
              return checkCFunc(ns.RequestLoadQuestByID)
            end,
            SetAbandonQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetAbandonQuest)
              end
              return checkCFunc(ns.SetAbandonQuest)
            end,
            SetMapForQuestPOIs = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetMapForQuestPOIs)
              end
              return checkCFunc(ns.SetMapForQuestPOIs)
            end,
            SetSelectedQuest = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetSelectedQuest)
              end
              return checkCFunc(ns.SetSelectedQuest)
            end,
            ShouldDisplayTimeRemaining = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ShouldDisplayTimeRemaining)
              end
              return checkCFunc(ns.ShouldDisplayTimeRemaining)
            end,
            ShouldShowQuestRewards = function()
              return checkCFunc(ns.ShouldShowQuestRewards)
            end,
            SortQuestWatches = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SortQuestWatches)
              end
              return checkCFunc(ns.SortQuestWatches)
            end,
          })
        end,
        C_QuestSession = function()
          local ns = _G.C_QuestSession
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanStart = function()
              return checkCFunc(ns.CanStart)
            end,
            CanStop = function()
              return checkCFunc(ns.CanStop)
            end,
            Exists = function()
              return checkCFunc(ns.Exists)
            end,
            GetAvailableSessionCommand = function()
              return checkCFunc(ns.GetAvailableSessionCommand)
            end,
            GetPendingCommand = function()
              return checkCFunc(ns.GetPendingCommand)
            end,
            GetProposedMaxLevelForSession = function()
              return checkCFunc(ns.GetProposedMaxLevelForSession)
            end,
            GetSessionBeginDetails = function()
              return checkCFunc(ns.GetSessionBeginDetails)
            end,
            GetSuperTrackedQuest = function()
              return checkCFunc(ns.GetSuperTrackedQuest)
            end,
            HasJoined = function()
              return checkCFunc(ns.HasJoined)
            end,
            HasPendingCommand = function()
              return checkCFunc(ns.HasPendingCommand)
            end,
            RequestSessionStart = function()
              return checkCFunc(ns.RequestSessionStart)
            end,
            RequestSessionStop = function()
              return checkCFunc(ns.RequestSessionStop)
            end,
            SendSessionBeginResponse = function()
              return checkCFunc(ns.SendSessionBeginResponse)
            end,
            SetQuestIsSuperTracked = function()
              return checkCFunc(ns.SetQuestIsSuperTracked)
            end,
          })
        end,
        C_RaidLocks = function()
          local ns = _G.C_RaidLocks
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            IsEncounterComplete = function()
              return checkCFunc(ns.IsEncounterComplete)
            end,
          })
        end,
        C_RecruitAFriend = function()
          local ns = _G.C_RecruitAFriend
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ClaimActivityReward = function()
              return checkCFunc(ns.ClaimActivityReward)
            end,
            ClaimNextReward = function()
              return checkCFunc(ns.ClaimNextReward)
            end,
            GenerateRecruitmentLink = function()
              return checkCFunc(ns.GenerateRecruitmentLink)
            end,
            GetRAFInfo = function()
              return checkCFunc(ns.GetRAFInfo)
            end,
            GetRAFSystemInfo = function()
              return checkCFunc(ns.GetRAFSystemInfo)
            end,
            GetRecruitActivityRequirementsText = function()
              return checkCFunc(ns.GetRecruitActivityRequirementsText)
            end,
            GetRecruitInfo = function()
              return checkCFunc(ns.GetRecruitInfo)
            end,
            IsEnabled = function()
              return checkCFunc(ns.IsEnabled)
            end,
            IsRecruitingEnabled = function()
              return checkCFunc(ns.IsRecruitingEnabled)
            end,
            RemoveRAFRecruit = function()
              return checkCFunc(ns.RemoveRAFRecruit)
            end,
            RequestUpdatedRecruitmentInfo = function()
              return checkCFunc(ns.RequestUpdatedRecruitmentInfo)
            end,
          })
        end,
        C_ReportSystem = function()
          local ns = _G.C_ReportSystem
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanReportPlayer = function()
              return checkCFunc(ns.CanReportPlayer)
            end,
            CanReportPlayerForLanguage = function()
              return checkCFunc(ns.CanReportPlayerForLanguage)
            end,
            GetMajorCategoriesForReportType = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMajorCategoriesForReportType)
              end
              return checkCFunc(ns.GetMajorCategoriesForReportType)
            end,
            GetMajorCategoryString = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMajorCategoryString)
              end
              return checkCFunc(ns.GetMajorCategoryString)
            end,
            GetMinorCategoriesForReportTypeAndMajorCategory = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMinorCategoriesForReportTypeAndMajorCategory)
              end
              return checkCFunc(ns.GetMinorCategoriesForReportTypeAndMajorCategory)
            end,
            GetMinorCategoryString = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMinorCategoryString)
              end
              return checkCFunc(ns.GetMinorCategoryString)
            end,
            InitiateReportPlayer = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.InitiateReportPlayer)
              end
              return checkCFunc(ns.InitiateReportPlayer)
            end,
            OpenReportPlayerDialog = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.OpenReportPlayerDialog)
              end
              return checkCFunc(ns.OpenReportPlayerDialog)
            end,
            ReportServerLag = function()
              return checkCFunc(ns.ReportServerLag)
            end,
            ReportStuckInCombat = function()
              return checkCFunc(ns.ReportStuckInCombat)
            end,
            SendReport = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SendReport)
              end
              return checkCFunc(ns.SendReport)
            end,
            SendReportPlayer = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SendReportPlayer)
              end
              return checkCFunc(ns.SendReportPlayer)
            end,
            SetPendingReportPetTarget = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetPendingReportPetTarget)
              end
              return checkCFunc(ns.SetPendingReportPetTarget)
            end,
            SetPendingReportTarget = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetPendingReportTarget)
              end
              return checkCFunc(ns.SetPendingReportTarget)
            end,
            SetPendingReportTargetByGuid = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetPendingReportTargetByGuid)
              end
              return checkCFunc(ns.SetPendingReportTargetByGuid)
            end,
          })
        end,
        C_Reputation = function()
          local ns = _G.C_Reputation
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetFactionParagonInfo = function()
              return checkCFunc(ns.GetFactionParagonInfo)
            end,
            IsFactionParagon = function()
              return checkCFunc(ns.IsFactionParagon)
            end,
            RequestFactionParagonPreloadRewardData = function()
              return checkCFunc(ns.RequestFactionParagonPreloadRewardData)
            end,
          })
        end,
        C_ResearchInfo = function()
          local ns = _G.C_ResearchInfo
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetDigSitesForMap = function()
              return checkCFunc(ns.GetDigSitesForMap)
            end,
          })
        end,
        C_Scenario = function()
          local ns = _G.C_Scenario
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetBonusStepRewardQuestID = function()
              return checkCFunc(ns.GetBonusStepRewardQuestID)
            end,
            GetBonusSteps = function()
              return checkCFunc(ns.GetBonusSteps)
            end,
            GetCriteriaInfo = function()
              return checkCFunc(ns.GetCriteriaInfo)
            end,
            GetCriteriaInfoByStep = function()
              return checkCFunc(ns.GetCriteriaInfoByStep)
            end,
            GetInfo = function()
              return checkCFunc(ns.GetInfo)
            end,
            GetProvingGroundsInfo = function()
              return checkCFunc(ns.GetProvingGroundsInfo)
            end,
            GetScenarioIconInfo = function()
              return checkCFunc(ns.GetScenarioIconInfo)
            end,
            GetStepInfo = function()
              return checkCFunc(ns.GetStepInfo)
            end,
            GetSupersededObjectives = function()
              return checkCFunc(ns.GetSupersededObjectives)
            end,
            IsInScenario = function()
              return checkCFunc(ns.IsInScenario)
            end,
            ShouldShowCriteria = function()
              return checkCFunc(ns.ShouldShowCriteria)
            end,
            TreatScenarioAsDungeon = function()
              return checkCFunc(ns.TreatScenarioAsDungeon)
            end,
          })
        end,
        C_ScenarioInfo = function()
          local ns = _G.C_ScenarioInfo
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetJailersTowerTypeString = function()
              return checkCFunc(ns.GetJailersTowerTypeString)
            end,
            GetScenarioInfo = function()
              return checkCFunc(ns.GetScenarioInfo)
            end,
            GetScenarioStepInfo = function()
              return checkCFunc(ns.GetScenarioStepInfo)
            end,
          })
        end,
        C_ScrappingMachineUI = function()
          local ns = _G.C_ScrappingMachineUI
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CloseScrappingMachine = function()
              return checkCFunc(ns.CloseScrappingMachine)
            end,
            DropPendingScrapItemFromCursor = function()
              return checkCFunc(ns.DropPendingScrapItemFromCursor)
            end,
            GetCurrentPendingScrapItemLocationByIndex = function()
              return checkCFunc(ns.GetCurrentPendingScrapItemLocationByIndex)
            end,
            GetScrapSpellID = function()
              return checkCFunc(ns.GetScrapSpellID)
            end,
            GetScrappingMachineName = function()
              return checkCFunc(ns.GetScrappingMachineName)
            end,
            HasScrappableItems = function()
              return checkCFunc(ns.HasScrappableItems)
            end,
            RemoveAllScrapItems = function()
              return checkCFunc(ns.RemoveAllScrapItems)
            end,
            RemoveCurrentScrappingItem = function()
              return checkCFunc(ns.RemoveCurrentScrappingItem)
            end,
            RemoveItemToScrap = function()
              return checkCFunc(ns.RemoveItemToScrap)
            end,
            ScrapItems = function()
              return checkCFunc(ns.ScrapItems)
            end,
            SetScrappingMachine = function()
              return checkCFunc(ns.SetScrappingMachine)
            end,
            ValidateScrappingList = function()
              return checkCFunc(ns.ValidateScrappingList)
            end,
          })
        end,
        C_ScriptedAnimations = function()
          local ns = _G.C_ScriptedAnimations
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetAllScriptedAnimationEffects = function()
              return checkCFunc(ns.GetAllScriptedAnimationEffects)
            end,
          })
        end,
        C_Seasons = function()
          local ns = _G.C_Seasons
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetActiveSeason = function()
              return checkCFunc(ns.GetActiveSeason)
            end,
            HasActiveSeason = function()
              return checkCFunc(ns.HasActiveSeason)
            end,
          })
        end,
        C_Social = function()
          local ns = _G.C_Social
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetLastAchievement = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetLastAchievement)
              end
              return checkCFunc(ns.GetLastAchievement)
            end,
            GetLastItem = function()
              return checkCFunc(ns.GetLastItem)
            end,
            GetLastScreenshot = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetLastScreenshot)
              end
              return checkCFunc(ns.GetLastScreenshot)
            end,
            GetLastScreenshotIndex = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetLastScreenshotIndex)
              end
              return checkCFunc(ns.GetLastScreenshotIndex)
            end,
            GetMaxTweetLength = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMaxTweetLength)
              end
              return checkCFunc(ns.GetMaxTweetLength)
            end,
            GetNumCharactersPerMedia = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetNumCharactersPerMedia)
              end
              return checkCFunc(ns.GetNumCharactersPerMedia)
            end,
            GetScreenshotByIndex = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetScreenshotByIndex)
              end
              return checkCFunc(ns.GetScreenshotByIndex)
            end,
            GetScreenshotInfoByIndex = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetScreenshotInfoByIndex)
              end
              return checkCFunc(ns.GetScreenshotInfoByIndex)
            end,
            GetTweetLength = function()
              return checkCFunc(ns.GetTweetLength)
            end,
            IsSocialEnabled = function()
              return checkCFunc(ns.IsSocialEnabled)
            end,
            RegisterSocialBrowser = function()
              return checkCFunc(ns.RegisterSocialBrowser)
            end,
            SetTextureToScreenshot = function()
              return checkCFunc(ns.SetTextureToScreenshot)
            end,
            TwitterCheckStatus = function()
              return checkCFunc(ns.TwitterCheckStatus)
            end,
            TwitterConnect = function()
              return checkCFunc(ns.TwitterConnect)
            end,
            TwitterDisconnect = function()
              return checkCFunc(ns.TwitterDisconnect)
            end,
            TwitterGetMSTillCanPost = function()
              return checkCFunc(ns.TwitterGetMSTillCanPost)
            end,
            TwitterPostAchievement = function()
              return checkCFunc(ns.TwitterPostAchievement)
            end,
            TwitterPostItem = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.TwitterPostItem)
              end
              return checkCFunc(ns.TwitterPostItem)
            end,
            TwitterPostMessage = function()
              return checkCFunc(ns.TwitterPostMessage)
            end,
            TwitterPostScreenshot = function()
              return checkCFunc(ns.TwitterPostScreenshot)
            end,
          })
        end,
        C_SocialQueue = function()
          local ns = _G.C_SocialQueue
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetAllGroups = function()
              return checkCFunc(ns.GetAllGroups)
            end,
            GetConfig = function()
              return checkCFunc(ns.GetConfig)
            end,
            GetGroupForPlayer = function()
              return checkCFunc(ns.GetGroupForPlayer)
            end,
            GetGroupInfo = function()
              return checkCFunc(ns.GetGroupInfo)
            end,
            GetGroupMembers = function()
              return checkCFunc(ns.GetGroupMembers)
            end,
            GetGroupQueues = function()
              return checkCFunc(ns.GetGroupQueues)
            end,
            RequestToJoin = function()
              return checkCFunc(ns.RequestToJoin)
            end,
            SignalToastDisplayed = function()
              return checkCFunc(ns.SignalToastDisplayed)
            end,
          })
        end,
        C_SocialRestrictions = function()
          local ns = _G.C_SocialRestrictions
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AcknowledgeRegionalChatDisabled = function()
              return checkCFunc(ns.AcknowledgeRegionalChatDisabled)
            end,
            IsChatDisabled = function()
              return checkCFunc(ns.IsChatDisabled)
            end,
            IsMuted = function()
              return checkCFunc(ns.IsMuted)
            end,
            IsSilenced = function()
              return checkCFunc(ns.IsSilenced)
            end,
            IsSquelched = function()
              return checkCFunc(ns.IsSquelched)
            end,
            SetChatDisabled = function()
              return checkCFunc(ns.SetChatDisabled)
            end,
          })
        end,
        C_Soulbinds = function()
          local ns = _G.C_Soulbinds
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ActivateSoulbind = function()
              return checkCFunc(ns.ActivateSoulbind)
            end,
            CanActivateSoulbind = function()
              return checkCFunc(ns.CanActivateSoulbind)
            end,
            CanModifySoulbind = function()
              return checkCFunc(ns.CanModifySoulbind)
            end,
            CanResetConduitsInSoulbind = function()
              return checkCFunc(ns.CanResetConduitsInSoulbind)
            end,
            CanSwitchActiveSoulbindTreeBranch = function()
              return checkCFunc(ns.CanSwitchActiveSoulbindTreeBranch)
            end,
            CloseUI = function()
              return checkCFunc(ns.CloseUI)
            end,
            CommitPendingConduitsInSoulbind = function()
              return checkCFunc(ns.CommitPendingConduitsInSoulbind)
            end,
            FindNodeIDActuallyInstalled = function()
              return checkCFunc(ns.FindNodeIDActuallyInstalled)
            end,
            FindNodeIDAppearingInstalled = function()
              return checkCFunc(ns.FindNodeIDAppearingInstalled)
            end,
            FindNodeIDPendingInstall = function()
              return checkCFunc(ns.FindNodeIDPendingInstall)
            end,
            FindNodeIDPendingUninstall = function()
              return checkCFunc(ns.FindNodeIDPendingUninstall)
            end,
            GetActiveSoulbindID = function()
              return checkCFunc(ns.GetActiveSoulbindID)
            end,
            GetConduitCollection = function()
              return checkCFunc(ns.GetConduitCollection)
            end,
            GetConduitCollectionCount = function()
              return checkCFunc(ns.GetConduitCollectionCount)
            end,
            GetConduitCollectionData = function()
              return checkCFunc(ns.GetConduitCollectionData)
            end,
            GetConduitCollectionDataAtCursor = function()
              return checkCFunc(ns.GetConduitCollectionDataAtCursor)
            end,
            GetConduitCollectionDataByVirtualID = function()
              return checkCFunc(ns.GetConduitCollectionDataByVirtualID)
            end,
            GetConduitDisplayed = function()
              return checkCFunc(ns.GetConduitDisplayed)
            end,
            GetConduitHyperlink = function()
              return checkCFunc(ns.GetConduitHyperlink)
            end,
            GetConduitIDPendingInstall = function()
              return checkCFunc(ns.GetConduitIDPendingInstall)
            end,
            GetConduitQuality = function()
              return checkCFunc(ns.GetConduitQuality)
            end,
            GetConduitRank = function()
              return checkCFunc(ns.GetConduitRank)
            end,
            GetConduitSpellID = function()
              return checkCFunc(ns.GetConduitSpellID)
            end,
            GetInstalledConduitID = function()
              return checkCFunc(ns.GetInstalledConduitID)
            end,
            GetNode = function()
              return checkCFunc(ns.GetNode)
            end,
            GetSoulbindData = function()
              return checkCFunc(ns.GetSoulbindData)
            end,
            GetSpecsAssignedToSoulbind = function()
              return checkCFunc(ns.GetSpecsAssignedToSoulbind)
            end,
            GetTree = function()
              return checkCFunc(ns.GetTree)
            end,
            HasAnyInstalledConduitInSoulbind = function()
              return checkCFunc(ns.HasAnyInstalledConduitInSoulbind)
            end,
            HasAnyPendingConduits = function()
              return checkCFunc(ns.HasAnyPendingConduits)
            end,
            HasPendingConduitsInSoulbind = function()
              return checkCFunc(ns.HasPendingConduitsInSoulbind)
            end,
            IsConduitInstalled = function()
              return checkCFunc(ns.IsConduitInstalled)
            end,
            IsConduitInstalledInSoulbind = function()
              return checkCFunc(ns.IsConduitInstalledInSoulbind)
            end,
            IsItemConduitByItemInfo = function()
              return checkCFunc(ns.IsItemConduitByItemInfo)
            end,
            IsNodePendingModify = function()
              return checkCFunc(ns.IsNodePendingModify)
            end,
            IsUnselectedConduitPendingInSoulbind = function()
              return checkCFunc(ns.IsUnselectedConduitPendingInSoulbind)
            end,
            ModifyNode = function()
              return checkCFunc(ns.ModifyNode)
            end,
            SelectNode = function()
              return checkCFunc(ns.SelectNode)
            end,
            UnmodifyNode = function()
              return checkCFunc(ns.UnmodifyNode)
            end,
          })
        end,
        C_SpecializationInfo = function()
          local ns = _G.C_SpecializationInfo
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CanPlayerUsePVPTalentUI = function()
              return checkCFunc(ns.CanPlayerUsePVPTalentUI)
            end,
            CanPlayerUseTalentSpecUI = function()
              return checkCFunc(ns.CanPlayerUseTalentSpecUI)
            end,
            CanPlayerUseTalentUI = function()
              return checkCFunc(ns.CanPlayerUseTalentUI)
            end,
            GetAllSelectedPvpTalentIDs = function()
              return checkCFunc(ns.GetAllSelectedPvpTalentIDs)
            end,
            GetInspectSelectedPvpTalent = function()
              return checkCFunc(ns.GetInspectSelectedPvpTalent)
            end,
            GetPvpTalentAlertStatus = function()
              return checkCFunc(ns.GetPvpTalentAlertStatus)
            end,
            GetPvpTalentSlotInfo = function()
              return checkCFunc(ns.GetPvpTalentSlotInfo)
            end,
            GetPvpTalentSlotUnlockLevel = function()
              return checkCFunc(ns.GetPvpTalentSlotUnlockLevel)
            end,
            GetPvpTalentUnlockLevel = function()
              return checkCFunc(ns.GetPvpTalentUnlockLevel)
            end,
            GetSpecIDs = function()
              return checkCFunc(ns.GetSpecIDs)
            end,
            GetSpellsDisplay = function()
              return checkCFunc(ns.GetSpellsDisplay)
            end,
            IsInitialized = function()
              return checkCFunc(ns.IsInitialized)
            end,
            IsPvpTalentLocked = function()
              return checkCFunc(ns.IsPvpTalentLocked)
            end,
            MatchesCurrentSpecSet = function()
              return checkCFunc(ns.MatchesCurrentSpecSet)
            end,
            SetPvpTalentLocked = function()
              return checkCFunc(ns.SetPvpTalentLocked)
            end,
          })
        end,
        C_Spell = function()
          local ns = _G.C_Spell
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            DoesSpellExist = function()
              return checkCFunc(ns.DoesSpellExist)
            end,
            GetMawPowerBorderAtlasBySpellID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetMawPowerBorderAtlasBySpellID)
              end
              return checkCFunc(ns.GetMawPowerBorderAtlasBySpellID)
            end,
            IsSpellDataCached = function()
              return checkCFunc(ns.IsSpellDataCached)
            end,
            RequestLoadSpellData = function()
              return checkCFunc(ns.RequestLoadSpellData)
            end,
          })
        end,
        C_SpellBook = function()
          local ns = _G.C_SpellBook
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ContainsAnyDisenchantSpell = function()
              return checkCFunc(ns.ContainsAnyDisenchantSpell)
            end,
            GetCurrentLevelSpells = function()
              return checkCFunc(ns.GetCurrentLevelSpells)
            end,
            GetSkillLineIndexByID = function()
              return checkCFunc(ns.GetSkillLineIndexByID)
            end,
            GetSpellInfo = function()
              return checkCFunc(ns.GetSpellInfo)
            end,
            GetSpellLinkFromSpellID = function()
              return checkCFunc(ns.GetSpellLinkFromSpellID)
            end,
            IsSpellDisabled = function()
              return checkCFunc(ns.IsSpellDisabled)
            end,
          })
        end,
        C_SplashScreen = function()
          local ns = _G.C_SplashScreen
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AcknowledgeSplash = function()
              return checkCFunc(ns.AcknowledgeSplash)
            end,
            CanViewSplashScreen = function()
              return checkCFunc(ns.CanViewSplashScreen)
            end,
            RequestLatestSplashScreen = function()
              return checkCFunc(ns.RequestLatestSplashScreen)
            end,
          })
        end,
        C_StableInfo = function()
          local ns = _G.C_StableInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetNumActivePets = function()
              return checkCFunc(ns.GetNumActivePets)
            end,
            GetNumStablePets = function()
              return checkCFunc(ns.GetNumStablePets)
            end,
          })
        end,
        C_StorePublic = function()
          local ns = _G.C_StorePublic
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            DoesGroupHavePurchaseableProducts = function()
              return checkCFunc(ns.DoesGroupHavePurchaseableProducts)
            end,
            HasPurchaseableProducts = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.HasPurchaseableProducts)
              end
              return checkCFunc(ns.HasPurchaseableProducts)
            end,
            IsDisabledByParentalControls = function()
              return checkCFunc(ns.IsDisabledByParentalControls)
            end,
            IsEnabled = function()
              return checkCFunc(ns.IsEnabled)
            end,
          })
        end,
        C_SummonInfo = function()
          local ns = _G.C_SummonInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            CancelSummon = function()
              return checkCFunc(ns.CancelSummon)
            end,
            ConfirmSummon = function()
              return checkCFunc(ns.ConfirmSummon)
            end,
            GetSummonConfirmAreaName = function()
              return checkCFunc(ns.GetSummonConfirmAreaName)
            end,
            GetSummonConfirmSummoner = function()
              return checkCFunc(ns.GetSummonConfirmSummoner)
            end,
            GetSummonConfirmTimeLeft = function()
              return checkCFunc(ns.GetSummonConfirmTimeLeft)
            end,
            GetSummonReason = function()
              return checkCFunc(ns.GetSummonReason)
            end,
            IsSummonSkippingStartExperience = function()
              return checkCFunc(ns.IsSummonSkippingStartExperience)
            end,
          })
        end,
        C_SuperTrack = function()
          local ns = _G.C_SuperTrack
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetHighestPrioritySuperTrackingType = function()
              return checkCFunc(ns.GetHighestPrioritySuperTrackingType)
            end,
            GetSuperTrackedQuestID = function()
              return checkCFunc(ns.GetSuperTrackedQuestID)
            end,
            IsSuperTrackingAnything = function()
              return checkCFunc(ns.IsSuperTrackingAnything)
            end,
            IsSuperTrackingCorpse = function()
              return checkCFunc(ns.IsSuperTrackingCorpse)
            end,
            IsSuperTrackingQuest = function()
              return checkCFunc(ns.IsSuperTrackingQuest)
            end,
            IsSuperTrackingUserWaypoint = function()
              return checkCFunc(ns.IsSuperTrackingUserWaypoint)
            end,
            SetSuperTrackedQuestID = function()
              return checkCFunc(ns.SetSuperTrackedQuestID)
            end,
            SetSuperTrackedUserWaypoint = function()
              return checkCFunc(ns.SetSuperTrackedUserWaypoint)
            end,
          })
        end,
        C_System = function()
          local ns = _G.C_System
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetFrameStack = function()
              return checkCFunc(ns.GetFrameStack)
            end,
          })
        end,
        C_TTSSettings = function()
          local ns = _G.C_TTSSettings
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetChannelEnabled = function()
              return checkCFunc(ns.GetChannelEnabled)
            end,
            GetCharacterSettingsSaved = function()
              return checkCFunc(ns.GetCharacterSettingsSaved)
            end,
            GetChatTypeEnabled = function()
              return checkCFunc(ns.GetChatTypeEnabled)
            end,
            GetSetting = function()
              return checkCFunc(ns.GetSetting)
            end,
            GetSpeechRate = function()
              return checkCFunc(ns.GetSpeechRate)
            end,
            GetSpeechVolume = function()
              return checkCFunc(ns.GetSpeechVolume)
            end,
            GetVoiceOptionID = function()
              return checkCFunc(ns.GetVoiceOptionID)
            end,
            GetVoiceOptionName = function()
              return checkCFunc(ns.GetVoiceOptionName)
            end,
            MarkCharacterSettingsSaved = function()
              return checkCFunc(ns.MarkCharacterSettingsSaved)
            end,
            SetChannelEnabled = function()
              return checkCFunc(ns.SetChannelEnabled)
            end,
            SetChannelKeyEnabled = function()
              return checkCFunc(ns.SetChannelKeyEnabled)
            end,
            SetChatTypeEnabled = function()
              return checkCFunc(ns.SetChatTypeEnabled)
            end,
            SetDefaultSettings = function()
              return checkCFunc(ns.SetDefaultSettings)
            end,
            SetSetting = function()
              return checkCFunc(ns.SetSetting)
            end,
            SetSpeechRate = function()
              return checkCFunc(ns.SetSpeechRate)
            end,
            SetSpeechVolume = function()
              return checkCFunc(ns.SetSpeechVolume)
            end,
            SetVoiceOption = function()
              return checkCFunc(ns.SetVoiceOption)
            end,
            SetVoiceOptionName = function()
              return checkCFunc(ns.SetVoiceOptionName)
            end,
            ShouldOverrideMessage = function()
              return checkCFunc(ns.ShouldOverrideMessage)
            end,
          })
        end,
        C_TaskQuest = function()
          local ns = _G.C_TaskQuest
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            DoesMapShowTaskQuestObjectives = function()
              return checkCFunc(ns.DoesMapShowTaskQuestObjectives)
            end,
            GetQuestInfoByQuestID = function()
              return checkCFunc(ns.GetQuestInfoByQuestID)
            end,
            GetQuestLocation = function()
              return checkCFunc(ns.GetQuestLocation)
            end,
            GetQuestProgressBarInfo = function()
              return checkCFunc(ns.GetQuestProgressBarInfo)
            end,
            GetQuestTimeLeftMinutes = function()
              return checkCFunc(ns.GetQuestTimeLeftMinutes)
            end,
            GetQuestTimeLeftSeconds = function()
              return checkCFunc(ns.GetQuestTimeLeftSeconds)
            end,
            GetQuestZoneID = function()
              return checkCFunc(ns.GetQuestZoneID)
            end,
            GetQuestsForPlayerByMapID = function()
              return checkCFunc(ns.GetQuestsForPlayerByMapID)
            end,
            GetThreatQuests = function()
              return checkCFunc(ns.GetThreatQuests)
            end,
            GetUIWidgetSetIDFromQuestID = function()
              return checkCFunc(ns.GetUIWidgetSetIDFromQuestID)
            end,
            IsActive = function()
              return checkCFunc(ns.IsActive)
            end,
            RequestPreloadRewardData = function()
              return checkCFunc(ns.RequestPreloadRewardData)
            end,
          })
        end,
        C_TaxiMap = function()
          local ns = _G.C_TaxiMap
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetAllTaxiNodes = function()
              return checkCFunc(ns.GetAllTaxiNodes)
            end,
            GetTaxiNodesForMap = function()
              return checkCFunc(ns.GetTaxiNodesForMap)
            end,
            ShouldMapShowTaxiNodes = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.ShouldMapShowTaxiNodes)
              end
              return checkCFunc(ns.ShouldMapShowTaxiNodes)
            end,
          })
        end,
        C_Texture = function()
          local ns = _G.C_Texture
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetAtlasInfo = function()
              return checkCFunc(ns.GetAtlasInfo)
            end,
          })
        end,
        C_Timer = function()
          local ns = _G.C_Timer
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            After = function()
              return checkCFunc(ns.After)
            end,
          })
        end,
        C_ToyBox = function()
          local ns = _G.C_ToyBox
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ForceToyRefilter = function()
              return checkCFunc(ns.ForceToyRefilter)
            end,
            GetCollectedShown = function()
              return checkCFunc(ns.GetCollectedShown)
            end,
            GetIsFavorite = function()
              return checkCFunc(ns.GetIsFavorite)
            end,
            GetNumFilteredToys = function()
              return checkCFunc(ns.GetNumFilteredToys)
            end,
            GetNumLearnedDisplayedToys = function()
              return checkCFunc(ns.GetNumLearnedDisplayedToys)
            end,
            GetNumTotalDisplayedToys = function()
              return checkCFunc(ns.GetNumTotalDisplayedToys)
            end,
            GetNumToys = function()
              return checkCFunc(ns.GetNumToys)
            end,
            GetToyFromIndex = function()
              return checkCFunc(ns.GetToyFromIndex)
            end,
            GetToyInfo = function()
              return checkCFunc(ns.GetToyInfo)
            end,
            GetToyLink = function()
              return checkCFunc(ns.GetToyLink)
            end,
            GetUncollectedShown = function()
              return checkCFunc(ns.GetUncollectedShown)
            end,
            GetUnusableShown = function()
              return checkCFunc(ns.GetUnusableShown)
            end,
            HasFavorites = function()
              return checkCFunc(ns.HasFavorites)
            end,
            IsExpansionTypeFilterChecked = function()
              return checkCFunc(ns.IsExpansionTypeFilterChecked)
            end,
            IsSourceTypeFilterChecked = function()
              return checkCFunc(ns.IsSourceTypeFilterChecked)
            end,
            IsToyUsable = function()
              return checkCFunc(ns.IsToyUsable)
            end,
            PickupToyBoxItem = function()
              return checkCFunc(ns.PickupToyBoxItem)
            end,
            SetAllExpansionTypeFilters = function()
              return checkCFunc(ns.SetAllExpansionTypeFilters)
            end,
            SetAllSourceTypeFilters = function()
              return checkCFunc(ns.SetAllSourceTypeFilters)
            end,
            SetCollectedShown = function()
              return checkCFunc(ns.SetCollectedShown)
            end,
            SetExpansionTypeFilter = function()
              return checkCFunc(ns.SetExpansionTypeFilter)
            end,
            SetFilterString = function()
              return checkCFunc(ns.SetFilterString)
            end,
            SetIsFavorite = function()
              return checkCFunc(ns.SetIsFavorite)
            end,
            SetSourceTypeFilter = function()
              return checkCFunc(ns.SetSourceTypeFilter)
            end,
            SetUncollectedShown = function()
              return checkCFunc(ns.SetUncollectedShown)
            end,
            SetUnusableShown = function()
              return checkCFunc(ns.SetUnusableShown)
            end,
          })
        end,
        C_ToyBoxInfo = function()
          local ns = _G.C_ToyBoxInfo
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ClearFanfare = function()
              return checkCFunc(ns.ClearFanfare)
            end,
            IsToySourceValid = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsToySourceValid)
              end
              return checkCFunc(ns.IsToySourceValid)
            end,
            IsUsingDefaultFilters = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.IsUsingDefaultFilters)
              end
              return checkCFunc(ns.IsUsingDefaultFilters)
            end,
            NeedsFanfare = function()
              return checkCFunc(ns.NeedsFanfare)
            end,
            SetDefaultFilters = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetDefaultFilters)
              end
              return checkCFunc(ns.SetDefaultFilters)
            end,
          })
        end,
        C_TradeSkillUI = function()
          local ns = _G.C_TradeSkillUI
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AnyRecipeCategoriesFiltered = function()
              return checkCFunc(ns.AnyRecipeCategoriesFiltered)
            end,
            AreAnyInventorySlotsFiltered = function()
              return checkCFunc(ns.AreAnyInventorySlotsFiltered)
            end,
            CanObliterateCursorItem = function()
              return checkCFunc(ns.CanObliterateCursorItem)
            end,
            CanTradeSkillListLink = function()
              return checkCFunc(ns.CanTradeSkillListLink)
            end,
            ClearInventorySlotFilter = function()
              return checkCFunc(ns.ClearInventorySlotFilter)
            end,
            ClearPendingObliterateItem = function()
              return checkCFunc(ns.ClearPendingObliterateItem)
            end,
            ClearRecipeCategoryFilter = function()
              return checkCFunc(ns.ClearRecipeCategoryFilter)
            end,
            ClearRecipeSourceTypeFilter = function()
              return checkCFunc(ns.ClearRecipeSourceTypeFilter)
            end,
            CloseObliterumForge = function()
              return checkCFunc(ns.CloseObliterumForge)
            end,
            CloseTradeSkill = function()
              return checkCFunc(ns.CloseTradeSkill)
            end,
            CraftRecipe = function()
              return checkCFunc(ns.CraftRecipe)
            end,
            DropPendingObliterateItemFromCursor = function()
              return checkCFunc(ns.DropPendingObliterateItemFromCursor)
            end,
            GetAllFilterableInventorySlots = function()
              return checkCFunc(ns.GetAllFilterableInventorySlots)
            end,
            GetAllProfessionTradeSkillLines = function()
              return checkCFunc(ns.GetAllProfessionTradeSkillLines)
            end,
            GetAllRecipeIDs = function()
              return checkCFunc(ns.GetAllRecipeIDs)
            end,
            GetCategories = function()
              return checkCFunc(ns.GetCategories)
            end,
            GetCategoryInfo = function()
              return checkCFunc(ns.GetCategoryInfo)
            end,
            GetFilterableInventorySlots = function()
              return checkCFunc(ns.GetFilterableInventorySlots)
            end,
            GetFilteredRecipeIDs = function()
              return checkCFunc(ns.GetFilteredRecipeIDs)
            end,
            GetObliterateSpellID = function()
              return checkCFunc(ns.GetObliterateSpellID)
            end,
            GetOnlyShowLearnedRecipes = function()
              return checkCFunc(ns.GetOnlyShowLearnedRecipes)
            end,
            GetOnlyShowMakeableRecipes = function()
              return checkCFunc(ns.GetOnlyShowMakeableRecipes)
            end,
            GetOnlyShowSkillUpRecipes = function()
              return checkCFunc(ns.GetOnlyShowSkillUpRecipes)
            end,
            GetOnlyShowUnlearnedRecipes = function()
              return checkCFunc(ns.GetOnlyShowUnlearnedRecipes)
            end,
            GetOptionalReagentBonusText = function()
              return checkCFunc(ns.GetOptionalReagentBonusText)
            end,
            GetOptionalReagentInfo = function()
              return checkCFunc(ns.GetOptionalReagentInfo)
            end,
            GetPendingObliterateItemID = function()
              return checkCFunc(ns.GetPendingObliterateItemID)
            end,
            GetPendingObliterateItemLink = function()
              return checkCFunc(ns.GetPendingObliterateItemLink)
            end,
            GetRecipeCooldown = function()
              return checkCFunc(ns.GetRecipeCooldown)
            end,
            GetRecipeDescription = function()
              return checkCFunc(ns.GetRecipeDescription)
            end,
            GetRecipeInfo = function()
              return checkCFunc(ns.GetRecipeInfo)
            end,
            GetRecipeItemLevelFilter = function()
              return checkCFunc(ns.GetRecipeItemLevelFilter)
            end,
            GetRecipeItemLink = function()
              return checkCFunc(ns.GetRecipeItemLink)
            end,
            GetRecipeItemNameFilter = function()
              return checkCFunc(ns.GetRecipeItemNameFilter)
            end,
            GetRecipeLink = function()
              return checkCFunc(ns.GetRecipeLink)
            end,
            GetRecipeNumItemsProduced = function()
              return checkCFunc(ns.GetRecipeNumItemsProduced)
            end,
            GetRecipeNumReagents = function()
              return checkCFunc(ns.GetRecipeNumReagents)
            end,
            GetRecipeReagentInfo = function()
              return checkCFunc(ns.GetRecipeReagentInfo)
            end,
            GetRecipeReagentItemLink = function()
              return checkCFunc(ns.GetRecipeReagentItemLink)
            end,
            GetRecipeRepeatCount = function()
              return checkCFunc(ns.GetRecipeRepeatCount)
            end,
            GetRecipeSourceText = function()
              return checkCFunc(ns.GetRecipeSourceText)
            end,
            GetRecipeTools = function()
              return checkCFunc(ns.GetRecipeTools)
            end,
            GetSubCategories = function()
              return checkCFunc(ns.GetSubCategories)
            end,
            GetTradeSkillDisplayName = function()
              return checkCFunc(ns.GetTradeSkillDisplayName)
            end,
            GetTradeSkillLine = function()
              return checkCFunc(ns.GetTradeSkillLine)
            end,
            GetTradeSkillLineForRecipe = function()
              return checkCFunc(ns.GetTradeSkillLineForRecipe)
            end,
            GetTradeSkillLineInfoByID = function()
              return checkCFunc(ns.GetTradeSkillLineInfoByID)
            end,
            GetTradeSkillListLink = function()
              return checkCFunc(ns.GetTradeSkillListLink)
            end,
            GetTradeSkillTexture = function()
              return checkCFunc(ns.GetTradeSkillTexture)
            end,
            IsAnyRecipeFromSource = function()
              return checkCFunc(ns.IsAnyRecipeFromSource)
            end,
            IsDataSourceChanging = function()
              return checkCFunc(ns.IsDataSourceChanging)
            end,
            IsEmptySkillLineCategory = function()
              return checkCFunc(ns.IsEmptySkillLineCategory)
            end,
            IsInventorySlotFiltered = function()
              return checkCFunc(ns.IsInventorySlotFiltered)
            end,
            IsNPCCrafting = function()
              return checkCFunc(ns.IsNPCCrafting)
            end,
            IsRecipeCategoryFiltered = function()
              return checkCFunc(ns.IsRecipeCategoryFiltered)
            end,
            IsRecipeFavorite = function()
              return checkCFunc(ns.IsRecipeFavorite)
            end,
            IsRecipeRepeating = function()
              return checkCFunc(ns.IsRecipeRepeating)
            end,
            IsRecipeSearchInProgress = function()
              return checkCFunc(ns.IsRecipeSearchInProgress)
            end,
            IsRecipeSourceTypeFiltered = function()
              return checkCFunc(ns.IsRecipeSourceTypeFiltered)
            end,
            IsTradeSkillGuild = function()
              return checkCFunc(ns.IsTradeSkillGuild)
            end,
            IsTradeSkillGuildMember = function()
              return checkCFunc(ns.IsTradeSkillGuildMember)
            end,
            IsTradeSkillLinked = function()
              return checkCFunc(ns.IsTradeSkillLinked)
            end,
            IsTradeSkillReady = function()
              return checkCFunc(ns.IsTradeSkillReady)
            end,
            ObliterateItem = function()
              return checkCFunc(ns.ObliterateItem)
            end,
            OpenTradeSkill = function()
              return checkCFunc(ns.OpenTradeSkill)
            end,
            SetInventorySlotFilter = function()
              return checkCFunc(ns.SetInventorySlotFilter)
            end,
            SetOnlyShowLearnedRecipes = function()
              return checkCFunc(ns.SetOnlyShowLearnedRecipes)
            end,
            SetOnlyShowMakeableRecipes = function()
              return checkCFunc(ns.SetOnlyShowMakeableRecipes)
            end,
            SetOnlyShowSkillUpRecipes = function()
              return checkCFunc(ns.SetOnlyShowSkillUpRecipes)
            end,
            SetOnlyShowUnlearnedRecipes = function()
              return checkCFunc(ns.SetOnlyShowUnlearnedRecipes)
            end,
            SetRecipeCategoryFilter = function()
              return checkCFunc(ns.SetRecipeCategoryFilter)
            end,
            SetRecipeFavorite = function()
              return checkCFunc(ns.SetRecipeFavorite)
            end,
            SetRecipeItemLevelFilter = function()
              return checkCFunc(ns.SetRecipeItemLevelFilter)
            end,
            SetRecipeItemNameFilter = function()
              return checkCFunc(ns.SetRecipeItemNameFilter)
            end,
            SetRecipeRepeatCount = function()
              return checkCFunc(ns.SetRecipeRepeatCount)
            end,
            SetRecipeSourceTypeFilter = function()
              return checkCFunc(ns.SetRecipeSourceTypeFilter)
            end,
            StopRecipeRepeat = function()
              return checkCFunc(ns.StopRecipeRepeat)
            end,
          })
        end,
        C_Transmog = function()
          local ns = _G.C_Transmog
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ApplyAllPending = function()
              return checkCFunc(ns.ApplyAllPending)
            end,
            CanHaveSecondaryAppearanceForSlotID = function()
              return checkCFunc(ns.CanHaveSecondaryAppearanceForSlotID)
            end,
            CanTransmogItem = function()
              return checkCFunc(ns.CanTransmogItem)
            end,
            CanTransmogItemWithItem = function()
              return checkCFunc(ns.CanTransmogItemWithItem)
            end,
            ClearAllPending = function()
              return checkCFunc(ns.ClearAllPending)
            end,
            ClearPending = function()
              return checkCFunc(ns.ClearPending)
            end,
            Close = function()
              return checkCFunc(ns.Close)
            end,
            ExtractTransmogIDList = function()
              return checkCFunc(ns.ExtractTransmogIDList)
            end,
            GetApplyCost = function()
              return checkCFunc(ns.GetApplyCost)
            end,
            GetApplyWarnings = function()
              return checkCFunc(ns.GetApplyWarnings)
            end,
            GetBaseCategory = function()
              return checkCFunc(ns.GetBaseCategory)
            end,
            GetCreatureDisplayIDForSource = function()
              return checkCFunc(ns.GetCreatureDisplayIDForSource)
            end,
            GetItemIDForSource = function()
              return checkCFunc(ns.GetItemIDForSource)
            end,
            GetPending = function()
              return checkCFunc(ns.GetPending)
            end,
            GetSlotEffectiveCategory = function()
              return checkCFunc(ns.GetSlotEffectiveCategory)
            end,
            GetSlotForInventoryType = function()
              return checkCFunc(ns.GetSlotForInventoryType)
            end,
            GetSlotInfo = function()
              return checkCFunc(ns.GetSlotInfo)
            end,
            GetSlotUseError = function()
              return checkCFunc(ns.GetSlotUseError)
            end,
            GetSlotVisualInfo = function()
              return checkCFunc(ns.GetSlotVisualInfo)
            end,
            IsAtTransmogNPC = function()
              return checkCFunc(ns.IsAtTransmogNPC)
            end,
            IsSlotBeingCollapsed = function()
              return checkCFunc(ns.IsSlotBeingCollapsed)
            end,
            LoadOutfit = function()
              return checkCFunc(ns.LoadOutfit)
            end,
            SetPending = function()
              return checkCFunc(ns.SetPending)
            end,
          })
        end,
        C_TransmogCollection = function()
          local ns = _G.C_TransmogCollection
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AccountCanCollectSource = function()
              return checkCFunc(ns.AccountCanCollectSource)
            end,
            AreAllCollectionTypeFiltersChecked = function()
              return checkCFunc(ns.AreAllCollectionTypeFiltersChecked)
            end,
            AreAllSourceTypeFiltersChecked = function()
              return checkCFunc(ns.AreAllSourceTypeFiltersChecked)
            end,
            CanAppearanceHaveIllusion = function()
              return checkCFunc(ns.CanAppearanceHaveIllusion)
            end,
            ClearNewAppearance = function()
              return checkCFunc(ns.ClearNewAppearance)
            end,
            ClearSearch = function()
              return checkCFunc(ns.ClearSearch)
            end,
            DeleteOutfit = function()
              return checkCFunc(ns.DeleteOutfit)
            end,
            EndSearch = function()
              return checkCFunc(ns.EndSearch)
            end,
            GetAllAppearanceSources = function()
              return checkCFunc(ns.GetAllAppearanceSources)
            end,
            GetAppearanceCameraID = function()
              return checkCFunc(ns.GetAppearanceCameraID)
            end,
            GetAppearanceCameraIDBySource = function()
              return checkCFunc(ns.GetAppearanceCameraIDBySource)
            end,
            GetAppearanceInfoBySource = function()
              return checkCFunc(ns.GetAppearanceInfoBySource)
            end,
            GetAppearanceSourceDrops = function()
              return checkCFunc(ns.GetAppearanceSourceDrops)
            end,
            GetAppearanceSourceInfo = function()
              return checkCFunc(ns.GetAppearanceSourceInfo)
            end,
            GetAppearanceSources = function()
              return checkCFunc(ns.GetAppearanceSources)
            end,
            GetArtifactAppearanceStrings = function()
              return checkCFunc(ns.GetArtifactAppearanceStrings)
            end,
            GetCategoryAppearances = function()
              return checkCFunc(ns.GetCategoryAppearances)
            end,
            GetCategoryCollectedCount = function()
              return checkCFunc(ns.GetCategoryCollectedCount)
            end,
            GetCategoryForItem = function()
              return checkCFunc(ns.GetCategoryForItem)
            end,
            GetCategoryInfo = function()
              return checkCFunc(ns.GetCategoryInfo)
            end,
            GetCategoryTotal = function()
              return checkCFunc(ns.GetCategoryTotal)
            end,
            GetCollectedShown = function()
              return checkCFunc(ns.GetCollectedShown)
            end,
            GetFallbackWeaponAppearance = function()
              return checkCFunc(ns.GetFallbackWeaponAppearance)
            end,
            GetIllusionInfo = function()
              return checkCFunc(ns.GetIllusionInfo)
            end,
            GetIllusionStrings = function()
              return checkCFunc(ns.GetIllusionStrings)
            end,
            GetIllusions = function()
              return checkCFunc(ns.GetIllusions)
            end,
            GetInspectItemTransmogInfoList = function()
              return checkCFunc(ns.GetInspectItemTransmogInfoList)
            end,
            GetIsAppearanceFavorite = function()
              return checkCFunc(ns.GetIsAppearanceFavorite)
            end,
            GetItemInfo = function()
              return checkCFunc(ns.GetItemInfo)
            end,
            GetItemTransmogInfoListFromOutfitHyperlink = function()
              return checkCFunc(ns.GetItemTransmogInfoListFromOutfitHyperlink)
            end,
            GetLatestAppearance = function()
              return checkCFunc(ns.GetLatestAppearance)
            end,
            GetNumMaxOutfits = function()
              return checkCFunc(ns.GetNumMaxOutfits)
            end,
            GetNumTransmogSources = function()
              return checkCFunc(ns.GetNumTransmogSources)
            end,
            GetOutfitHyperlinkFromItemTransmogInfoList = function()
              return checkCFunc(ns.GetOutfitHyperlinkFromItemTransmogInfoList)
            end,
            GetOutfitInfo = function()
              return checkCFunc(ns.GetOutfitInfo)
            end,
            GetOutfitItemTransmogInfoList = function()
              return checkCFunc(ns.GetOutfitItemTransmogInfoList)
            end,
            GetOutfits = function()
              return checkCFunc(ns.GetOutfits)
            end,
            GetPairedArtifactAppearance = function()
              return checkCFunc(ns.GetPairedArtifactAppearance)
            end,
            GetSourceIcon = function()
              return checkCFunc(ns.GetSourceIcon)
            end,
            GetSourceInfo = function()
              return checkCFunc(ns.GetSourceInfo)
            end,
            GetSourceItemID = function()
              return checkCFunc(ns.GetSourceItemID)
            end,
            GetSourceRequiredHoliday = function()
              return checkCFunc(ns.GetSourceRequiredHoliday)
            end,
            GetUncollectedShown = function()
              return checkCFunc(ns.GetUncollectedShown)
            end,
            HasFavorites = function()
              return checkCFunc(ns.HasFavorites)
            end,
            IsAppearanceHiddenVisual = function()
              return checkCFunc(ns.IsAppearanceHiddenVisual)
            end,
            IsCategoryValidForItem = function()
              return checkCFunc(ns.IsCategoryValidForItem)
            end,
            IsNewAppearance = function()
              return checkCFunc(ns.IsNewAppearance)
            end,
            IsSearchDBLoading = function()
              return checkCFunc(ns.IsSearchDBLoading)
            end,
            IsSearchInProgress = function()
              return checkCFunc(ns.IsSearchInProgress)
            end,
            IsSourceTypeFilterChecked = function()
              return checkCFunc(ns.IsSourceTypeFilterChecked)
            end,
            IsUsingDefaultFilters = function()
              return checkCFunc(ns.IsUsingDefaultFilters)
            end,
            ModifyOutfit = function()
              return checkCFunc(ns.ModifyOutfit)
            end,
            NewOutfit = function()
              return checkCFunc(ns.NewOutfit)
            end,
            PlayerCanCollectSource = function()
              return checkCFunc(ns.PlayerCanCollectSource)
            end,
            PlayerHasTransmog = function()
              return checkCFunc(ns.PlayerHasTransmog)
            end,
            PlayerHasTransmogByItemInfo = function()
              return checkCFunc(ns.PlayerHasTransmogByItemInfo)
            end,
            PlayerHasTransmogItemModifiedAppearance = function()
              return checkCFunc(ns.PlayerHasTransmogItemModifiedAppearance)
            end,
            PlayerKnowsSource = function()
              return checkCFunc(ns.PlayerKnowsSource)
            end,
            RenameOutfit = function()
              return checkCFunc(ns.RenameOutfit)
            end,
            SearchProgress = function()
              return checkCFunc(ns.SearchProgress)
            end,
            SearchSize = function()
              return checkCFunc(ns.SearchSize)
            end,
            SetAllCollectionTypeFilters = function()
              return checkCFunc(ns.SetAllCollectionTypeFilters)
            end,
            SetAllSourceTypeFilters = function()
              return checkCFunc(ns.SetAllSourceTypeFilters)
            end,
            SetCollectedShown = function()
              return checkCFunc(ns.SetCollectedShown)
            end,
            SetDefaultFilters = function()
              return checkCFunc(ns.SetDefaultFilters)
            end,
            SetIsAppearanceFavorite = function()
              return checkCFunc(ns.SetIsAppearanceFavorite)
            end,
            SetSearch = function()
              return checkCFunc(ns.SetSearch)
            end,
            SetSearchAndFilterCategory = function()
              return checkCFunc(ns.SetSearchAndFilterCategory)
            end,
            SetSourceTypeFilter = function()
              return checkCFunc(ns.SetSourceTypeFilter)
            end,
            SetUncollectedShown = function()
              return checkCFunc(ns.SetUncollectedShown)
            end,
            UpdateUsableAppearances = function()
              return checkCFunc(ns.UpdateUsableAppearances)
            end,
          })
        end,
        C_TransmogSets = function()
          local ns = _G.C_TransmogSets
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ClearLatestSource = function()
              return checkCFunc(ns.ClearLatestSource)
            end,
            ClearNewSource = function()
              return checkCFunc(ns.ClearNewSource)
            end,
            ClearSetNewSourcesForSlot = function()
              return checkCFunc(ns.ClearSetNewSourcesForSlot)
            end,
            GetAllSets = function()
              return checkCFunc(ns.GetAllSets)
            end,
            GetAllSourceIDs = function()
              return checkCFunc(ns.GetAllSourceIDs)
            end,
            GetBaseSetID = function()
              return checkCFunc(ns.GetBaseSetID)
            end,
            GetBaseSets = function()
              return checkCFunc(ns.GetBaseSets)
            end,
            GetBaseSetsCounts = function()
              return checkCFunc(ns.GetBaseSetsCounts)
            end,
            GetBaseSetsFilter = function()
              return checkCFunc(ns.GetBaseSetsFilter)
            end,
            GetCameraIDs = function()
              return checkCFunc(ns.GetCameraIDs)
            end,
            GetIsFavorite = function()
              return checkCFunc(ns.GetIsFavorite)
            end,
            GetLatestSource = function()
              return checkCFunc(ns.GetLatestSource)
            end,
            GetSetInfo = function()
              return checkCFunc(ns.GetSetInfo)
            end,
            GetSetNewSources = function()
              return checkCFunc(ns.GetSetNewSources)
            end,
            GetSetPrimaryAppearances = function()
              return checkCFunc(ns.GetSetPrimaryAppearances)
            end,
            GetSetsContainingSourceID = function()
              return checkCFunc(ns.GetSetsContainingSourceID)
            end,
            GetSourceIDsForSlot = function()
              return checkCFunc(ns.GetSourceIDsForSlot)
            end,
            GetSourcesForSlot = function()
              return checkCFunc(ns.GetSourcesForSlot)
            end,
            GetUsableSets = function()
              return checkCFunc(ns.GetUsableSets)
            end,
            GetVariantSets = function()
              return checkCFunc(ns.GetVariantSets)
            end,
            HasUsableSets = function()
              return checkCFunc(ns.HasUsableSets)
            end,
            IsBaseSetCollected = function()
              return checkCFunc(ns.IsBaseSetCollected)
            end,
            IsNewSource = function()
              return checkCFunc(ns.IsNewSource)
            end,
            IsSetVisible = function()
              return checkCFunc(ns.IsSetVisible)
            end,
            IsUsingDefaultBaseSetsFilters = function()
              return checkCFunc(ns.IsUsingDefaultBaseSetsFilters)
            end,
            SetBaseSetsFilter = function()
              return checkCFunc(ns.SetBaseSetsFilter)
            end,
            SetDefaultBaseSetsFilters = function()
              return checkCFunc(ns.SetDefaultBaseSetsFilters)
            end,
            SetHasNewSources = function()
              return checkCFunc(ns.SetHasNewSources)
            end,
            SetHasNewSourcesForSlot = function()
              return checkCFunc(ns.SetHasNewSourcesForSlot)
            end,
            SetIsFavorite = function()
              return checkCFunc(ns.SetIsFavorite)
            end,
          })
        end,
        C_Trophy = function()
          local ns = _G.C_Trophy
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            MonumentChangeAppearanceToTrophyID = function()
              return checkCFunc(ns.MonumentChangeAppearanceToTrophyID)
            end,
            MonumentCloseMonumentUI = function()
              return checkCFunc(ns.MonumentCloseMonumentUI)
            end,
            MonumentGetCount = function()
              return checkCFunc(ns.MonumentGetCount)
            end,
            MonumentGetSelectedTrophyID = function()
              return checkCFunc(ns.MonumentGetSelectedTrophyID)
            end,
            MonumentGetTrophyInfoByIndex = function()
              return checkCFunc(ns.MonumentGetTrophyInfoByIndex)
            end,
            MonumentLoadList = function()
              return checkCFunc(ns.MonumentLoadList)
            end,
            MonumentLoadSelectedTrophyID = function()
              return checkCFunc(ns.MonumentLoadSelectedTrophyID)
            end,
            MonumentRevertAppearanceToSaved = function()
              return checkCFunc(ns.MonumentRevertAppearanceToSaved)
            end,
            MonumentSaveSelection = function()
              return checkCFunc(ns.MonumentSaveSelection)
            end,
          })
        end,
        C_Tutorial = function()
          local ns = _G.C_Tutorial
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AbandonTutorialArea = function()
              return checkCFunc(ns.AbandonTutorialArea)
            end,
            ReturnToTutorialArea = function()
              return checkCFunc(ns.ReturnToTutorialArea)
            end,
          })
        end,
        C_UI = function()
          local ns = _G.C_UI
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            DoesAnyDisplayHaveNotch = function()
              return checkCFunc(ns.DoesAnyDisplayHaveNotch)
            end,
            GetTopLeftNotchSafeRegion = function()
              return checkCFunc(ns.GetTopLeftNotchSafeRegion)
            end,
            GetTopRightNotchSafeRegion = function()
              return checkCFunc(ns.GetTopRightNotchSafeRegion)
            end,
            Reload = function()
              return checkCFunc(ns.Reload)
            end,
            ShouldUIParentAvoidNotch = function()
              return checkCFunc(ns.ShouldUIParentAvoidNotch)
            end,
          })
        end,
        C_UIWidgetManager = function()
          local ns = _G.C_UIWidgetManager
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetAllWidgetsBySetID = function()
              return checkCFunc(ns.GetAllWidgetsBySetID)
            end,
            GetBelowMinimapWidgetSetID = function()
              return checkCFunc(ns.GetBelowMinimapWidgetSetID)
            end,
            GetBulletTextListWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetBulletTextListWidgetVisualizationInfo)
            end,
            GetCaptureBarWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetCaptureBarWidgetVisualizationInfo)
            end,
            GetCaptureZoneVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetCaptureZoneVisualizationInfo)
              end
              return checkCFunc(ns.GetCaptureZoneVisualizationInfo)
            end,
            GetDiscreteProgressStepsVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetDiscreteProgressStepsVisualizationInfo)
              end
              return checkCFunc(ns.GetDiscreteProgressStepsVisualizationInfo)
            end,
            GetDoubleIconAndTextWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetDoubleIconAndTextWidgetVisualizationInfo)
            end,
            GetDoubleStateIconRowVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetDoubleStateIconRowVisualizationInfo)
              end
              return checkCFunc(ns.GetDoubleStateIconRowVisualizationInfo)
            end,
            GetDoubleStatusBarWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetDoubleStatusBarWidgetVisualizationInfo)
            end,
            GetHorizontalCurrenciesWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetHorizontalCurrenciesWidgetVisualizationInfo)
            end,
            GetIconAndTextWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetIconAndTextWidgetVisualizationInfo)
            end,
            GetIconTextAndBackgroundWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetIconTextAndBackgroundWidgetVisualizationInfo)
            end,
            GetIconTextAndCurrenciesWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetIconTextAndCurrenciesWidgetVisualizationInfo)
            end,
            GetObjectiveTrackerWidgetSetID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetObjectiveTrackerWidgetSetID)
              end
              return checkCFunc(ns.GetObjectiveTrackerWidgetSetID)
            end,
            GetPowerBarWidgetSetID = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetPowerBarWidgetSetID)
              end
              return checkCFunc(ns.GetPowerBarWidgetSetID)
            end,
            GetScenarioHeaderCurrenciesAndBackgroundWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetScenarioHeaderCurrenciesAndBackgroundWidgetVisualizationInfo)
            end,
            GetScenarioHeaderTimerWidgetVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetScenarioHeaderTimerWidgetVisualizationInfo)
              end
              return checkCFunc(ns.GetScenarioHeaderTimerWidgetVisualizationInfo)
            end,
            GetSpacerVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetSpacerVisualizationInfo)
              end
              return checkCFunc(ns.GetSpacerVisualizationInfo)
            end,
            GetSpellDisplayVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetSpellDisplayVisualizationInfo)
              end
              return checkCFunc(ns.GetSpellDisplayVisualizationInfo)
            end,
            GetStackedResourceTrackerWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetStackedResourceTrackerWidgetVisualizationInfo)
            end,
            GetStatusBarWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetStatusBarWidgetVisualizationInfo)
            end,
            GetTextColumnRowVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetTextColumnRowVisualizationInfo)
              end
              return checkCFunc(ns.GetTextColumnRowVisualizationInfo)
            end,
            GetTextWithStateWidgetVisualizationInfo = function()
              return checkCFunc(ns.GetTextWithStateWidgetVisualizationInfo)
            end,
            GetTextureAndTextRowVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetTextureAndTextRowVisualizationInfo)
              end
              return checkCFunc(ns.GetTextureAndTextRowVisualizationInfo)
            end,
            GetTextureAndTextVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetTextureAndTextVisualizationInfo)
              end
              return checkCFunc(ns.GetTextureAndTextVisualizationInfo)
            end,
            GetTextureWithAnimationVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetTextureWithAnimationVisualizationInfo)
              end
              return checkCFunc(ns.GetTextureWithAnimationVisualizationInfo)
            end,
            GetTextureWithStateVisualizationInfo = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetTextureWithStateVisualizationInfo)
              end
              return checkCFunc(ns.GetTextureWithStateVisualizationInfo)
            end,
            GetTopCenterWidgetSetID = function()
              return checkCFunc(ns.GetTopCenterWidgetSetID)
            end,
            GetUnitPowerBarWidgetVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetUnitPowerBarWidgetVisualizationInfo)
              end
              return checkCFunc(ns.GetUnitPowerBarWidgetVisualizationInfo)
            end,
            GetWidgetSetInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetWidgetSetInfo)
              end
              return checkCFunc(ns.GetWidgetSetInfo)
            end,
            GetZoneControlVisualizationInfo = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetZoneControlVisualizationInfo)
              end
              return checkCFunc(ns.GetZoneControlVisualizationInfo)
            end,
            RegisterUnitForWidgetUpdates = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.RegisterUnitForWidgetUpdates)
              end
              return checkCFunc(ns.RegisterUnitForWidgetUpdates)
            end,
            SetProcessingUnit = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetProcessingUnit)
              end
              return checkCFunc(ns.SetProcessingUnit)
            end,
            SetProcessingUnitGuid = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SetProcessingUnitGuid)
              end
              return checkCFunc(ns.SetProcessingUnitGuid)
            end,
            UnregisterUnitForWidgetUpdates = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.UnregisterUnitForWidgetUpdates)
              end
              return checkCFunc(ns.UnregisterUnitForWidgetUpdates)
            end,
          })
        end,
        C_UserFeedback = function()
          local ns = _G.C_UserFeedback
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            SubmitBug = function()
              return checkCFunc(ns.SubmitBug)
            end,
            SubmitSuggestion = function()
              return checkCFunc(ns.SubmitSuggestion)
            end,
          })
        end,
        C_VideoOptions = function()
          local ns = _G.C_VideoOptions
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetGxAdapterInfo = function()
              return checkCFunc(ns.GetGxAdapterInfo)
            end,
          })
        end,
        C_VignetteInfo = function()
          local ns = _G.C_VignetteInfo
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            FindBestUniqueVignette = function()
              return checkCFunc(ns.FindBestUniqueVignette)
            end,
            GetVignetteInfo = function()
              return checkCFunc(ns.GetVignetteInfo)
            end,
            GetVignettePosition = function()
              return checkCFunc(ns.GetVignettePosition)
            end,
            GetVignettes = function()
              return checkCFunc(ns.GetVignettes)
            end,
          })
        end,
        C_VoiceChat = function()
          local ns = _G.C_VoiceChat
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            ActivateChannel = function()
              return checkCFunc(ns.ActivateChannel)
            end,
            ActivateChannelTranscription = function()
              return checkCFunc(ns.ActivateChannelTranscription)
            end,
            BeginLocalCapture = function()
              return checkCFunc(ns.BeginLocalCapture)
            end,
            CanPlayerUseVoiceChat = function()
              return checkCFunc(ns.CanPlayerUseVoiceChat)
            end,
            CreateChannel = function()
              return checkCFunc(ns.CreateChannel)
            end,
            DeactivateChannel = function()
              return checkCFunc(ns.DeactivateChannel)
            end,
            DeactivateChannelTranscription = function()
              return checkCFunc(ns.DeactivateChannelTranscription)
            end,
            EndLocalCapture = function()
              return checkCFunc(ns.EndLocalCapture)
            end,
            GetActiveChannelID = function()
              return checkCFunc(ns.GetActiveChannelID)
            end,
            GetActiveChannelType = function()
              return checkCFunc(ns.GetActiveChannelType)
            end,
            GetAvailableInputDevices = function()
              return checkCFunc(ns.GetAvailableInputDevices)
            end,
            GetAvailableOutputDevices = function()
              return checkCFunc(ns.GetAvailableOutputDevices)
            end,
            GetChannel = function()
              return checkCFunc(ns.GetChannel)
            end,
            GetChannelForChannelType = function()
              return checkCFunc(ns.GetChannelForChannelType)
            end,
            GetChannelForCommunityStream = function()
              return checkCFunc(ns.GetChannelForCommunityStream)
            end,
            GetCommunicationMode = function()
              return checkCFunc(ns.GetCommunicationMode)
            end,
            GetCurrentVoiceChatConnectionStatusCode = function()
              return checkCFunc(ns.GetCurrentVoiceChatConnectionStatusCode)
            end,
            GetInputVolume = function()
              return checkCFunc(ns.GetInputVolume)
            end,
            GetJoinClubVoiceChannelError = function()
              if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.GetJoinClubVoiceChannelError)
              end
              return checkCFunc(ns.GetJoinClubVoiceChannelError)
            end,
            GetLocalPlayerActiveChannelMemberInfo = function()
              return checkCFunc(ns.GetLocalPlayerActiveChannelMemberInfo)
            end,
            GetLocalPlayerMemberID = function()
              return checkCFunc(ns.GetLocalPlayerMemberID)
            end,
            GetMasterVolumeScale = function()
              return checkCFunc(ns.GetMasterVolumeScale)
            end,
            GetMemberGUID = function()
              return checkCFunc(ns.GetMemberGUID)
            end,
            GetMemberID = function()
              return checkCFunc(ns.GetMemberID)
            end,
            GetMemberInfo = function()
              return checkCFunc(ns.GetMemberInfo)
            end,
            GetMemberName = function()
              return checkCFunc(ns.GetMemberName)
            end,
            GetMemberVolume = function()
              return checkCFunc(ns.GetMemberVolume)
            end,
            GetOutputVolume = function()
              return checkCFunc(ns.GetOutputVolume)
            end,
            GetPTTButtonPressedState = function()
              return checkCFunc(ns.GetPTTButtonPressedState)
            end,
            GetProcesses = function()
              return checkCFunc(ns.GetProcesses)
            end,
            GetPushToTalkBinding = function()
              return checkCFunc(ns.GetPushToTalkBinding)
            end,
            GetRemoteTtsVoices = function()
              return checkCFunc(ns.GetRemoteTtsVoices)
            end,
            GetTtsVoices = function()
              return checkCFunc(ns.GetTtsVoices)
            end,
            GetVADSensitivity = function()
              return checkCFunc(ns.GetVADSensitivity)
            end,
            IsChannelJoinPending = function()
              return checkCFunc(ns.IsChannelJoinPending)
            end,
            IsDeafened = function()
              return checkCFunc(ns.IsDeafened)
            end,
            IsEnabled = function()
              return checkCFunc(ns.IsEnabled)
            end,
            IsLoggedIn = function()
              return checkCFunc(ns.IsLoggedIn)
            end,
            IsMemberLocalPlayer = function()
              return checkCFunc(ns.IsMemberLocalPlayer)
            end,
            IsMemberMuted = function()
              return checkCFunc(ns.IsMemberMuted)
            end,
            IsMemberMutedForAll = function()
              return checkCFunc(ns.IsMemberMutedForAll)
            end,
            IsMemberSilenced = function()
              return checkCFunc(ns.IsMemberSilenced)
            end,
            IsMuted = function()
              return checkCFunc(ns.IsMuted)
            end,
            IsParentalDisabled = function()
              return checkCFunc(ns.IsParentalDisabled)
            end,
            IsParentalMuted = function()
              return checkCFunc(ns.IsParentalMuted)
            end,
            IsPlayerUsingVoice = function()
              return checkCFunc(ns.IsPlayerUsingVoice)
            end,
            IsSilenced = function()
              return checkCFunc(ns.IsSilenced)
            end,
            IsSpeakForMeActive = function()
              return checkCFunc(ns.IsSpeakForMeActive)
            end,
            IsSpeakForMeAllowed = function()
              return checkCFunc(ns.IsSpeakForMeAllowed)
            end,
            IsTranscriptionAllowed = function()
              return checkCFunc(ns.IsTranscriptionAllowed)
            end,
            LeaveChannel = function()
              return checkCFunc(ns.LeaveChannel)
            end,
            Login = function()
              return checkCFunc(ns.Login)
            end,
            Logout = function()
              return checkCFunc(ns.Logout)
            end,
            MarkChannelsDiscovered = function()
              return checkCFunc(ns.MarkChannelsDiscovered)
            end,
            RequestJoinAndActivateCommunityStreamChannel = function()
              return checkCFunc(ns.RequestJoinAndActivateCommunityStreamChannel)
            end,
            RequestJoinChannelByChannelType = function()
              return checkCFunc(ns.RequestJoinChannelByChannelType)
            end,
            SetCommunicationMode = function()
              return checkCFunc(ns.SetCommunicationMode)
            end,
            SetDeafened = function()
              return checkCFunc(ns.SetDeafened)
            end,
            SetInputDevice = function()
              return checkCFunc(ns.SetInputDevice)
            end,
            SetInputVolume = function()
              return checkCFunc(ns.SetInputVolume)
            end,
            SetMasterVolumeScale = function()
              return checkCFunc(ns.SetMasterVolumeScale)
            end,
            SetMemberMuted = function()
              return checkCFunc(ns.SetMemberMuted)
            end,
            SetMemberVolume = function()
              return checkCFunc(ns.SetMemberVolume)
            end,
            SetMuted = function()
              return checkCFunc(ns.SetMuted)
            end,
            SetOutputDevice = function()
              return checkCFunc(ns.SetOutputDevice)
            end,
            SetOutputVolume = function()
              return checkCFunc(ns.SetOutputVolume)
            end,
            SetPortraitTexture = function()
              return checkCFunc(ns.SetPortraitTexture)
            end,
            SetPushToTalkBinding = function()
              return checkCFunc(ns.SetPushToTalkBinding)
            end,
            SetVADSensitivity = function()
              return checkCFunc(ns.SetVADSensitivity)
            end,
            ShouldDiscoverChannels = function()
              return checkCFunc(ns.ShouldDiscoverChannels)
            end,
            SpeakRemoteTextSample = function()
              return checkCFunc(ns.SpeakRemoteTextSample)
            end,
            SpeakText = function()
              return checkCFunc(ns.SpeakText)
            end,
            StopSpeakingText = function()
              return checkCFunc(ns.StopSpeakingText)
            end,
            ToggleDeafened = function()
              return checkCFunc(ns.ToggleDeafened)
            end,
            ToggleMemberMuted = function()
              return checkCFunc(ns.ToggleMemberMuted)
            end,
            ToggleMuted = function()
              return checkCFunc(ns.ToggleMuted)
            end,
          })
        end,
        C_WeeklyRewards = function()
          local ns = _G.C_WeeklyRewards
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            AreRewardsForCurrentRewardPeriod = function()
              return checkCFunc(ns.AreRewardsForCurrentRewardPeriod)
            end,
            CanClaimRewards = function()
              return checkCFunc(ns.CanClaimRewards)
            end,
            ClaimReward = function()
              return checkCFunc(ns.ClaimReward)
            end,
            CloseInteraction = function()
              return checkCFunc(ns.CloseInteraction)
            end,
            GetActivities = function()
              return checkCFunc(ns.GetActivities)
            end,
            GetActivityEncounterInfo = function()
              return checkCFunc(ns.GetActivityEncounterInfo)
            end,
            GetConquestWeeklyProgress = function()
              return checkCFunc(ns.GetConquestWeeklyProgress)
            end,
            GetExampleRewardItemHyperlinks = function()
              return checkCFunc(ns.GetExampleRewardItemHyperlinks)
            end,
            GetItemHyperlink = function()
              return checkCFunc(ns.GetItemHyperlink)
            end,
            GetNextMythicPlusIncrease = function()
              return checkCFunc(ns.GetNextMythicPlusIncrease)
            end,
            HasAvailableRewards = function()
              return checkCFunc(ns.HasAvailableRewards)
            end,
            HasGeneratedRewards = function()
              return checkCFunc(ns.HasGeneratedRewards)
            end,
            HasInteraction = function()
              return checkCFunc(ns.HasInteraction)
            end,
            OnUIInteract = function()
              return checkCFunc(ns.OnUIInteract)
            end,
          })
        end,
        C_Widget = function()
          local ns = _G.C_Widget
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            IsFrameWidget = function()
              return checkCFunc(ns.IsFrameWidget)
            end,
            IsRenderableWidget = function()
              return checkCFunc(ns.IsRenderableWidget)
            end,
            IsWidget = function()
              return checkCFunc(ns.IsWidget)
            end,
          })
        end,
        C_WowTokenPublic = function()
          local ns = _G.C_WowTokenPublic
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            BuyToken = function()
              return checkCFunc(ns.BuyToken)
            end,
            GetCommerceSystemStatus = function()
              return checkCFunc(ns.GetCommerceSystemStatus)
            end,
            GetCurrentMarketPrice = function()
              return checkCFunc(ns.GetCurrentMarketPrice)
            end,
            GetGuaranteedPrice = function()
              return checkCFunc(ns.GetGuaranteedPrice)
            end,
            GetListedAuctionableTokenInfo = function()
              return checkCFunc(ns.GetListedAuctionableTokenInfo)
            end,
            GetNumListedAuctionableTokens = function()
              return checkCFunc(ns.GetNumListedAuctionableTokens)
            end,
            IsAuctionableWowToken = function()
              return checkCFunc(ns.IsAuctionableWowToken)
            end,
            IsConsumableWowToken = function()
              return checkCFunc(ns.IsConsumableWowToken)
            end,
            SellToken = function()
              if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                return checkNotCFunc(ns.SellToken)
              end
              return checkCFunc(ns.SellToken)
            end,
            UpdateListedAuctionableTokens = function()
              return checkCFunc(ns.UpdateListedAuctionableTokens)
            end,
            UpdateMarketPrice = function()
              return checkCFunc(ns.UpdateMarketPrice)
            end,
            UpdateTokenCount = function()
              return checkCFunc(ns.UpdateTokenCount)
            end,
          })
        end,
        C_WowTokenUI = function()
          local ns = _G.C_WowTokenUI
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            StartTokenSell = function()
              return checkCFunc(ns.StartTokenSell)
            end,
          })
        end,
        C_ZoneAbility = function()
          local ns = _G.C_ZoneAbility
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertEquals('nil', type(ns))
            return
          end
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetActiveAbilities = function()
              return checkCFunc(ns.GetActiveAbilities)
            end,
          })
        end,
        Kiosk = function()
          local ns = _G.Kiosk
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            GetCharacterTemplateSetIndex = function()
              return checkCFunc(ns.GetCharacterTemplateSetIndex)
            end,
            IsEnabled = function()
              return checkCFunc(ns.IsEnabled)
            end,
            ShutdownSession = function()
              return checkCFunc(ns.ShutdownSession)
            end,
            StartSession = function()
              return checkCFunc(ns.StartSession)
            end,
          })
        end,
        bit = function()
          local ns = _G.bit
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            arshift = function()
              return checkCFunc(ns.arshift)
            end,
            band = function()
              return checkCFunc(ns.band)
            end,
            bnot = function()
              return checkCFunc(ns.bnot)
            end,
            bor = function()
              return checkCFunc(ns.bor)
            end,
            bxor = function()
              return checkCFunc(ns.bxor)
            end,
            lshift = function()
              return checkCFunc(ns.lshift)
            end,
            mod = function()
              return checkCFunc(ns.mod)
            end,
            rshift = function()
              return checkCFunc(ns.rshift)
            end,
          })
        end,
        coroutine = function()
          local ns = _G.coroutine
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            create = function()
              return checkCFunc(ns.create)
            end,
            resume = function()
              return checkCFunc(ns.resume)
            end,
            running = function()
              return checkCFunc(ns.running)
            end,
            status = function()
              return checkCFunc(ns.status)
            end,
            wrap = function()
              return checkCFunc(ns.wrap)
            end,
            yield = function()
              return checkCFunc(ns.yield)
            end,
          })
        end,
        math = function()
          local ns = _G.math
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            abs = function()
              return checkCFunc(ns.abs)
            end,
            acos = function()
              return checkCFunc(ns.acos)
            end,
            asin = function()
              return checkCFunc(ns.asin)
            end,
            atan = function()
              return checkCFunc(ns.atan)
            end,
            atan2 = function()
              return checkCFunc(ns.atan2)
            end,
            ceil = function()
              return checkCFunc(ns.ceil)
            end,
            cos = function()
              return checkCFunc(ns.cos)
            end,
            cosh = function()
              return checkCFunc(ns.cosh)
            end,
            deg = function()
              return checkCFunc(ns.deg)
            end,
            exp = function()
              return checkCFunc(ns.exp)
            end,
            floor = function()
              return checkCFunc(ns.floor)
            end,
            fmod = function()
              return checkCFunc(ns.fmod)
            end,
            frexp = function()
              return checkCFunc(ns.frexp)
            end,
            huge = function()
              assertEquals('number', type(ns.huge))
            end,
            ldexp = function()
              return checkCFunc(ns.ldexp)
            end,
            log = function()
              return checkCFunc(ns.log)
            end,
            log10 = function()
              return checkCFunc(ns.log10)
            end,
            max = function()
              return checkCFunc(ns.max)
            end,
            min = function()
              return checkCFunc(ns.min)
            end,
            modf = function()
              return checkCFunc(ns.modf)
            end,
            pi = function()
              assertEquals('number', type(ns.pi))
            end,
            pow = function()
              return checkCFunc(ns.pow)
            end,
            rad = function()
              return checkCFunc(ns.rad)
            end,
            random = function()
              return checkCFunc(ns.random)
            end,
            sin = function()
              return checkCFunc(ns.sin)
            end,
            sinh = function()
              return checkCFunc(ns.sinh)
            end,
            sqrt = function()
              return checkCFunc(ns.sqrt)
            end,
            tan = function()
              return checkCFunc(ns.tan)
            end,
            tanh = function()
              return checkCFunc(ns.tanh)
            end,
          })
        end,
        string = function()
          local ns = _G.string
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            byte = function()
              return checkCFunc(ns.byte)
            end,
            char = function()
              return checkCFunc(ns.char)
            end,
            find = function()
              return checkCFunc(ns.find)
            end,
            format = function()
              return checkCFunc(ns.format)
            end,
            gfind = function()
              return checkCFunc(ns.gfind)
            end,
            gmatch = function()
              return checkCFunc(ns.gmatch)
            end,
            gsub = function()
              return checkCFunc(ns.gsub)
            end,
            join = function()
              return checkCFunc(ns.join)
            end,
            len = function()
              return checkCFunc(ns.len)
            end,
            lower = function()
              return checkCFunc(ns.lower)
            end,
            match = function()
              return checkCFunc(ns.match)
            end,
            rep = function()
              return checkCFunc(ns.rep)
            end,
            reverse = function()
              return checkCFunc(ns.reverse)
            end,
            split = function()
              return checkCFunc(ns.split)
            end,
            sub = function()
              return checkCFunc(ns.sub)
            end,
            trim = function()
              return checkCFunc(ns.trim)
            end,
            upper = function()
              return checkCFunc(ns.upper)
            end,
          })
        end,
        table = function()
          local ns = _G.table
          assertEquals('table', type(ns))
          assert(getmetatable(ns) == nil)
          return mkTests(ns, {
            concat = function()
              return checkCFunc(ns.concat)
            end,
            foreach = function()
              return checkCFunc(ns.foreach)
            end,
            foreachi = function()
              return checkCFunc(ns.foreachi)
            end,
            getn = function()
              return checkCFunc(ns.getn)
            end,
            insert = function()
              return checkCFunc(ns.insert)
            end,
            maxn = function()
              return checkCFunc(ns.maxn)
            end,
            remove = function()
              return checkCFunc(ns.remove)
            end,
            removemulti = function()
              return checkCFunc(ns.removemulti)
            end,
            setn = function()
              return checkCFunc(ns.setn)
            end,
            sort = function()
              return checkCFunc(ns.sort)
            end,
            wipe = function()
              return checkCFunc(ns.wipe)
            end,
          })
        end,
      }
    end,
    globalApis = function()
      local tests = {
        AbandonQuest = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.AbandonQuest)
          end
          return checkCFunc(_G.AbandonQuest)
        end,
        AbandonSkill = function()
          return checkCFunc(_G.AbandonSkill)
        end,
        AcceptAreaSpiritHeal = function()
          return checkCFunc(_G.AcceptAreaSpiritHeal)
        end,
        AcceptArenaTeam = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.AcceptArenaTeam)
          end
          return checkCFunc(_G.AcceptArenaTeam)
        end,
        AcceptBattlefieldPort = function()
          return checkCFunc(_G.AcceptBattlefieldPort)
        end,
        AcceptDuel = function()
          return checkCFunc(_G.AcceptDuel)
        end,
        AcceptGroup = function()
          return checkCFunc(_G.AcceptGroup)
        end,
        AcceptGuild = function()
          return checkCFunc(_G.AcceptGuild)
        end,
        AcceptProposal = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.AcceptProposal)
          end
          return checkCFunc(_G.AcceptProposal)
        end,
        AcceptQuest = function()
          return checkCFunc(_G.AcceptQuest)
        end,
        AcceptResurrect = function()
          return checkCFunc(_G.AcceptResurrect)
        end,
        AcceptSockets = function()
          return checkCFunc(_G.AcceptSockets)
        end,
        AcceptSpellConfirmationPrompt = function()
          return checkCFunc(_G.AcceptSpellConfirmationPrompt)
        end,
        AcceptTrade = function()
          return checkCFunc(_G.AcceptTrade)
        end,
        AcceptXPLoss = function()
          return checkCFunc(_G.AcceptXPLoss)
        end,
        AcknowledgeAutoAcceptQuest = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.AcknowledgeAutoAcceptQuest)
          end
          return checkCFunc(_G.AcknowledgeAutoAcceptQuest)
        end,
        AcknowledgeSurvey = function()
          return checkCFunc(_G.AcknowledgeSurvey)
        end,
        ActionBindsItem = function()
          return checkCFunc(_G.ActionBindsItem)
        end,
        ActionHasRange = function()
          return checkCFunc(_G.ActionHasRange)
        end,
        AddAutoQuestPopUp = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.AddAutoQuestPopUp)
          end
          return checkCFunc(_G.AddAutoQuestPopUp)
        end,
        AddChatWindowChannel = function()
          return checkCFunc(_G.AddChatWindowChannel)
        end,
        AddChatWindowMessages = function()
          return checkCFunc(_G.AddChatWindowMessages)
        end,
        AddQuestWatch = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.AddQuestWatch)
          end
          return checkCFunc(_G.AddQuestWatch)
        end,
        AddTrackedAchievement = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.AddTrackedAchievement)
          end
          return checkCFunc(_G.AddTrackedAchievement)
        end,
        AddTradeMoney = function()
          return checkCFunc(_G.AddTradeMoney)
        end,
        Ambiguate = function()
          return checkCFunc(_G.Ambiguate)
        end,
        AntiAliasingSupported = function()
          return checkCFunc(_G.AntiAliasingSupported)
        end,
        ArchaeologyGetIconInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ArchaeologyGetIconInfo)
          end
          return checkCFunc(_G.ArchaeologyGetIconInfo)
        end,
        ArchaeologyMapUpdateAll = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ArchaeologyMapUpdateAll)
          end
          return checkCFunc(_G.ArchaeologyMapUpdateAll)
        end,
        ArcheologyGetVisibleBlobID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ArcheologyGetVisibleBlobID)
          end
          return checkCFunc(_G.ArcheologyGetVisibleBlobID)
        end,
        AreAccountAchievementsHidden = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.AreAccountAchievementsHidden)
          end
          return checkCFunc(_G.AreAccountAchievementsHidden)
        end,
        AreDangerousScriptsAllowed = function()
          return checkCFunc(_G.AreDangerousScriptsAllowed)
        end,
        AreTalentsLocked = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.AreTalentsLocked)
          end
          return checkCFunc(_G.AreTalentsLocked)
        end,
        ArenaTeamDisband = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ArenaTeamDisband)
          end
          return checkCFunc(_G.ArenaTeamDisband)
        end,
        ArenaTeamInviteByName = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ArenaTeamInviteByName)
          end
          return checkCFunc(_G.ArenaTeamInviteByName)
        end,
        ArenaTeamLeave = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ArenaTeamLeave)
          end
          return checkCFunc(_G.ArenaTeamLeave)
        end,
        ArenaTeamRoster = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ArenaTeamRoster)
          end
          return checkCFunc(_G.ArenaTeamRoster)
        end,
        ArenaTeamSetLeaderByName = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ArenaTeamSetLeaderByName)
          end
          return checkCFunc(_G.ArenaTeamSetLeaderByName)
        end,
        ArenaTeamUninviteByName = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ArenaTeamUninviteByName)
          end
          return checkCFunc(_G.ArenaTeamUninviteByName)
        end,
        AscendStop = function()
          return checkCFunc(_G.AscendStop)
        end,
        AssistUnit = function()
          return checkCFunc(_G.AssistUnit)
        end,
        AttachGlyphToSpell = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.AttachGlyphToSpell)
          end
          return checkCFunc(_G.AttachGlyphToSpell)
        end,
        AttackTarget = function()
          return checkCFunc(_G.AttackTarget)
        end,
        AutoChooseCurrentGraphicsSetting = function()
          return checkCFunc(_G.AutoChooseCurrentGraphicsSetting)
        end,
        AutoEquipCursorItem = function()
          return checkCFunc(_G.AutoEquipCursorItem)
        end,
        AutoLootMailItem = function()
          return checkCFunc(_G.AutoLootMailItem)
        end,
        AutoStoreGuildBankItem = function()
          return checkCFunc(_G.AutoStoreGuildBankItem)
        end,
        BNAcceptFriendInvite = function()
          return checkCFunc(_G.BNAcceptFriendInvite)
        end,
        BNCheckBattleTagInviteToGuildMember = function()
          return checkCFunc(_G.BNCheckBattleTagInviteToGuildMember)
        end,
        BNCheckBattleTagInviteToUnit = function()
          return checkCFunc(_G.BNCheckBattleTagInviteToUnit)
        end,
        BNConnected = function()
          return checkCFunc(_G.BNConnected)
        end,
        BNDeclineFriendInvite = function()
          return checkCFunc(_G.BNDeclineFriendInvite)
        end,
        BNFeaturesEnabled = function()
          return checkCFunc(_G.BNFeaturesEnabled)
        end,
        BNFeaturesEnabledAndConnected = function()
          return checkCFunc(_G.BNFeaturesEnabledAndConnected)
        end,
        BNGetBlockedInfo = function()
          return checkCFunc(_G.BNGetBlockedInfo)
        end,
        BNGetDisplayName = function()
          return checkCFunc(_G.BNGetDisplayName)
        end,
        BNGetFOFInfo = function()
          return checkCFunc(_G.BNGetFOFInfo)
        end,
        BNGetFriendGameAccountInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BNGetFriendGameAccountInfo)
          end
          return checkCFunc(_G.BNGetFriendGameAccountInfo)
        end,
        BNGetFriendIndex = function()
          return checkCFunc(_G.BNGetFriendIndex)
        end,
        BNGetFriendInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BNGetFriendInfo)
          end
          return checkCFunc(_G.BNGetFriendInfo)
        end,
        BNGetFriendInfoByID = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BNGetFriendInfoByID)
          end
          return checkCFunc(_G.BNGetFriendInfoByID)
        end,
        BNGetFriendInviteInfo = function()
          return checkCFunc(_G.BNGetFriendInviteInfo)
        end,
        BNGetGameAccountInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BNGetGameAccountInfo)
          end
          return checkCFunc(_G.BNGetGameAccountInfo)
        end,
        BNGetGameAccountInfoByGUID = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BNGetGameAccountInfoByGUID)
          end
          return checkCFunc(_G.BNGetGameAccountInfoByGUID)
        end,
        BNGetInfo = function()
          return checkCFunc(_G.BNGetInfo)
        end,
        BNGetNumBlocked = function()
          return checkCFunc(_G.BNGetNumBlocked)
        end,
        BNGetNumFOF = function()
          return checkCFunc(_G.BNGetNumFOF)
        end,
        BNGetNumFriendGameAccounts = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BNGetNumFriendGameAccounts)
          end
          return checkCFunc(_G.BNGetNumFriendGameAccounts)
        end,
        BNGetNumFriendInvites = function()
          return checkCFunc(_G.BNGetNumFriendInvites)
        end,
        BNGetNumFriends = function()
          return checkCFunc(_G.BNGetNumFriends)
        end,
        BNGetSelectedBlock = function()
          return checkCFunc(_G.BNGetSelectedBlock)
        end,
        BNGetSelectedFriend = function()
          return checkCFunc(_G.BNGetSelectedFriend)
        end,
        BNInviteFriend = function()
          return checkCFunc(_G.BNInviteFriend)
        end,
        BNIsBlocked = function()
          return checkCFunc(_G.BNIsBlocked)
        end,
        BNIsFriend = function()
          return checkCFunc(_G.BNIsFriend)
        end,
        BNIsSelf = function()
          return checkCFunc(_G.BNIsSelf)
        end,
        BNRemoveFriend = function()
          return checkCFunc(_G.BNRemoveFriend)
        end,
        BNRequestFOFInfo = function()
          return checkCFunc(_G.BNRequestFOFInfo)
        end,
        BNRequestInviteFriend = function()
          return checkCFunc(_G.BNRequestInviteFriend)
        end,
        BNSendFriendInvite = function()
          return checkCFunc(_G.BNSendFriendInvite)
        end,
        BNSendFriendInviteByID = function()
          return checkCFunc(_G.BNSendFriendInviteByID)
        end,
        BNSendGameData = function()
          return checkCFunc(_G.BNSendGameData)
        end,
        BNSendSoR = function()
          return checkCFunc(_G.BNSendSoR)
        end,
        BNSendVerifiedBattleTagInvite = function()
          return checkCFunc(_G.BNSendVerifiedBattleTagInvite)
        end,
        BNSendWhisper = function()
          return checkCFunc(_G.BNSendWhisper)
        end,
        BNSetAFK = function()
          return checkCFunc(_G.BNSetAFK)
        end,
        BNSetBlocked = function()
          return checkCFunc(_G.BNSetBlocked)
        end,
        BNSetCustomMessage = function()
          return checkCFunc(_G.BNSetCustomMessage)
        end,
        BNSetDND = function()
          return checkCFunc(_G.BNSetDND)
        end,
        BNSetFriendFavoriteFlag = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BNSetFriendFavoriteFlag)
          end
          return checkCFunc(_G.BNSetFriendFavoriteFlag)
        end,
        BNSetFriendNote = function()
          return checkCFunc(_G.BNSetFriendNote)
        end,
        BNSetSelectedBlock = function()
          return checkCFunc(_G.BNSetSelectedBlock)
        end,
        BNSetSelectedFriend = function()
          return checkCFunc(_G.BNSetSelectedFriend)
        end,
        BNSummonFriendByIndex = function()
          return checkCFunc(_G.BNSummonFriendByIndex)
        end,
        BNTokenFindName = function()
          return checkCFunc(_G.BNTokenFindName)
        end,
        BankButtonIDToInvSlotID = function()
          return checkCFunc(_G.BankButtonIDToInvSlotID)
        end,
        BattlefieldMgrEntryInviteResponse = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BattlefieldMgrEntryInviteResponse)
          end
          return checkCFunc(_G.BattlefieldMgrEntryInviteResponse)
        end,
        BattlefieldMgrExitRequest = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BattlefieldMgrExitRequest)
          end
          return checkCFunc(_G.BattlefieldMgrExitRequest)
        end,
        BattlefieldMgrQueueInviteResponse = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BattlefieldMgrQueueInviteResponse)
          end
          return checkCFunc(_G.BattlefieldMgrQueueInviteResponse)
        end,
        BattlefieldMgrQueueRequest = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BattlefieldMgrQueueRequest)
          end
          return checkCFunc(_G.BattlefieldMgrQueueRequest)
        end,
        BattlefieldSetPendingReportTarget = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BattlefieldSetPendingReportTarget)
          end
          return checkCFunc(_G.BattlefieldSetPendingReportTarget)
        end,
        BeginTrade = function()
          return checkCFunc(_G.BeginTrade)
        end,
        BindEnchant = function()
          return checkCFunc(_G.BindEnchant)
        end,
        BreakUpLargeNumbers = function()
          return checkCFunc(_G.BreakUpLargeNumbers)
        end,
        BuyArenaCharter = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BuyArenaCharter)
          end
          return checkCFunc(_G.BuyArenaCharter)
        end,
        BuyGuildBankTab = function()
          return checkCFunc(_G.BuyGuildBankTab)
        end,
        BuyGuildCharter = function()
          return checkCFunc(_G.BuyGuildCharter)
        end,
        BuyMerchantItem = function()
          return checkCFunc(_G.BuyMerchantItem)
        end,
        BuyReagentBank = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BuyReagentBank)
          end
          return checkCFunc(_G.BuyReagentBank)
        end,
        BuyStableSlot = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.BuyStableSlot)
          end
          return checkCFunc(_G.BuyStableSlot)
        end,
        BuyTrainerService = function()
          return checkCFunc(_G.BuyTrainerService)
        end,
        BuybackItem = function()
          return checkCFunc(_G.BuybackItem)
        end,
        CalculateAuctionDeposit = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CalculateAuctionDeposit)
          end
          return checkCFunc(_G.CalculateAuctionDeposit)
        end,
        CalculateStringEditDistance = function()
          return checkCFunc(_G.CalculateStringEditDistance)
        end,
        CallCompanion = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CallCompanion)
          end
          return checkCFunc(_G.CallCompanion)
        end,
        CameraOrSelectOrMoveStart = function()
          return checkCFunc(_G.CameraOrSelectOrMoveStart)
        end,
        CameraOrSelectOrMoveStop = function()
          return checkCFunc(_G.CameraOrSelectOrMoveStop)
        end,
        CameraZoomIn = function()
          return checkCFunc(_G.CameraZoomIn)
        end,
        CameraZoomOut = function()
          return checkCFunc(_G.CameraZoomOut)
        end,
        CanAbandonQuest = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanAbandonQuest)
          end
          return checkCFunc(_G.CanAbandonQuest)
        end,
        CanAffordMerchantItem = function()
          return checkCFunc(_G.CanAffordMerchantItem)
        end,
        CanAutoSetGamePadCursorControl = function()
          return checkCFunc(_G.CanAutoSetGamePadCursorControl)
        end,
        CanBeRaidTarget = function()
          return checkCFunc(_G.CanBeRaidTarget)
        end,
        CanCancelAuction = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanCancelAuction)
          end
          return checkCFunc(_G.CanCancelAuction)
        end,
        CanCancelScene = function()
          return checkCFunc(_G.CanCancelScene)
        end,
        CanChangePlayerDifficulty = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanChangePlayerDifficulty)
          end
          return checkCFunc(_G.CanChangePlayerDifficulty)
        end,
        CanComplainInboxItem = function()
          return checkCFunc(_G.CanComplainInboxItem)
        end,
        CanDualWield = function()
          return checkCFunc(_G.CanDualWield)
        end,
        CanEditGuildBankTabInfo = function()
          return checkCFunc(_G.CanEditGuildBankTabInfo)
        end,
        CanEditGuildEvent = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanEditGuildEvent)
          end
          return checkCFunc(_G.CanEditGuildEvent)
        end,
        CanEditGuildInfo = function()
          return checkCFunc(_G.CanEditGuildInfo)
        end,
        CanEditGuildTabInfo = function()
          return checkCFunc(_G.CanEditGuildTabInfo)
        end,
        CanEditMOTD = function()
          return checkCFunc(_G.CanEditMOTD)
        end,
        CanEditPublicNote = function()
          return checkCFunc(_G.CanEditPublicNote)
        end,
        CanEjectPassengerFromSeat = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanEjectPassengerFromSeat)
          end
          return checkCFunc(_G.CanEjectPassengerFromSeat)
        end,
        CanExitVehicle = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanExitVehicle)
          end
          return checkCFunc(_G.CanExitVehicle)
        end,
        CanGamePadControlCursor = function()
          return checkCFunc(_G.CanGamePadControlCursor)
        end,
        CanGrantLevel = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanGrantLevel)
          end
          return checkCFunc(_G.CanGrantLevel)
        end,
        CanGuildBankRepair = function()
          return checkCFunc(_G.CanGuildBankRepair)
        end,
        CanGuildDemote = function()
          return checkCFunc(_G.CanGuildDemote)
        end,
        CanGuildInvite = function()
          return checkCFunc(_G.CanGuildInvite)
        end,
        CanGuildPromote = function()
          return checkCFunc(_G.CanGuildPromote)
        end,
        CanGuildRemove = function()
          return checkCFunc(_G.CanGuildRemove)
        end,
        CanHearthAndResurrectFromArea = function()
          return checkCFunc(_G.CanHearthAndResurrectFromArea)
        end,
        CanInitiateWarGame = function()
          return checkCFunc(_G.CanInitiateWarGame)
        end,
        CanInspect = function()
          return checkCFunc(_G.CanInspect)
        end,
        CanItemBeSocketedToArtifact = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanItemBeSocketedToArtifact)
          end
          return checkCFunc(_G.CanItemBeSocketedToArtifact)
        end,
        CanJoinBattlefieldAsGroup = function()
          return checkCFunc(_G.CanJoinBattlefieldAsGroup)
        end,
        CanLootUnit = function()
          return checkCFunc(_G.CanLootUnit)
        end,
        CanMapChangeDifficulty = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanMapChangeDifficulty)
          end
          return checkCFunc(_G.CanMapChangeDifficulty)
        end,
        CanMerchantRepair = function()
          return checkCFunc(_G.CanMerchantRepair)
        end,
        CanPartyLFGBackfill = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanPartyLFGBackfill)
          end
          return checkCFunc(_G.CanPartyLFGBackfill)
        end,
        CanReplaceGuildMaster = function()
          return checkCFunc(_G.CanReplaceGuildMaster)
        end,
        CanResetTutorials = function()
          return checkCFunc(_G.CanResetTutorials)
        end,
        CanScanResearchSite = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanScanResearchSite)
          end
          return checkCFunc(_G.CanScanResearchSite)
        end,
        CanSendAuctionQuery = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanSendAuctionQuery)
          end
          return checkCFunc(_G.CanSendAuctionQuery)
        end,
        CanSendSoRByText = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanSendSoRByText)
          end
          return checkCFunc(_G.CanSendSoRByText)
        end,
        CanShowAchievementUI = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanShowAchievementUI)
          end
          return checkCFunc(_G.CanShowAchievementUI)
        end,
        CanShowResetInstances = function()
          return checkCFunc(_G.CanShowResetInstances)
        end,
        CanSignPetition = function()
          return checkCFunc(_G.CanSignPetition)
        end,
        CanSolveArtifact = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanSolveArtifact)
          end
          return checkCFunc(_G.CanSolveArtifact)
        end,
        CanSummonFriend = function()
          return checkCFunc(_G.CanSummonFriend)
        end,
        CanSurrenderArena = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanSurrenderArena)
          end
          return checkCFunc(_G.CanSurrenderArena)
        end,
        CanSwitchVehicleSeat = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanSwitchVehicleSeat)
          end
          return checkCFunc(_G.CanSwitchVehicleSeat)
        end,
        CanSwitchVehicleSeats = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanSwitchVehicleSeats)
          end
          return checkCFunc(_G.CanSwitchVehicleSeats)
        end,
        CanTrackBattlePets = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanTrackBattlePets)
          end
          return checkCFunc(_G.CanTrackBattlePets)
        end,
        CanUpgradeExpansion = function()
          return checkCFunc(_G.CanUpgradeExpansion)
        end,
        CanUseVoidStorage = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanUseVoidStorage)
          end
          return checkCFunc(_G.CanUseVoidStorage)
        end,
        CanViewGuildRecipes = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CanViewGuildRecipes)
          end
          return checkCFunc(_G.CanViewGuildRecipes)
        end,
        CanWithdrawGuildBankMoney = function()
          return checkCFunc(_G.CanWithdrawGuildBankMoney)
        end,
        CancelAreaSpiritHeal = function()
          return checkCFunc(_G.CancelAreaSpiritHeal)
        end,
        CancelAuction = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CancelAuction)
          end
          return checkCFunc(_G.CancelAuction)
        end,
        CancelDuel = function()
          return checkCFunc(_G.CancelDuel)
        end,
        CancelEmote = function()
          return checkCFunc(_G.CancelEmote)
        end,
        CancelItemTempEnchantment = function()
          return checkCFunc(_G.CancelItemTempEnchantment)
        end,
        CancelLogout = function()
          return checkCFunc(_G.CancelLogout)
        end,
        CancelMasterLootRoll = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CancelMasterLootRoll)
          end
          return checkCFunc(_G.CancelMasterLootRoll)
        end,
        CancelPendingEquip = function()
          return checkCFunc(_G.CancelPendingEquip)
        end,
        CancelPetPossess = function()
          return checkCFunc(_G.CancelPetPossess)
        end,
        CancelPreloadingMovie = function()
          return checkCFunc(_G.CancelPreloadingMovie)
        end,
        CancelScene = function()
          return checkCFunc(_G.CancelScene)
        end,
        CancelSell = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CancelSell)
          end
          return checkCFunc(_G.CancelSell)
        end,
        CancelShapeshiftForm = function()
          return checkCFunc(_G.CancelShapeshiftForm)
        end,
        CancelSpellByName = function()
          return checkCFunc(_G.CancelSpellByName)
        end,
        CancelTrackingBuff = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CancelTrackingBuff)
          end
          return checkCFunc(_G.CancelTrackingBuff)
        end,
        CancelTrade = function()
          return checkCFunc(_G.CancelTrade)
        end,
        CancelTradeAccept = function()
          return checkCFunc(_G.CancelTradeAccept)
        end,
        CancelUnitBuff = function()
          return checkCFunc(_G.CancelUnitBuff)
        end,
        CannotBeResurrected = function()
          return checkCFunc(_G.CannotBeResurrected)
        end,
        CaseAccentInsensitiveParse = function()
          return checkCFunc(_G.CaseAccentInsensitiveParse)
        end,
        CastPetAction = function()
          return checkCFunc(_G.CastPetAction)
        end,
        CastShapeshiftForm = function()
          return checkCFunc(_G.CastShapeshiftForm)
        end,
        CastSpell = function()
          return checkCFunc(_G.CastSpell)
        end,
        CastSpellByID = function()
          return checkCFunc(_G.CastSpellByID)
        end,
        CastSpellByName = function()
          return checkCFunc(_G.CastSpellByName)
        end,
        CastingInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CastingInfo)
          end
          return checkCFunc(_G.CastingInfo)
        end,
        CenterCamera = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CenterCamera)
          end
          return checkCFunc(_G.CenterCamera)
        end,
        ChangeActionBarPage = function()
          return checkCFunc(_G.ChangeActionBarPage)
        end,
        ChangeChatColor = function()
          return checkCFunc(_G.ChangeChatColor)
        end,
        ChannelBan = function()
          return checkCFunc(_G.ChannelBan)
        end,
        ChannelInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ChannelInfo)
          end
          return checkCFunc(_G.ChannelInfo)
        end,
        ChannelInvite = function()
          return checkCFunc(_G.ChannelInvite)
        end,
        ChannelKick = function()
          return checkCFunc(_G.ChannelKick)
        end,
        ChannelModerator = function()
          return checkCFunc(_G.ChannelModerator)
        end,
        ChannelSetAllSilent = function()
          return checkCFunc(_G.ChannelSetAllSilent)
        end,
        ChannelSetPartyMemberSilent = function()
          return checkCFunc(_G.ChannelSetPartyMemberSilent)
        end,
        ChannelToggleAnnouncements = function()
          return checkCFunc(_G.ChannelToggleAnnouncements)
        end,
        ChannelUnban = function()
          return checkCFunc(_G.ChannelUnban)
        end,
        ChannelUnmoderator = function()
          return checkCFunc(_G.ChannelUnmoderator)
        end,
        CheckBinderDist = function()
          return checkCFunc(_G.CheckBinderDist)
        end,
        CheckInbox = function()
          return checkCFunc(_G.CheckInbox)
        end,
        CheckInteractDistance = function()
          return checkCFunc(_G.CheckInteractDistance)
        end,
        CheckSpiritHealerDist = function()
          return checkCFunc(_G.CheckSpiritHealerDist)
        end,
        CheckTalentMasterDist = function()
          return checkCFunc(_G.CheckTalentMasterDist)
        end,
        ClassicExpansionAtLeast = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClassicExpansionAtLeast)
          end
          return checkCFunc(_G.ClassicExpansionAtLeast)
        end,
        ClearAchievementComparisonUnit = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClearAchievementComparisonUnit)
          end
          return checkCFunc(_G.ClearAchievementComparisonUnit)
        end,
        ClearAchievementSearchString = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClearAchievementSearchString)
          end
          return checkCFunc(_G.ClearAchievementSearchString)
        end,
        ClearAllLFGDungeons = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClearAllLFGDungeons)
          end
          return checkCFunc(_G.ClearAllLFGDungeons)
        end,
        ClearAllTracking = function()
          return checkCFunc(_G.ClearAllTracking)
        end,
        ClearAutoAcceptQuestSound = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClearAutoAcceptQuestSound)
          end
          return checkCFunc(_G.ClearAutoAcceptQuestSound)
        end,
        ClearBattlemaster = function()
          return checkCFunc(_G.ClearBattlemaster)
        end,
        ClearCursor = function()
          return checkCFunc(_G.ClearCursor)
        end,
        ClearFailedPVPTalentIDs = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClearFailedPVPTalentIDs)
          end
          return checkCFunc(_G.ClearFailedPVPTalentIDs)
        end,
        ClearFailedTalentIDs = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClearFailedTalentIDs)
          end
          return checkCFunc(_G.ClearFailedTalentIDs)
        end,
        ClearFocus = function()
          return checkCFunc(_G.ClearFocus)
        end,
        ClearInspectPlayer = function()
          return checkCFunc(_G.ClearInspectPlayer)
        end,
        ClearOverrideBindings = function()
          return checkCFunc(_G.ClearOverrideBindings)
        end,
        ClearPartyAssignment = function()
          return checkCFunc(_G.ClearPartyAssignment)
        end,
        ClearRaidMarker = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClearRaidMarker)
          end
          return checkCFunc(_G.ClearRaidMarker)
        end,
        ClearSendMail = function()
          return checkCFunc(_G.ClearSendMail)
        end,
        ClearTarget = function()
          return checkCFunc(_G.ClearTarget)
        end,
        ClearTutorials = function()
          return checkCFunc(_G.ClearTutorials)
        end,
        ClearVoidTransferDepositSlot = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClearVoidTransferDepositSlot)
          end
          return checkCFunc(_G.ClearVoidTransferDepositSlot)
        end,
        ClickAuctionSellItemButton = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClickAuctionSellItemButton)
          end
          return checkCFunc(_G.ClickAuctionSellItemButton)
        end,
        ClickSendMailItemButton = function()
          return checkCFunc(_G.ClickSendMailItemButton)
        end,
        ClickSocketButton = function()
          return checkCFunc(_G.ClickSocketButton)
        end,
        ClickStablePet = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClickStablePet)
          end
          return checkCFunc(_G.ClickStablePet)
        end,
        ClickTargetTradeButton = function()
          return checkCFunc(_G.ClickTargetTradeButton)
        end,
        ClickTradeButton = function()
          return checkCFunc(_G.ClickTradeButton)
        end,
        ClickVoidStorageSlot = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClickVoidStorageSlot)
          end
          return checkCFunc(_G.ClickVoidStorageSlot)
        end,
        ClickVoidTransferDepositSlot = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClickVoidTransferDepositSlot)
          end
          return checkCFunc(_G.ClickVoidTransferDepositSlot)
        end,
        ClickVoidTransferWithdrawalSlot = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClickVoidTransferWithdrawalSlot)
          end
          return checkCFunc(_G.ClickVoidTransferWithdrawalSlot)
        end,
        ClickWorldMapActionButton = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClickWorldMapActionButton)
          end
          return checkCFunc(_G.ClickWorldMapActionButton)
        end,
        CloseArenaTeamRoster = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CloseArenaTeamRoster)
          end
          return checkCFunc(_G.CloseArenaTeamRoster)
        end,
        CloseAuctionHouse = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CloseAuctionHouse)
          end
          return checkCFunc(_G.CloseAuctionHouse)
        end,
        CloseBankFrame = function()
          return checkCFunc(_G.CloseBankFrame)
        end,
        CloseCraft = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CloseCraft)
          end
          return checkCFunc(_G.CloseCraft)
        end,
        CloseGossip = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CloseGossip)
          end
          return checkCFunc(_G.CloseGossip)
        end,
        CloseGuildBankFrame = function()
          return checkCFunc(_G.CloseGuildBankFrame)
        end,
        CloseGuildRegistrar = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CloseGuildRegistrar)
          end
          return checkCFunc(_G.CloseGuildRegistrar)
        end,
        CloseGuildRoster = function()
          return checkCFunc(_G.CloseGuildRoster)
        end,
        CloseItemText = function()
          return checkCFunc(_G.CloseItemText)
        end,
        CloseLoot = function()
          return checkCFunc(_G.CloseLoot)
        end,
        CloseMail = function()
          return checkCFunc(_G.CloseMail)
        end,
        CloseMerchant = function()
          return checkCFunc(_G.CloseMerchant)
        end,
        ClosePetStables = function()
          return checkCFunc(_G.ClosePetStables)
        end,
        ClosePetition = function()
          return checkCFunc(_G.ClosePetition)
        end,
        ClosePetitionRegistrar = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ClosePetitionRegistrar)
          end
          return checkCFunc(_G.ClosePetitionRegistrar)
        end,
        CloseQuest = function()
          return checkCFunc(_G.CloseQuest)
        end,
        CloseResearch = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CloseResearch)
          end
          return checkCFunc(_G.CloseResearch)
        end,
        CloseSocketInfo = function()
          return checkCFunc(_G.CloseSocketInfo)
        end,
        CloseTabardCreation = function()
          return checkCFunc(_G.CloseTabardCreation)
        end,
        CloseTaxiMap = function()
          return checkCFunc(_G.CloseTaxiMap)
        end,
        CloseTrade = function()
          return checkCFunc(_G.CloseTrade)
        end,
        CloseTradeSkill = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CloseTradeSkill)
          end
          return checkCFunc(_G.CloseTradeSkill)
        end,
        CloseTrainer = function()
          return checkCFunc(_G.CloseTrainer)
        end,
        CloseVoidStorageFrame = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CloseVoidStorageFrame)
          end
          return checkCFunc(_G.CloseVoidStorageFrame)
        end,
        ClosestGameObjectPosition = function()
          return checkCFunc(_G.ClosestGameObjectPosition)
        end,
        ClosestUnitPosition = function()
          return checkCFunc(_G.ClosestUnitPosition)
        end,
        CollapseAllFactionHeaders = function()
          return checkCFunc(_G.CollapseAllFactionHeaders)
        end,
        CollapseCraftSkillLine = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CollapseCraftSkillLine)
          end
          return checkCFunc(_G.CollapseCraftSkillLine)
        end,
        CollapseFactionHeader = function()
          return checkCFunc(_G.CollapseFactionHeader)
        end,
        CollapseGuildTradeSkillHeader = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CollapseGuildTradeSkillHeader)
          end
          return checkCFunc(_G.CollapseGuildTradeSkillHeader)
        end,
        CollapseQuestHeader = function()
          return checkCFunc(_G.CollapseQuestHeader)
        end,
        CollapseSkillHeader = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CollapseSkillHeader)
          end
          return checkCFunc(_G.CollapseSkillHeader)
        end,
        CollapseTradeSkillSubClass = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CollapseTradeSkillSubClass)
          end
          return checkCFunc(_G.CollapseTradeSkillSubClass)
        end,
        CollapseTrainerSkillLine = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CollapseTrainerSkillLine)
          end
          return checkCFunc(_G.CollapseTrainerSkillLine)
        end,
        CollapseWarGameHeader = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CollapseWarGameHeader)
          end
          return checkCFunc(_G.CollapseWarGameHeader)
        end,
        CombatLogAddFilter = function()
          return checkCFunc(_G.CombatLogAddFilter)
        end,
        CombatLogAdvanceEntry = function()
          return checkCFunc(_G.CombatLogAdvanceEntry)
        end,
        CombatLogClearEntries = function()
          return checkCFunc(_G.CombatLogClearEntries)
        end,
        CombatLogGetCurrentEntry = function()
          return checkCFunc(_G.CombatLogGetCurrentEntry)
        end,
        CombatLogGetCurrentEventInfo = function()
          return checkCFunc(_G.CombatLogGetCurrentEventInfo)
        end,
        CombatLogGetNumEntries = function()
          return checkCFunc(_G.CombatLogGetNumEntries)
        end,
        CombatLogGetRetentionTime = function()
          return checkCFunc(_G.CombatLogGetRetentionTime)
        end,
        CombatLogResetFilter = function()
          return checkCFunc(_G.CombatLogResetFilter)
        end,
        CombatLogSetCurrentEntry = function()
          return checkCFunc(_G.CombatLogSetCurrentEntry)
        end,
        CombatLogSetRetentionTime = function()
          return checkCFunc(_G.CombatLogSetRetentionTime)
        end,
        CombatLog_Object_IsA = function()
          return checkCFunc(_G.CombatLog_Object_IsA)
        end,
        CombatTextSetActiveUnit = function()
          return checkCFunc(_G.CombatTextSetActiveUnit)
        end,
        ComplainInboxItem = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ComplainInboxItem)
          end
          return checkCFunc(_G.ComplainInboxItem)
        end,
        CompleteLFGReadyCheck = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CompleteLFGReadyCheck)
          end
          return checkCFunc(_G.CompleteLFGReadyCheck)
        end,
        CompleteLFGRoleCheck = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CompleteLFGRoleCheck)
          end
          return checkCFunc(_G.CompleteLFGRoleCheck)
        end,
        CompleteQuest = function()
          return checkCFunc(_G.CompleteQuest)
        end,
        ConfirmAcceptQuest = function()
          return checkCFunc(_G.ConfirmAcceptQuest)
        end,
        ConfirmBNRequestInviteFriend = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ConfirmBNRequestInviteFriend)
          end
          return checkCFunc(_G.ConfirmBNRequestInviteFriend)
        end,
        ConfirmBindOnUse = function()
          return checkCFunc(_G.ConfirmBindOnUse)
        end,
        ConfirmBinder = function()
          return checkCFunc(_G.ConfirmBinder)
        end,
        ConfirmLootRoll = function()
          return checkCFunc(_G.ConfirmLootRoll)
        end,
        ConfirmLootSlot = function()
          return checkCFunc(_G.ConfirmLootSlot)
        end,
        ConfirmNoRefundOnUse = function()
          return checkCFunc(_G.ConfirmNoRefundOnUse)
        end,
        ConfirmOnUse = function()
          return checkCFunc(_G.ConfirmOnUse)
        end,
        ConfirmPetUnlearn = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ConfirmPetUnlearn)
          end
          return checkCFunc(_G.ConfirmPetUnlearn)
        end,
        ConfirmReadyCheck = function()
          return checkCFunc(_G.ConfirmReadyCheck)
        end,
        ConfirmTalentWipe = function()
          return checkCFunc(_G.ConfirmTalentWipe)
        end,
        ConsoleAddMessage = function()
          return checkCFunc(_G.ConsoleAddMessage)
        end,
        ConsoleExec = function()
          return checkCFunc(_G.ConsoleExec)
        end,
        ContainerIDToInventoryID = function()
          return checkCFunc(_G.ContainerIDToInventoryID)
        end,
        ContainerRefundItemPurchase = function()
          return checkCFunc(_G.ContainerRefundItemPurchase)
        end,
        ConvertToParty = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ConvertToParty)
          end
          return checkCFunc(_G.ConvertToParty)
        end,
        ConvertToRaid = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ConvertToRaid)
          end
          return checkCFunc(_G.ConvertToRaid)
        end,
        CopyToClipboard = function()
          return checkCFunc(_G.CopyToClipboard)
        end,
        CraftIsEnchanting = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CraftIsEnchanting)
          end
          return checkCFunc(_G.CraftIsEnchanting)
        end,
        CraftOnlyShowMakeable = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.CraftOnlyShowMakeable)
          end
          return checkCFunc(_G.CraftOnlyShowMakeable)
        end,
        CreateFont = function()
          return checkCFunc(_G.CreateFont)
        end,
        CreateForbiddenFrame = function()
          assertEquals(_G.SecureCapsuleGet == nil, _G.CreateForbiddenFrame ~= nil) -- addon_spec hack
        end,
        CreateFrame = function()
          return checkCFunc(_G.CreateFrame)
        end,
        CreateMacro = function()
          return checkCFunc(_G.CreateMacro)
        end,
        CreateNewRaidProfile = function()
          return checkCFunc(_G.CreateNewRaidProfile)
        end,
        CursorCanGoInSlot = function()
          return checkCFunc(_G.CursorCanGoInSlot)
        end,
        CursorHasItem = function()
          return checkCFunc(_G.CursorHasItem)
        end,
        CursorHasMacro = function()
          return checkCFunc(_G.CursorHasMacro)
        end,
        CursorHasMoney = function()
          return checkCFunc(_G.CursorHasMoney)
        end,
        CursorHasSpell = function()
          return checkCFunc(_G.CursorHasSpell)
        end,
        DeathRecap_GetEvents = function()
          return checkCFunc(_G.DeathRecap_GetEvents)
        end,
        DeathRecap_HasEvents = function()
          return checkCFunc(_G.DeathRecap_HasEvents)
        end,
        DeclineArenaTeam = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.DeclineArenaTeam)
          end
          return checkCFunc(_G.DeclineArenaTeam)
        end,
        DeclineChannelInvite = function()
          return checkCFunc(_G.DeclineChannelInvite)
        end,
        DeclineGroup = function()
          return checkCFunc(_G.DeclineGroup)
        end,
        DeclineGuild = function()
          return checkCFunc(_G.DeclineGuild)
        end,
        DeclineName = function()
          return checkCFunc(_G.DeclineName)
        end,
        DeclineQuest = function()
          return checkCFunc(_G.DeclineQuest)
        end,
        DeclineResurrect = function()
          return checkCFunc(_G.DeclineResurrect)
        end,
        DeclineSpellConfirmationPrompt = function()
          return checkCFunc(_G.DeclineSpellConfirmationPrompt)
        end,
        DeleteCursorItem = function()
          return checkCFunc(_G.DeleteCursorItem)
        end,
        DeleteGMTicket = function()
          return checkCFunc(_G.DeleteGMTicket)
        end,
        DeleteInboxItem = function()
          return checkCFunc(_G.DeleteInboxItem)
        end,
        DeleteMacro = function()
          return checkCFunc(_G.DeleteMacro)
        end,
        DeleteRaidProfile = function()
          return checkCFunc(_G.DeleteRaidProfile)
        end,
        DemoteAssistant = function()
          return checkCFunc(_G.DemoteAssistant)
        end,
        DepositGuildBankMoney = function()
          return checkCFunc(_G.DepositGuildBankMoney)
        end,
        DepositReagentBank = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.DepositReagentBank)
          end
          return checkCFunc(_G.DepositReagentBank)
        end,
        DescendStop = function()
          return checkCFunc(_G.DescendStop)
        end,
        DestroyTotem = function()
          return checkCFunc(_G.DestroyTotem)
        end,
        DetectWowMouse = function()
          return checkCFunc(_G.DetectWowMouse)
        end,
        DisableAddOn = function()
          return checkCFunc(_G.DisableAddOn)
        end,
        DisableAllAddOns = function()
          return checkCFunc(_G.DisableAllAddOns)
        end,
        DisableSpellAutocast = function()
          return checkCFunc(_G.DisableSpellAutocast)
        end,
        DismissCompanion = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.DismissCompanion)
          end
          return checkCFunc(_G.DismissCompanion)
        end,
        Dismount = function()
          return checkCFunc(_G.Dismount)
        end,
        DisplayChannelOwner = function()
          return checkCFunc(_G.DisplayChannelOwner)
        end,
        DoCraft = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.DoCraft)
          end
          return checkCFunc(_G.DoCraft)
        end,
        DoEmote = function()
          return checkCFunc(_G.DoEmote)
        end,
        DoMasterLootRoll = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.DoMasterLootRoll)
          end
          return checkCFunc(_G.DoMasterLootRoll)
        end,
        DoReadyCheck = function()
          return checkCFunc(_G.DoReadyCheck)
        end,
        DoTradeSkill = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.DoTradeSkill)
          end
          return checkCFunc(_G.DoTradeSkill)
        end,
        DoesCurrentLocaleSellExpansionLevels = function()
          return checkCFunc(_G.DoesCurrentLocaleSellExpansionLevels)
        end,
        DoesItemContainSpec = function()
          return checkCFunc(_G.DoesItemContainSpec)
        end,
        DoesSpellExist = function()
          return checkCFunc(_G.DoesSpellExist)
        end,
        DoesTemplateExist = function()
          return checkCFunc(_G.DoesTemplateExist)
        end,
        DropCursorMoney = function()
          return checkCFunc(_G.DropCursorMoney)
        end,
        DropItemOnUnit = function()
          return checkCFunc(_G.DropItemOnUnit)
        end,
        DumpMovementCapture = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.DumpMovementCapture)
          end
          return checkCFunc(_G.DumpMovementCapture)
        end,
        DungeonAppearsInRandomLFD = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.DungeonAppearsInRandomLFD)
          end
          return checkCFunc(_G.DungeonAppearsInRandomLFD)
        end,
        EJ_ClearSearch = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_ClearSearch)
          end
          return checkCFunc(_G.EJ_ClearSearch)
        end,
        EJ_EndSearch = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_EndSearch)
          end
          return checkCFunc(_G.EJ_EndSearch)
        end,
        EJ_GetContentTuningID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetContentTuningID)
          end
          return checkCFunc(_G.EJ_GetContentTuningID)
        end,
        EJ_GetCreatureInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetCreatureInfo)
          end
          return checkCFunc(_G.EJ_GetCreatureInfo)
        end,
        EJ_GetCurrentTier = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetCurrentTier)
          end
          return checkCFunc(_G.EJ_GetCurrentTier)
        end,
        EJ_GetDifficulty = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetDifficulty)
          end
          return checkCFunc(_G.EJ_GetDifficulty)
        end,
        EJ_GetEncounterInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetEncounterInfo)
          end
          return checkCFunc(_G.EJ_GetEncounterInfo)
        end,
        EJ_GetEncounterInfoByIndex = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetEncounterInfoByIndex)
          end
          return checkCFunc(_G.EJ_GetEncounterInfoByIndex)
        end,
        EJ_GetInstanceByIndex = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetInstanceByIndex)
          end
          return checkCFunc(_G.EJ_GetInstanceByIndex)
        end,
        EJ_GetInstanceForMap = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetInstanceForMap)
          end
          return checkCFunc(_G.EJ_GetInstanceForMap)
        end,
        EJ_GetInstanceInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetInstanceInfo)
          end
          return checkCFunc(_G.EJ_GetInstanceInfo)
        end,
        EJ_GetInvTypeSortOrder = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetInvTypeSortOrder)
          end
          return checkCFunc(_G.EJ_GetInvTypeSortOrder)
        end,
        EJ_GetLootFilter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetLootFilter)
          end
          return checkCFunc(_G.EJ_GetLootFilter)
        end,
        EJ_GetMapEncounter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetMapEncounter)
          end
          return checkCFunc(_G.EJ_GetMapEncounter)
        end,
        EJ_GetNumEncountersForLootByIndex = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetNumEncountersForLootByIndex)
          end
          return checkCFunc(_G.EJ_GetNumEncountersForLootByIndex)
        end,
        EJ_GetNumLoot = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetNumLoot)
          end
          return checkCFunc(_G.EJ_GetNumLoot)
        end,
        EJ_GetNumSearchResults = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetNumSearchResults)
          end
          return checkCFunc(_G.EJ_GetNumSearchResults)
        end,
        EJ_GetNumTiers = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetNumTiers)
          end
          return checkCFunc(_G.EJ_GetNumTiers)
        end,
        EJ_GetSearchProgress = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetSearchProgress)
          end
          return checkCFunc(_G.EJ_GetSearchProgress)
        end,
        EJ_GetSearchResult = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetSearchResult)
          end
          return checkCFunc(_G.EJ_GetSearchResult)
        end,
        EJ_GetSearchSize = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetSearchSize)
          end
          return checkCFunc(_G.EJ_GetSearchSize)
        end,
        EJ_GetSectionPath = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetSectionPath)
          end
          return checkCFunc(_G.EJ_GetSectionPath)
        end,
        EJ_GetTierInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_GetTierInfo)
          end
          return checkCFunc(_G.EJ_GetTierInfo)
        end,
        EJ_HandleLinkPath = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_HandleLinkPath)
          end
          return checkCFunc(_G.EJ_HandleLinkPath)
        end,
        EJ_InstanceIsRaid = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_InstanceIsRaid)
          end
          return checkCFunc(_G.EJ_InstanceIsRaid)
        end,
        EJ_IsLootListOutOfDate = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_IsLootListOutOfDate)
          end
          return checkCFunc(_G.EJ_IsLootListOutOfDate)
        end,
        EJ_IsSearchFinished = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_IsSearchFinished)
          end
          return checkCFunc(_G.EJ_IsSearchFinished)
        end,
        EJ_IsValidInstanceDifficulty = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_IsValidInstanceDifficulty)
          end
          return checkCFunc(_G.EJ_IsValidInstanceDifficulty)
        end,
        EJ_ResetLootFilter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_ResetLootFilter)
          end
          return checkCFunc(_G.EJ_ResetLootFilter)
        end,
        EJ_SelectEncounter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_SelectEncounter)
          end
          return checkCFunc(_G.EJ_SelectEncounter)
        end,
        EJ_SelectInstance = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_SelectInstance)
          end
          return checkCFunc(_G.EJ_SelectInstance)
        end,
        EJ_SelectTier = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_SelectTier)
          end
          return checkCFunc(_G.EJ_SelectTier)
        end,
        EJ_SetDifficulty = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_SetDifficulty)
          end
          return checkCFunc(_G.EJ_SetDifficulty)
        end,
        EJ_SetLootFilter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_SetLootFilter)
          end
          return checkCFunc(_G.EJ_SetLootFilter)
        end,
        EJ_SetSearch = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EJ_SetSearch)
          end
          return checkCFunc(_G.EJ_SetSearch)
        end,
        EditMacro = function()
          return checkCFunc(_G.EditMacro)
        end,
        EjectPassengerFromSeat = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.EjectPassengerFromSeat)
          end
          return checkCFunc(_G.EjectPassengerFromSeat)
        end,
        EnableAddOn = function()
          return checkCFunc(_G.EnableAddOn)
        end,
        EnableAllAddOns = function()
          return checkCFunc(_G.EnableAllAddOns)
        end,
        EnableSpellAutocast = function()
          return checkCFunc(_G.EnableSpellAutocast)
        end,
        EndBoundTradeable = function()
          return checkCFunc(_G.EndBoundTradeable)
        end,
        EndRefund = function()
          return checkCFunc(_G.EndRefund)
        end,
        EnumerateFrames = function()
          return checkCFunc(_G.EnumerateFrames)
        end,
        EnumerateServerChannels = function()
          return checkCFunc(_G.EnumerateServerChannels)
        end,
        EquipCursorItem = function()
          return checkCFunc(_G.EquipCursorItem)
        end,
        EquipItemByName = function()
          return checkCFunc(_G.EquipItemByName)
        end,
        EquipPendingItem = function()
          return checkCFunc(_G.EquipPendingItem)
        end,
        ExecuteVoidTransfer = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ExecuteVoidTransfer)
          end
          return checkCFunc(_G.ExecuteVoidTransfer)
        end,
        ExpandAllFactionHeaders = function()
          return checkCFunc(_G.ExpandAllFactionHeaders)
        end,
        ExpandCraftSkillLine = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ExpandCraftSkillLine)
          end
          return checkCFunc(_G.ExpandCraftSkillLine)
        end,
        ExpandFactionHeader = function()
          return checkCFunc(_G.ExpandFactionHeader)
        end,
        ExpandGuildTradeSkillHeader = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ExpandGuildTradeSkillHeader)
          end
          return checkCFunc(_G.ExpandGuildTradeSkillHeader)
        end,
        ExpandQuestHeader = function()
          return checkCFunc(_G.ExpandQuestHeader)
        end,
        ExpandSkillHeader = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ExpandSkillHeader)
          end
          return checkCFunc(_G.ExpandSkillHeader)
        end,
        ExpandTradeSkillSubClass = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ExpandTradeSkillSubClass)
          end
          return checkCFunc(_G.ExpandTradeSkillSubClass)
        end,
        ExpandTrainerSkillLine = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ExpandTrainerSkillLine)
          end
          return checkCFunc(_G.ExpandTrainerSkillLine)
        end,
        ExpandWarGameHeader = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ExpandWarGameHeader)
          end
          return checkCFunc(_G.ExpandWarGameHeader)
        end,
        FactionToggleAtWar = function()
          return checkCFunc(_G.FactionToggleAtWar)
        end,
        FillLocalizedClassList = function()
          return checkCFunc(_G.FillLocalizedClassList)
        end,
        FindBaseSpellByID = function()
          return checkCFunc(_G.FindBaseSpellByID)
        end,
        FindFlyoutSlotBySpellID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.FindFlyoutSlotBySpellID)
          end
          return checkCFunc(_G.FindFlyoutSlotBySpellID)
        end,
        FindSpellBookSlotBySpellID = function()
          return checkCFunc(_G.FindSpellBookSlotBySpellID)
        end,
        FindSpellOverrideByID = function()
          return checkCFunc(_G.FindSpellOverrideByID)
        end,
        FlagTutorial = function()
          return checkCFunc(_G.FlagTutorial)
        end,
        FlashClientIcon = function()
          return checkCFunc(_G.FlashClientIcon)
        end,
        FlipCameraYaw = function()
          return checkCFunc(_G.FlipCameraYaw)
        end,
        FlyoutHasSpell = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.FlyoutHasSpell)
          end
          return checkCFunc(_G.FlyoutHasSpell)
        end,
        FocusUnit = function()
          return checkCFunc(_G.FocusUnit)
        end,
        FollowUnit = function()
          return checkCFunc(_G.FollowUnit)
        end,
        ForceGossip = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ForceGossip)
          end
          return checkCFunc(_G.ForceGossip)
        end,
        ForceLogout = function()
          return checkCFunc(_G.ForceLogout)
        end,
        ForceQuit = function()
          return checkCFunc(_G.ForceQuit)
        end,
        ForfeitDuel = function()
          return checkCFunc(_G.ForfeitDuel)
        end,
        FrameXML_Debug = function()
          return checkCFunc(_G.FrameXML_Debug)
        end,
        GMEuropaBugsEnabled = function()
          return checkCFunc(_G.GMEuropaBugsEnabled)
        end,
        GMEuropaComplaintsEnabled = function()
          return checkCFunc(_G.GMEuropaComplaintsEnabled)
        end,
        GMEuropaSuggestionsEnabled = function()
          return checkCFunc(_G.GMEuropaSuggestionsEnabled)
        end,
        GMEuropaTicketsEnabled = function()
          return checkCFunc(_G.GMEuropaTicketsEnabled)
        end,
        GMItemRestorationButtonEnabled = function()
          return checkCFunc(_G.GMItemRestorationButtonEnabled)
        end,
        GMQuickTicketSystemEnabled = function()
          return checkCFunc(_G.GMQuickTicketSystemEnabled)
        end,
        GMQuickTicketSystemThrottled = function()
          return checkCFunc(_G.GMQuickTicketSystemThrottled)
        end,
        GMReportLag = function()
          return checkCFunc(_G.GMReportLag)
        end,
        GMRequestPlayerInfo = function()
          return checkCFunc(_G.GMRequestPlayerInfo)
        end,
        GMResponseResolve = function()
          return checkCFunc(_G.GMResponseResolve)
        end,
        GMSubmitBug = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GMSubmitBug)
          end
          return checkCFunc(_G.GMSubmitBug)
        end,
        GMSubmitSuggestion = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GMSubmitSuggestion)
          end
          return checkCFunc(_G.GMSubmitSuggestion)
        end,
        GMSurveyAnswer = function()
          return checkCFunc(_G.GMSurveyAnswer)
        end,
        GMSurveyAnswerSubmit = function()
          return checkCFunc(_G.GMSurveyAnswerSubmit)
        end,
        GMSurveyCommentSubmit = function()
          return checkCFunc(_G.GMSurveyCommentSubmit)
        end,
        GMSurveyNumAnswers = function()
          return checkCFunc(_G.GMSurveyNumAnswers)
        end,
        GMSurveyQuestion = function()
          return checkCFunc(_G.GMSurveyQuestion)
        end,
        GMSurveySubmit = function()
          return checkCFunc(_G.GMSurveySubmit)
        end,
        GameMovieFinished = function()
          return checkCFunc(_G.GameMovieFinished)
        end,
        GetAbandonQuestItems = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAbandonQuestItems)
          end
          return checkCFunc(_G.GetAbandonQuestItems)
        end,
        GetAbandonQuestName = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAbandonQuestName)
          end
          return checkCFunc(_G.GetAbandonQuestName)
        end,
        GetAccountExpansionLevel = function()
          return checkCFunc(_G.GetAccountExpansionLevel)
        end,
        GetAchievementCategory = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementCategory)
          end
          return checkCFunc(_G.GetAchievementCategory)
        end,
        GetAchievementComparisonInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementComparisonInfo)
          end
          return checkCFunc(_G.GetAchievementComparisonInfo)
        end,
        GetAchievementCriteriaInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementCriteriaInfo)
          end
          return checkCFunc(_G.GetAchievementCriteriaInfo)
        end,
        GetAchievementCriteriaInfoByID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementCriteriaInfoByID)
          end
          return checkCFunc(_G.GetAchievementCriteriaInfoByID)
        end,
        GetAchievementGuildRep = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementGuildRep)
          end
          return checkCFunc(_G.GetAchievementGuildRep)
        end,
        GetAchievementInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementInfo)
          end
          return checkCFunc(_G.GetAchievementInfo)
        end,
        GetAchievementLink = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementLink)
          end
          return checkCFunc(_G.GetAchievementLink)
        end,
        GetAchievementNumCriteria = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementNumCriteria)
          end
          return checkCFunc(_G.GetAchievementNumCriteria)
        end,
        GetAchievementNumRewards = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementNumRewards)
          end
          return checkCFunc(_G.GetAchievementNumRewards)
        end,
        GetAchievementReward = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementReward)
          end
          return checkCFunc(_G.GetAchievementReward)
        end,
        GetAchievementSearchProgress = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementSearchProgress)
          end
          return checkCFunc(_G.GetAchievementSearchProgress)
        end,
        GetAchievementSearchSize = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAchievementSearchSize)
          end
          return checkCFunc(_G.GetAchievementSearchSize)
        end,
        GetActionAutocast = function()
          return checkCFunc(_G.GetActionAutocast)
        end,
        GetActionBarPage = function()
          return checkCFunc(_G.GetActionBarPage)
        end,
        GetActionBarToggles = function()
          return checkCFunc(_G.GetActionBarToggles)
        end,
        GetActionCharges = function()
          return checkCFunc(_G.GetActionCharges)
        end,
        GetActionCooldown = function()
          return checkCFunc(_G.GetActionCooldown)
        end,
        GetActionCount = function()
          return checkCFunc(_G.GetActionCount)
        end,
        GetActionInfo = function()
          return checkCFunc(_G.GetActionInfo)
        end,
        GetActionLossOfControlCooldown = function()
          return checkCFunc(_G.GetActionLossOfControlCooldown)
        end,
        GetActionText = function()
          return checkCFunc(_G.GetActionText)
        end,
        GetActionTexture = function()
          return checkCFunc(_G.GetActionTexture)
        end,
        GetActiveArtifactByRace = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetActiveArtifactByRace)
          end
          return checkCFunc(_G.GetActiveArtifactByRace)
        end,
        GetActiveLevel = function()
          return checkCFunc(_G.GetActiveLevel)
        end,
        GetActiveLootRollIDs = function()
          return checkCFunc(_G.GetActiveLootRollIDs)
        end,
        GetActiveQuestID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetActiveQuestID)
          end
          return checkCFunc(_G.GetActiveQuestID)
        end,
        GetActiveSpecGroup = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetActiveSpecGroup)
          end
          return checkCFunc(_G.GetActiveSpecGroup)
        end,
        GetActiveTitle = function()
          return checkCFunc(_G.GetActiveTitle)
        end,
        GetAddOnCPUUsage = function()
          return checkCFunc(_G.GetAddOnCPUUsage)
        end,
        GetAddOnDependencies = function()
          return checkCFunc(_G.GetAddOnDependencies)
        end,
        GetAddOnEnableState = function()
          return checkCFunc(_G.GetAddOnEnableState)
        end,
        GetAddOnInfo = function()
          return checkCFunc(_G.GetAddOnInfo)
        end,
        GetAddOnMemoryUsage = function()
          return checkCFunc(_G.GetAddOnMemoryUsage)
        end,
        GetAddOnMetadata = function()
          return checkCFunc(_G.GetAddOnMetadata)
        end,
        GetAddOnOptionalDependencies = function()
          return checkCFunc(_G.GetAddOnOptionalDependencies)
        end,
        GetAllowLowLevelRaid = function()
          return checkCFunc(_G.GetAllowLowLevelRaid)
        end,
        GetAlternativeDefaultLanguage = function()
          return checkCFunc(_G.GetAlternativeDefaultLanguage)
        end,
        GetArchaeologyInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArchaeologyInfo)
          end
          return checkCFunc(_G.GetArchaeologyInfo)
        end,
        GetArchaeologyRaceInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArchaeologyRaceInfo)
          end
          return checkCFunc(_G.GetArchaeologyRaceInfo)
        end,
        GetArchaeologyRaceInfoByID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArchaeologyRaceInfoByID)
          end
          return checkCFunc(_G.GetArchaeologyRaceInfoByID)
        end,
        GetAreaSpiritHealerTime = function()
          return checkCFunc(_G.GetAreaSpiritHealerTime)
        end,
        GetAreaText = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAreaText)
          end
          return checkCFunc(_G.GetAreaText)
        end,
        GetArenaOpponentSpec = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArenaOpponentSpec)
          end
          return checkCFunc(_G.GetArenaOpponentSpec)
        end,
        GetArenaTeam = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArenaTeam)
          end
          return checkCFunc(_G.GetArenaTeam)
        end,
        GetArenaTeamGdfInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArenaTeamGdfInfo)
          end
          return checkCFunc(_G.GetArenaTeamGdfInfo)
        end,
        GetArenaTeamIndexBySize = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArenaTeamIndexBySize)
          end
          return checkCFunc(_G.GetArenaTeamIndexBySize)
        end,
        GetArenaTeamRosterInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArenaTeamRosterInfo)
          end
          return checkCFunc(_G.GetArenaTeamRosterInfo)
        end,
        GetArenaTeamRosterSelection = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArenaTeamRosterSelection)
          end
          return checkCFunc(_G.GetArenaTeamRosterSelection)
        end,
        GetArenaTeamRosterShowOffline = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArenaTeamRosterShowOffline)
          end
          return checkCFunc(_G.GetArenaTeamRosterShowOffline)
        end,
        GetArmorPenetration = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArmorPenetration)
          end
          return checkCFunc(_G.GetArmorPenetration)
        end,
        GetArtifactInfoByRace = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArtifactInfoByRace)
          end
          return checkCFunc(_G.GetArtifactInfoByRace)
        end,
        GetArtifactProgress = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetArtifactProgress)
          end
          return checkCFunc(_G.GetArtifactProgress)
        end,
        GetAtlasInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAtlasInfo)
          end
          return checkCFunc(_G.GetAtlasInfo)
        end,
        GetAttackPowerForStat = function()
          return checkCFunc(_G.GetAttackPowerForStat)
        end,
        GetAuctionDeposit = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAuctionDeposit)
          end
          return checkCFunc(_G.GetAuctionDeposit)
        end,
        GetAuctionHouseDepositRate = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAuctionHouseDepositRate)
          end
          return checkCFunc(_G.GetAuctionHouseDepositRate)
        end,
        GetAuctionItemBattlePetInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAuctionItemBattlePetInfo)
          end
          return checkCFunc(_G.GetAuctionItemBattlePetInfo)
        end,
        GetAuctionItemInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAuctionItemInfo)
          end
          return checkCFunc(_G.GetAuctionItemInfo)
        end,
        GetAuctionItemLink = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAuctionItemLink)
          end
          return checkCFunc(_G.GetAuctionItemLink)
        end,
        GetAuctionItemSubClasses = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAuctionItemSubClasses)
          end
          return checkCFunc(_G.GetAuctionItemSubClasses)
        end,
        GetAuctionItemTimeLeft = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAuctionItemTimeLeft)
          end
          return checkCFunc(_G.GetAuctionItemTimeLeft)
        end,
        GetAuctionSellItemInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAuctionSellItemInfo)
          end
          return checkCFunc(_G.GetAuctionSellItemInfo)
        end,
        GetAuctionSort = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAuctionSort)
          end
          return checkCFunc(_G.GetAuctionSort)
        end,
        GetAutoCompletePresenceID = function()
          return checkCFunc(_G.GetAutoCompletePresenceID)
        end,
        GetAutoCompleteRealms = function()
          return checkCFunc(_G.GetAutoCompleteRealms)
        end,
        GetAutoCompleteResults = function()
          return checkCFunc(_G.GetAutoCompleteResults)
        end,
        GetAutoDeclineGuildInvites = function()
          return checkCFunc(_G.GetAutoDeclineGuildInvites)
        end,
        GetAutoQuestPopUp = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAutoQuestPopUp)
          end
          return checkCFunc(_G.GetAutoQuestPopUp)
        end,
        GetAvailableBandwidth = function()
          return checkCFunc(_G.GetAvailableBandwidth)
        end,
        GetAvailableLevel = function()
          return checkCFunc(_G.GetAvailableLevel)
        end,
        GetAvailableLocaleInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAvailableLocaleInfo)
          end
          return checkCFunc(_G.GetAvailableLocaleInfo)
        end,
        GetAvailableLocales = function()
          return checkCFunc(_G.GetAvailableLocales)
        end,
        GetAvailableQuestInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAvailableQuestInfo)
          end
          return checkCFunc(_G.GetAvailableQuestInfo)
        end,
        GetAvailableTitle = function()
          return checkCFunc(_G.GetAvailableTitle)
        end,
        GetAverageItemLevel = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAverageItemLevel)
          end
          return checkCFunc(_G.GetAverageItemLevel)
        end,
        GetAvoidance = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetAvoidance)
          end
          return checkCFunc(_G.GetAvoidance)
        end,
        GetBackgroundLoadingStatus = function()
          return checkCFunc(_G.GetBackgroundLoadingStatus)
        end,
        GetBackpackAutosortDisabled = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetBackpackAutosortDisabled)
          end
          return checkCFunc(_G.GetBackpackAutosortDisabled)
        end,
        GetBagName = function()
          return checkCFunc(_G.GetBagName)
        end,
        GetBagSlotFlag = function()
          return checkCFunc(_G.GetBagSlotFlag)
        end,
        GetBankAutosortDisabled = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetBankAutosortDisabled)
          end
          return checkCFunc(_G.GetBankAutosortDisabled)
        end,
        GetBankBagSlotFlag = function()
          return checkCFunc(_G.GetBankBagSlotFlag)
        end,
        GetBankSlotCost = function()
          return checkCFunc(_G.GetBankSlotCost)
        end,
        GetBattlefieldArenaFaction = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetBattlefieldArenaFaction)
          end
          return checkCFunc(_G.GetBattlefieldArenaFaction)
        end,
        GetBattlefieldEstimatedWaitTime = function()
          return checkCFunc(_G.GetBattlefieldEstimatedWaitTime)
        end,
        GetBattlefieldFlagPosition = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetBattlefieldFlagPosition)
          end
          return checkCFunc(_G.GetBattlefieldFlagPosition)
        end,
        GetBattlefieldInstanceExpiration = function()
          return checkCFunc(_G.GetBattlefieldInstanceExpiration)
        end,
        GetBattlefieldInstanceInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetBattlefieldInstanceInfo)
          end
          return checkCFunc(_G.GetBattlefieldInstanceInfo)
        end,
        GetBattlefieldInstanceRunTime = function()
          return checkCFunc(_G.GetBattlefieldInstanceRunTime)
        end,
        GetBattlefieldMapIconScale = function()
          return checkCFunc(_G.GetBattlefieldMapIconScale)
        end,
        GetBattlefieldPortExpiration = function()
          return checkCFunc(_G.GetBattlefieldPortExpiration)
        end,
        GetBattlefieldScore = function()
          return checkCFunc(_G.GetBattlefieldScore)
        end,
        GetBattlefieldStatData = function()
          return checkCFunc(_G.GetBattlefieldStatData)
        end,
        GetBattlefieldStatInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetBattlefieldStatInfo)
          end
          return checkCFunc(_G.GetBattlefieldStatInfo)
        end,
        GetBattlefieldStatus = function()
          return checkCFunc(_G.GetBattlefieldStatus)
        end,
        GetBattlefieldTeamInfo = function()
          return checkCFunc(_G.GetBattlefieldTeamInfo)
        end,
        GetBattlefieldTimeWaited = function()
          return checkCFunc(_G.GetBattlefieldTimeWaited)
        end,
        GetBattlefieldWinner = function()
          return checkCFunc(_G.GetBattlefieldWinner)
        end,
        GetBattlegroundInfo = function()
          return checkCFunc(_G.GetBattlegroundInfo)
        end,
        GetBattlegroundPoints = function()
          return checkCFunc(_G.GetBattlegroundPoints)
        end,
        GetBestFlexRaidChoice = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetBestFlexRaidChoice)
          end
          return checkCFunc(_G.GetBestFlexRaidChoice)
        end,
        GetBestRFChoice = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetBestRFChoice)
          end
          return checkCFunc(_G.GetBestRFChoice)
        end,
        GetBidderAuctionItems = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetBidderAuctionItems)
          end
          return checkCFunc(_G.GetBidderAuctionItems)
        end,
        GetBillingTimeRested = function()
          return checkCFunc(_G.GetBillingTimeRested)
        end,
        GetBindLocation = function()
          return checkCFunc(_G.GetBindLocation)
        end,
        GetBinding = function()
          return checkCFunc(_G.GetBinding)
        end,
        GetBindingAction = function()
          return checkCFunc(_G.GetBindingAction)
        end,
        GetBindingByKey = function()
          return checkCFunc(_G.GetBindingByKey)
        end,
        GetBindingKey = function()
          return checkCFunc(_G.GetBindingKey)
        end,
        GetBindingText = function()
          return checkCFunc(_G.GetBindingText)
        end,
        GetBlockChance = function()
          return checkCFunc(_G.GetBlockChance)
        end,
        GetBonusBarIndex = function()
          return checkCFunc(_G.GetBonusBarIndex)
        end,
        GetBonusBarOffset = function()
          return checkCFunc(_G.GetBonusBarOffset)
        end,
        GetBuildInfo = function()
          return checkCFunc(_G.GetBuildInfo)
        end,
        GetBuybackItemInfo = function()
          return checkCFunc(_G.GetBuybackItemInfo)
        end,
        GetBuybackItemLink = function()
          return checkCFunc(_G.GetBuybackItemLink)
        end,
        GetCVarInfo = function()
          return checkCFunc(_G.GetCVarInfo)
        end,
        GetCVarSettingValidity = function()
          return checkCFunc(_G.GetCVarSettingValidity)
        end,
        GetCallPetSpellInfo = function()
          return checkCFunc(_G.GetCallPetSpellInfo)
        end,
        GetCameraZoom = function()
          return checkCFunc(_G.GetCameraZoom)
        end,
        GetCategoryAchievementPoints = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCategoryAchievementPoints)
          end
          return checkCFunc(_G.GetCategoryAchievementPoints)
        end,
        GetCategoryInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCategoryInfo)
          end
          return checkCFunc(_G.GetCategoryInfo)
        end,
        GetCategoryList = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCategoryList)
          end
          return checkCFunc(_G.GetCategoryList)
        end,
        GetCategoryNumAchievements = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCategoryNumAchievements)
          end
          return checkCFunc(_G.GetCategoryNumAchievements)
        end,
        GetCemeteryPreference = function()
          return checkCFunc(_G.GetCemeteryPreference)
        end,
        GetChannelDisplayInfo = function()
          return checkCFunc(_G.GetChannelDisplayInfo)
        end,
        GetChannelList = function()
          return checkCFunc(_G.GetChannelList)
        end,
        GetChannelName = function()
          return checkCFunc(_G.GetChannelName)
        end,
        GetChatTypeIndex = function()
          return checkCFunc(_G.GetChatTypeIndex)
        end,
        GetChatWindowChannels = function()
          return checkCFunc(_G.GetChatWindowChannels)
        end,
        GetChatWindowInfo = function()
          return checkCFunc(_G.GetChatWindowInfo)
        end,
        GetChatWindowMessages = function()
          return checkCFunc(_G.GetChatWindowMessages)
        end,
        GetChatWindowSavedDimensions = function()
          return checkCFunc(_G.GetChatWindowSavedDimensions)
        end,
        GetChatWindowSavedPosition = function()
          return checkCFunc(_G.GetChatWindowSavedPosition)
        end,
        GetClassInfo = function()
          return checkCFunc(_G.GetClassInfo)
        end,
        GetClassicExpansionLevel = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetClassicExpansionLevel)
          end
          return checkCFunc(_G.GetClassicExpansionLevel)
        end,
        GetClickFrame = function()
          return checkCFunc(_G.GetClickFrame)
        end,
        GetClientDisplayExpansionLevel = function()
          return checkCFunc(_G.GetClientDisplayExpansionLevel)
        end,
        GetCoinIcon = function()
          return checkCFunc(_G.GetCoinIcon)
        end,
        GetCoinText = function()
          return checkCFunc(_G.GetCoinText)
        end,
        GetCoinTextureString = function()
          return checkCFunc(_G.GetCoinTextureString)
        end,
        GetCombatRating = function()
          return checkCFunc(_G.GetCombatRating)
        end,
        GetCombatRatingBonus = function()
          return checkCFunc(_G.GetCombatRatingBonus)
        end,
        GetCombatRatingBonusForCombatRatingValue = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCombatRatingBonusForCombatRatingValue)
          end
          return checkCFunc(_G.GetCombatRatingBonusForCombatRatingValue)
        end,
        GetComboPoints = function()
          return checkCFunc(_G.GetComboPoints)
        end,
        GetCompanionInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCompanionInfo)
          end
          return checkCFunc(_G.GetCompanionInfo)
        end,
        GetComparisonAchievementPoints = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetComparisonAchievementPoints)
          end
          return checkCFunc(_G.GetComparisonAchievementPoints)
        end,
        GetComparisonCategoryNumAchievements = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetComparisonCategoryNumAchievements)
          end
          return checkCFunc(_G.GetComparisonCategoryNumAchievements)
        end,
        GetComparisonStatistic = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetComparisonStatistic)
          end
          return checkCFunc(_G.GetComparisonStatistic)
        end,
        GetContainerFreeSlots = function()
          return checkCFunc(_G.GetContainerFreeSlots)
        end,
        GetContainerItemCooldown = function()
          return checkCFunc(_G.GetContainerItemCooldown)
        end,
        GetContainerItemDurability = function()
          return checkCFunc(_G.GetContainerItemDurability)
        end,
        GetContainerItemEquipmentSetInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetContainerItemEquipmentSetInfo)
          end
          return checkCFunc(_G.GetContainerItemEquipmentSetInfo)
        end,
        GetContainerItemID = function()
          return checkCFunc(_G.GetContainerItemID)
        end,
        GetContainerItemInfo = function()
          return checkCFunc(_G.GetContainerItemInfo)
        end,
        GetContainerItemLink = function()
          return checkCFunc(_G.GetContainerItemLink)
        end,
        GetContainerItemPurchaseCurrency = function()
          return checkCFunc(_G.GetContainerItemPurchaseCurrency)
        end,
        GetContainerItemPurchaseInfo = function()
          return checkCFunc(_G.GetContainerItemPurchaseInfo)
        end,
        GetContainerItemPurchaseItem = function()
          return checkCFunc(_G.GetContainerItemPurchaseItem)
        end,
        GetContainerItemQuestInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetContainerItemQuestInfo)
          end
          return checkCFunc(_G.GetContainerItemQuestInfo)
        end,
        GetContainerNumFreeSlots = function()
          return checkCFunc(_G.GetContainerNumFreeSlots)
        end,
        GetContainerNumSlots = function()
          return checkCFunc(_G.GetContainerNumSlots)
        end,
        GetCorpseRecoveryDelay = function()
          return checkCFunc(_G.GetCorpseRecoveryDelay)
        end,
        GetCorruption = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCorruption)
          end
          return checkCFunc(_G.GetCorruption)
        end,
        GetCorruptionResistance = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCorruptionResistance)
          end
          return checkCFunc(_G.GetCorruptionResistance)
        end,
        GetCraftButtonToken = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftButtonToken)
          end
          return checkCFunc(_G.GetCraftButtonToken)
        end,
        GetCraftCooldown = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftCooldown)
          end
          return checkCFunc(_G.GetCraftCooldown)
        end,
        GetCraftDescription = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftDescription)
          end
          return checkCFunc(_G.GetCraftDescription)
        end,
        GetCraftDisplaySkillLine = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftDisplaySkillLine)
          end
          return checkCFunc(_G.GetCraftDisplaySkillLine)
        end,
        GetCraftFilter = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftFilter)
          end
          return checkCFunc(_G.GetCraftFilter)
        end,
        GetCraftIcon = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftIcon)
          end
          return checkCFunc(_G.GetCraftIcon)
        end,
        GetCraftInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftInfo)
          end
          return checkCFunc(_G.GetCraftInfo)
        end,
        GetCraftItemLink = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftItemLink)
          end
          return checkCFunc(_G.GetCraftItemLink)
        end,
        GetCraftName = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftName)
          end
          return checkCFunc(_G.GetCraftName)
        end,
        GetCraftNumMade = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftNumMade)
          end
          return checkCFunc(_G.GetCraftNumMade)
        end,
        GetCraftNumReagents = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftNumReagents)
          end
          return checkCFunc(_G.GetCraftNumReagents)
        end,
        GetCraftReagentInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftReagentInfo)
          end
          return checkCFunc(_G.GetCraftReagentInfo)
        end,
        GetCraftReagentItemLink = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftReagentItemLink)
          end
          return checkCFunc(_G.GetCraftReagentItemLink)
        end,
        GetCraftRecipeLink = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftRecipeLink)
          end
          return checkCFunc(_G.GetCraftRecipeLink)
        end,
        GetCraftSelectionIndex = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftSelectionIndex)
          end
          return checkCFunc(_G.GetCraftSelectionIndex)
        end,
        GetCraftSkillLine = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftSkillLine)
          end
          return checkCFunc(_G.GetCraftSkillLine)
        end,
        GetCraftSlots = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftSlots)
          end
          return checkCFunc(_G.GetCraftSlots)
        end,
        GetCraftSpellFocus = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCraftSpellFocus)
          end
          return checkCFunc(_G.GetCraftSpellFocus)
        end,
        GetCritChance = function()
          return checkCFunc(_G.GetCritChance)
        end,
        GetCritChanceFromAgility = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCritChanceFromAgility)
          end
          return checkCFunc(_G.GetCritChanceFromAgility)
        end,
        GetCritChanceProvidesParryEffect = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCritChanceProvidesParryEffect)
          end
          return checkCFunc(_G.GetCritChanceProvidesParryEffect)
        end,
        GetCriteriaSpell = function()
          return checkCFunc(_G.GetCriteriaSpell)
        end,
        GetCurrentArenaSeason = function()
          return checkCFunc(_G.GetCurrentArenaSeason)
        end,
        GetCurrentBindingSet = function()
          return checkCFunc(_G.GetCurrentBindingSet)
        end,
        GetCurrentCombatTextEventInfo = function()
          return checkCFunc(_G.GetCurrentCombatTextEventInfo)
        end,
        GetCurrentEventID = function()
          return checkCFunc(_G.GetCurrentEventID)
        end,
        GetCurrentGlyphNameForSpell = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCurrentGlyphNameForSpell)
          end
          return checkCFunc(_G.GetCurrentGlyphNameForSpell)
        end,
        GetCurrentGraphicsSetting = function()
          return checkCFunc(_G.GetCurrentGraphicsSetting)
        end,
        GetCurrentGuildBankTab = function()
          return checkCFunc(_G.GetCurrentGuildBankTab)
        end,
        GetCurrentKeyBoardFocus = function()
          return checkCFunc(_G.GetCurrentKeyBoardFocus)
        end,
        GetCurrentLevelFeatures = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetCurrentLevelFeatures)
          end
          return checkCFunc(_G.GetCurrentLevelFeatures)
        end,
        GetCurrentRegion = function()
          return checkCFunc(_G.GetCurrentRegion)
        end,
        GetCurrentRegionName = function()
          return checkCFunc(_G.GetCurrentRegionName)
        end,
        GetCurrentResolution = function()
          return checkCFunc(_G.GetCurrentResolution)
        end,
        GetCurrentScaledResolution = function()
          return checkCFunc(_G.GetCurrentScaledResolution)
        end,
        GetCurrentTitle = function()
          return checkCFunc(_G.GetCurrentTitle)
        end,
        GetCursorDelta = function()
          return checkCFunc(_G.GetCursorDelta)
        end,
        GetCursorInfo = function()
          return checkCFunc(_G.GetCursorInfo)
        end,
        GetCursorMoney = function()
          return checkCFunc(_G.GetCursorMoney)
        end,
        GetCursorPosition = function()
          return checkCFunc(_G.GetCursorPosition)
        end,
        GetDailyQuestsCompleted = function()
          return checkCFunc(_G.GetDailyQuestsCompleted)
        end,
        GetDeathRecapLink = function()
          return checkCFunc(_G.GetDeathRecapLink)
        end,
        GetDefaultGraphicsQuality = function()
          return checkCFunc(_G.GetDefaultGraphicsQuality)
        end,
        GetDefaultLanguage = function()
          return checkCFunc(_G.GetDefaultLanguage)
        end,
        GetDefaultScale = function()
          return checkCFunc(_G.GetDefaultScale)
        end,
        GetDefaultVideoOption = function()
          return checkCFunc(_G.GetDefaultVideoOption)
        end,
        GetDefaultVideoOptions = function()
          return checkCFunc(_G.GetDefaultVideoOptions)
        end,
        GetDefaultVideoQualityOption = function()
          return checkCFunc(_G.GetDefaultVideoQualityOption)
        end,
        GetDemotionRank = function()
          return checkCFunc(_G.GetDemotionRank)
        end,
        GetDetailedItemLevelInfo = function()
          return checkCFunc(_G.GetDetailedItemLevelInfo)
        end,
        GetDifficultyInfo = function()
          return checkCFunc(_G.GetDifficultyInfo)
        end,
        GetDodgeChance = function()
          return checkCFunc(_G.GetDodgeChance)
        end,
        GetDodgeChanceFromAttribute = function()
          return checkCFunc(_G.GetDodgeChanceFromAttribute)
        end,
        GetDownloadedPercentage = function()
          return checkCFunc(_G.GetDownloadedPercentage)
        end,
        GetDungeonDifficultyID = function()
          return checkCFunc(_G.GetDungeonDifficultyID)
        end,
        GetDungeonForRandomSlot = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetDungeonForRandomSlot)
          end
          return checkCFunc(_G.GetDungeonForRandomSlot)
        end,
        GetDungeonInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetDungeonInfo)
          end
          return checkCFunc(_G.GetDungeonInfo)
        end,
        GetEquipmentNameFromSpell = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetEquipmentNameFromSpell)
          end
          return checkCFunc(_G.GetEquipmentNameFromSpell)
        end,
        GetEventCPUUsage = function()
          return checkCFunc(_G.GetEventCPUUsage)
        end,
        GetEventTime = function()
          return checkCFunc(_G.GetEventTime)
        end,
        GetExistingSocketInfo = function()
          return checkCFunc(_G.GetExistingSocketInfo)
        end,
        GetExistingSocketLink = function()
          return checkCFunc(_G.GetExistingSocketLink)
        end,
        GetExpansionDisplayInfo = function()
          return checkCFunc(_G.GetExpansionDisplayInfo)
        end,
        GetExpansionForLevel = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetExpansionForLevel)
          end
          return checkCFunc(_G.GetExpansionForLevel)
        end,
        GetExpansionLevel = function()
          return checkCFunc(_G.GetExpansionLevel)
        end,
        GetExpansionTrialInfo = function()
          return checkCFunc(_G.GetExpansionTrialInfo)
        end,
        GetExpertise = function()
          return checkCFunc(_G.GetExpertise)
        end,
        GetExpertisePercent = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetExpertisePercent)
          end
          return checkCFunc(_G.GetExpertisePercent)
        end,
        GetExtraBarIndex = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetExtraBarIndex)
          end
          return checkCFunc(_G.GetExtraBarIndex)
        end,
        GetFactionInfo = function()
          return checkCFunc(_G.GetFactionInfo)
        end,
        GetFactionInfoByID = function()
          return checkCFunc(_G.GetFactionInfoByID)
        end,
        GetFailedPVPTalentIDs = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFailedPVPTalentIDs)
          end
          return checkCFunc(_G.GetFailedPVPTalentIDs)
        end,
        GetFailedTalentIDs = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFailedTalentIDs)
          end
          return checkCFunc(_G.GetFailedTalentIDs)
        end,
        GetFileIDFromPath = function()
          return checkCFunc(_G.GetFileIDFromPath)
        end,
        GetFileStreamingStatus = function()
          return checkCFunc(_G.GetFileStreamingStatus)
        end,
        GetFilteredAchievementID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFilteredAchievementID)
          end
          return checkCFunc(_G.GetFilteredAchievementID)
        end,
        GetFirstBagBankSlotIndex = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFirstBagBankSlotIndex)
          end
          return checkCFunc(_G.GetFirstBagBankSlotIndex)
        end,
        GetFirstTradeSkill = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFirstTradeSkill)
          end
          return checkCFunc(_G.GetFirstTradeSkill)
        end,
        GetFlexRaidDungeonInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFlexRaidDungeonInfo)
          end
          return checkCFunc(_G.GetFlexRaidDungeonInfo)
        end,
        GetFlyoutID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFlyoutID)
          end
          return checkCFunc(_G.GetFlyoutID)
        end,
        GetFlyoutInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFlyoutInfo)
          end
          return checkCFunc(_G.GetFlyoutInfo)
        end,
        GetFlyoutSlotInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFlyoutSlotInfo)
          end
          return checkCFunc(_G.GetFlyoutSlotInfo)
        end,
        GetFollowerTypeIDFromSpell = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFollowerTypeIDFromSpell)
          end
          return checkCFunc(_G.GetFollowerTypeIDFromSpell)
        end,
        GetFontInfo = function()
          return checkCFunc(_G.GetFontInfo)
        end,
        GetFonts = function()
          return checkCFunc(_G.GetFonts)
        end,
        GetFrameCPUUsage = function()
          return checkCFunc(_G.GetFrameCPUUsage)
        end,
        GetFramerate = function()
          return checkCFunc(_G.GetFramerate)
        end,
        GetFramesRegisteredForEvent = function()
          return checkCFunc(_G.GetFramesRegisteredForEvent)
        end,
        GetFriendshipReputation = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFriendshipReputation)
          end
          return checkCFunc(_G.GetFriendshipReputation)
        end,
        GetFriendshipReputationRanks = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetFriendshipReputationRanks)
          end
          return checkCFunc(_G.GetFriendshipReputationRanks)
        end,
        GetFunctionCPUUsage = function()
          return checkCFunc(_G.GetFunctionCPUUsage)
        end,
        GetGMStatus = function()
          return checkCFunc(_G.GetGMStatus)
        end,
        GetGMTicket = function()
          return checkCFunc(_G.GetGMTicket)
        end,
        GetGameMessageInfo = function()
          return checkCFunc(_G.GetGameMessageInfo)
        end,
        GetGameTime = function()
          return checkCFunc(_G.GetGameTime)
        end,
        GetGossipActiveQuests = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGossipActiveQuests)
          end
          return checkCFunc(_G.GetGossipActiveQuests)
        end,
        GetGossipAvailableQuests = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGossipAvailableQuests)
          end
          return checkCFunc(_G.GetGossipAvailableQuests)
        end,
        GetGossipOptions = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGossipOptions)
          end
          return checkCFunc(_G.GetGossipOptions)
        end,
        GetGossipText = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGossipText)
          end
          return checkCFunc(_G.GetGossipText)
        end,
        GetGraphicsAPIs = function()
          return checkCFunc(_G.GetGraphicsAPIs)
        end,
        GetGraphicsDropdownIndexByMasterIndex = function()
          return checkCFunc(_G.GetGraphicsDropdownIndexByMasterIndex)
        end,
        GetGreetingText = function()
          return checkCFunc(_G.GetGreetingText)
        end,
        GetGroupMemberCounts = function()
          return checkCFunc(_G.GetGroupMemberCounts)
        end,
        GetGuildAchievementMemberInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildAchievementMemberInfo)
          end
          return checkCFunc(_G.GetGuildAchievementMemberInfo)
        end,
        GetGuildAchievementMembers = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildAchievementMembers)
          end
          return checkCFunc(_G.GetGuildAchievementMembers)
        end,
        GetGuildAchievementNumMembers = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildAchievementNumMembers)
          end
          return checkCFunc(_G.GetGuildAchievementNumMembers)
        end,
        GetGuildBankBonusDepositMoney = function()
          return checkCFunc(_G.GetGuildBankBonusDepositMoney)
        end,
        GetGuildBankItemInfo = function()
          return checkCFunc(_G.GetGuildBankItemInfo)
        end,
        GetGuildBankItemLink = function()
          return checkCFunc(_G.GetGuildBankItemLink)
        end,
        GetGuildBankMoney = function()
          return checkCFunc(_G.GetGuildBankMoney)
        end,
        GetGuildBankMoneyTransaction = function()
          return checkCFunc(_G.GetGuildBankMoneyTransaction)
        end,
        GetGuildBankTabCost = function()
          return checkCFunc(_G.GetGuildBankTabCost)
        end,
        GetGuildBankTabInfo = function()
          return checkCFunc(_G.GetGuildBankTabInfo)
        end,
        GetGuildBankTabPermissions = function()
          return checkCFunc(_G.GetGuildBankTabPermissions)
        end,
        GetGuildBankText = function()
          return checkCFunc(_G.GetGuildBankText)
        end,
        GetGuildBankTransaction = function()
          return checkCFunc(_G.GetGuildBankTransaction)
        end,
        GetGuildBankWithdrawGoldLimit = function()
          return checkCFunc(_G.GetGuildBankWithdrawGoldLimit)
        end,
        GetGuildBankWithdrawMoney = function()
          return checkCFunc(_G.GetGuildBankWithdrawMoney)
        end,
        GetGuildCategoryList = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildCategoryList)
          end
          return checkCFunc(_G.GetGuildCategoryList)
        end,
        GetGuildChallengeInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildChallengeInfo)
          end
          return checkCFunc(_G.GetGuildChallengeInfo)
        end,
        GetGuildCharterCost = function()
          return checkCFunc(_G.GetGuildCharterCost)
        end,
        GetGuildEventInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildEventInfo)
          end
          return checkCFunc(_G.GetGuildEventInfo)
        end,
        GetGuildExpirationTime = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildExpirationTime)
          end
          return checkCFunc(_G.GetGuildExpirationTime)
        end,
        GetGuildFactionGroup = function()
          return checkCFunc(_G.GetGuildFactionGroup)
        end,
        GetGuildFactionInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildFactionInfo)
          end
          return checkCFunc(_G.GetGuildFactionInfo)
        end,
        GetGuildInfo = function()
          return checkCFunc(_G.GetGuildInfo)
        end,
        GetGuildInfoText = function()
          return checkCFunc(_G.GetGuildInfoText)
        end,
        GetGuildLogoInfo = function()
          return checkCFunc(_G.GetGuildLogoInfo)
        end,
        GetGuildMemberRecipes = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildMemberRecipes)
          end
          return checkCFunc(_G.GetGuildMemberRecipes)
        end,
        GetGuildNewsFilters = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildNewsFilters)
          end
          return checkCFunc(_G.GetGuildNewsFilters)
        end,
        GetGuildNewsMemberName = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildNewsMemberName)
          end
          return checkCFunc(_G.GetGuildNewsMemberName)
        end,
        GetGuildNewsSort = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildNewsSort)
          end
          return checkCFunc(_G.GetGuildNewsSort)
        end,
        GetGuildPerkInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildPerkInfo)
          end
          return checkCFunc(_G.GetGuildPerkInfo)
        end,
        GetGuildRecipeInfoPostQuery = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildRecipeInfoPostQuery)
          end
          return checkCFunc(_G.GetGuildRecipeInfoPostQuery)
        end,
        GetGuildRecipeMember = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildRecipeMember)
          end
          return checkCFunc(_G.GetGuildRecipeMember)
        end,
        GetGuildRenameRequired = function()
          return checkCFunc(_G.GetGuildRenameRequired)
        end,
        GetGuildRewardInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildRewardInfo)
          end
          return checkCFunc(_G.GetGuildRewardInfo)
        end,
        GetGuildRosterInfo = function()
          return checkCFunc(_G.GetGuildRosterInfo)
        end,
        GetGuildRosterLargestAchievementPoints = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildRosterLargestAchievementPoints)
          end
          return checkCFunc(_G.GetGuildRosterLargestAchievementPoints)
        end,
        GetGuildRosterLastOnline = function()
          return checkCFunc(_G.GetGuildRosterLastOnline)
        end,
        GetGuildRosterMOTD = function()
          return checkCFunc(_G.GetGuildRosterMOTD)
        end,
        GetGuildRosterSelection = function()
          return checkCFunc(_G.GetGuildRosterSelection)
        end,
        GetGuildRosterShowOffline = function()
          return checkCFunc(_G.GetGuildRosterShowOffline)
        end,
        GetGuildTabardFiles = function()
          return checkCFunc(_G.GetGuildTabardFiles)
        end,
        GetGuildTradeSkillInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetGuildTradeSkillInfo)
          end
          return checkCFunc(_G.GetGuildTradeSkillInfo)
        end,
        GetHaste = function()
          return checkCFunc(_G.GetHaste)
        end,
        GetHitModifier = function()
          return checkCFunc(_G.GetHitModifier)
        end,
        GetHomePartyInfo = function()
          return checkCFunc(_G.GetHomePartyInfo)
        end,
        GetInboxHeaderInfo = function()
          return checkCFunc(_G.GetInboxHeaderInfo)
        end,
        GetInboxInvoiceInfo = function()
          return checkCFunc(_G.GetInboxInvoiceInfo)
        end,
        GetInboxItem = function()
          return checkCFunc(_G.GetInboxItem)
        end,
        GetInboxItemLink = function()
          return checkCFunc(_G.GetInboxItemLink)
        end,
        GetInboxNumItems = function()
          return checkCFunc(_G.GetInboxNumItems)
        end,
        GetInboxText = function()
          return checkCFunc(_G.GetInboxText)
        end,
        GetInsertItemsLeftToRight = function()
          return checkCFunc(_G.GetInsertItemsLeftToRight)
        end,
        GetInspectArenaData = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetInspectArenaData)
          end
          return checkCFunc(_G.GetInspectArenaData)
        end,
        GetInspectArenaTeamData = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetInspectArenaTeamData)
          end
          return checkCFunc(_G.GetInspectArenaTeamData)
        end,
        GetInspectGuildInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetInspectGuildInfo)
          end
          return checkCFunc(_G.GetInspectGuildInfo)
        end,
        GetInspectHonorData = function()
          return checkCFunc(_G.GetInspectHonorData)
        end,
        GetInspectPVPRankProgress = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetInspectPVPRankProgress)
          end
          return checkCFunc(_G.GetInspectPVPRankProgress)
        end,
        GetInspectRatedBGData = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetInspectRatedBGData)
          end
          return checkCFunc(_G.GetInspectRatedBGData)
        end,
        GetInspectSpecialization = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetInspectSpecialization)
          end
          return checkCFunc(_G.GetInspectSpecialization)
        end,
        GetInspectTalent = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetInspectTalent)
          end
          return checkCFunc(_G.GetInspectTalent)
        end,
        GetInstanceBootTimeRemaining = function()
          return checkCFunc(_G.GetInstanceBootTimeRemaining)
        end,
        GetInstanceInfo = function()
          return checkCFunc(_G.GetInstanceInfo)
        end,
        GetInstanceLockTimeRemaining = function()
          return checkCFunc(_G.GetInstanceLockTimeRemaining)
        end,
        GetInstanceLockTimeRemainingEncounter = function()
          return checkCFunc(_G.GetInstanceLockTimeRemainingEncounter)
        end,
        GetInventoryAlertStatus = function()
          return checkCFunc(_G.GetInventoryAlertStatus)
        end,
        GetInventoryItemBroken = function()
          return checkCFunc(_G.GetInventoryItemBroken)
        end,
        GetInventoryItemCooldown = function()
          return checkCFunc(_G.GetInventoryItemCooldown)
        end,
        GetInventoryItemCount = function()
          return checkCFunc(_G.GetInventoryItemCount)
        end,
        GetInventoryItemDurability = function()
          return checkCFunc(_G.GetInventoryItemDurability)
        end,
        GetInventoryItemEquippedUnusable = function()
          return checkCFunc(_G.GetInventoryItemEquippedUnusable)
        end,
        GetInventoryItemID = function()
          return checkCFunc(_G.GetInventoryItemID)
        end,
        GetInventoryItemLink = function()
          return checkCFunc(_G.GetInventoryItemLink)
        end,
        GetInventoryItemQuality = function()
          return checkCFunc(_G.GetInventoryItemQuality)
        end,
        GetInventoryItemTexture = function()
          return checkCFunc(_G.GetInventoryItemTexture)
        end,
        GetInventoryItemsForSlot = function()
          return checkCFunc(_G.GetInventoryItemsForSlot)
        end,
        GetInventorySlotInfo = function()
          return checkCFunc(_G.GetInventorySlotInfo)
        end,
        GetInviteConfirmationInfo = function()
          return checkCFunc(_G.GetInviteConfirmationInfo)
        end,
        GetInviteReferralInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetInviteReferralInfo)
          end
          return checkCFunc(_G.GetInviteReferralInfo)
        end,
        GetItemChildInfo = function()
          return checkCFunc(_G.GetItemChildInfo)
        end,
        GetItemClassInfo = function()
          return checkCFunc(_G.GetItemClassInfo)
        end,
        GetItemCooldown = function()
          return checkCFunc(_G.GetItemCooldown)
        end,
        GetItemCount = function()
          return checkCFunc(_G.GetItemCount)
        end,
        GetItemCreationContext = function()
          return checkCFunc(_G.GetItemCreationContext)
        end,
        GetItemFamily = function()
          return checkCFunc(_G.GetItemFamily)
        end,
        GetItemGem = function()
          return checkCFunc(_G.GetItemGem)
        end,
        GetItemIcon = function()
          return checkCFunc(_G.GetItemIcon)
        end,
        GetItemInfo = function()
          return checkCFunc(_G.GetItemInfo)
        end,
        GetItemInfoInstant = function()
          return checkCFunc(_G.GetItemInfoInstant)
        end,
        GetItemInventorySlotInfo = function()
          return checkCFunc(_G.GetItemInventorySlotInfo)
        end,
        GetItemLevelColor = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetItemLevelColor)
          end
          return checkCFunc(_G.GetItemLevelColor)
        end,
        GetItemQualityColor = function()
          return checkCFunc(_G.GetItemQualityColor)
        end,
        GetItemSetInfo = function()
          return checkCFunc(_G.GetItemSetInfo)
        end,
        GetItemSpecInfo = function()
          return checkCFunc(_G.GetItemSpecInfo)
        end,
        GetItemSpell = function()
          return checkCFunc(_G.GetItemSpell)
        end,
        GetItemStatDelta = function()
          return checkCFunc(_G.GetItemStatDelta)
        end,
        GetItemStats = function()
          return checkCFunc(_G.GetItemStats)
        end,
        GetItemSubClassInfo = function()
          return checkCFunc(_G.GetItemSubClassInfo)
        end,
        GetItemUniqueness = function()
          return checkCFunc(_G.GetItemUniqueness)
        end,
        GetJailersTowerLevel = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetJailersTowerLevel)
          end
          return checkCFunc(_G.GetJailersTowerLevel)
        end,
        GetJournalInfoForSpellConfirmation = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetJournalInfoForSpellConfirmation)
          end
          return checkCFunc(_G.GetJournalInfoForSpellConfirmation)
        end,
        GetLFDChoiceCollapseState = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFDChoiceCollapseState)
          end
          return checkCFunc(_G.GetLFDChoiceCollapseState)
        end,
        GetLFDChoiceEnabledState = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFDChoiceEnabledState)
          end
          return checkCFunc(_G.GetLFDChoiceEnabledState)
        end,
        GetLFDChoiceOrder = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFDChoiceOrder)
          end
          return checkCFunc(_G.GetLFDChoiceOrder)
        end,
        GetLFDLockInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFDLockInfo)
          end
          return checkCFunc(_G.GetLFDLockInfo)
        end,
        GetLFDLockPlayerCount = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFDLockPlayerCount)
          end
          return checkCFunc(_G.GetLFDLockPlayerCount)
        end,
        GetLFDRoleLockInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFDRoleLockInfo)
          end
          return checkCFunc(_G.GetLFDRoleLockInfo)
        end,
        GetLFDRoleRestrictions = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFDRoleRestrictions)
          end
          return checkCFunc(_G.GetLFDRoleRestrictions)
        end,
        GetLFGBootProposal = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGBootProposal)
          end
          return checkCFunc(_G.GetLFGBootProposal)
        end,
        GetLFGCategoryForID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGCategoryForID)
          end
          return checkCFunc(_G.GetLFGCategoryForID)
        end,
        GetLFGCompletionReward = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGCompletionReward)
          end
          return checkCFunc(_G.GetLFGCompletionReward)
        end,
        GetLFGCompletionRewardItem = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGCompletionRewardItem)
          end
          return checkCFunc(_G.GetLFGCompletionRewardItem)
        end,
        GetLFGCompletionRewardItemLink = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGCompletionRewardItemLink)
          end
          return checkCFunc(_G.GetLFGCompletionRewardItemLink)
        end,
        GetLFGDeserterExpiration = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGDeserterExpiration)
          end
          return checkCFunc(_G.GetLFGDeserterExpiration)
        end,
        GetLFGDungeonEncounterInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGDungeonEncounterInfo)
          end
          return checkCFunc(_G.GetLFGDungeonEncounterInfo)
        end,
        GetLFGDungeonInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGDungeonInfo)
          end
          return checkCFunc(_G.GetLFGDungeonInfo)
        end,
        GetLFGDungeonNumEncounters = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGDungeonNumEncounters)
          end
          return checkCFunc(_G.GetLFGDungeonNumEncounters)
        end,
        GetLFGDungeonRewardCapBarInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGDungeonRewardCapBarInfo)
          end
          return checkCFunc(_G.GetLFGDungeonRewardCapBarInfo)
        end,
        GetLFGDungeonRewardCapInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGDungeonRewardCapInfo)
          end
          return checkCFunc(_G.GetLFGDungeonRewardCapInfo)
        end,
        GetLFGDungeonRewardInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGDungeonRewardInfo)
          end
          return checkCFunc(_G.GetLFGDungeonRewardInfo)
        end,
        GetLFGDungeonRewardLink = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGDungeonRewardLink)
          end
          return checkCFunc(_G.GetLFGDungeonRewardLink)
        end,
        GetLFGDungeonRewards = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGDungeonRewards)
          end
          return checkCFunc(_G.GetLFGDungeonRewards)
        end,
        GetLFGDungeonShortageRewardInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGDungeonShortageRewardInfo)
          end
          return checkCFunc(_G.GetLFGDungeonShortageRewardInfo)
        end,
        GetLFGDungeonShortageRewardLink = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGDungeonShortageRewardLink)
          end
          return checkCFunc(_G.GetLFGDungeonShortageRewardLink)
        end,
        GetLFGInfoServer = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGInfoServer)
          end
          return checkCFunc(_G.GetLFGInfoServer)
        end,
        GetLFGInviteRoleAvailability = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGInviteRoleAvailability)
          end
          return checkCFunc(_G.GetLFGInviteRoleAvailability)
        end,
        GetLFGInviteRoleRestrictions = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGInviteRoleRestrictions)
          end
          return checkCFunc(_G.GetLFGInviteRoleRestrictions)
        end,
        GetLFGProposal = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGProposal)
          end
          return checkCFunc(_G.GetLFGProposal)
        end,
        GetLFGProposalEncounter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGProposalEncounter)
          end
          return checkCFunc(_G.GetLFGProposalEncounter)
        end,
        GetLFGProposalMember = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGProposalMember)
          end
          return checkCFunc(_G.GetLFGProposalMember)
        end,
        GetLFGQueueStats = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGQueueStats)
          end
          return checkCFunc(_G.GetLFGQueueStats)
        end,
        GetLFGQueuedList = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGQueuedList)
          end
          return checkCFunc(_G.GetLFGQueuedList)
        end,
        GetLFGRandomCooldownExpiration = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGRandomCooldownExpiration)
          end
          return checkCFunc(_G.GetLFGRandomCooldownExpiration)
        end,
        GetLFGRandomDungeonInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGRandomDungeonInfo)
          end
          return checkCFunc(_G.GetLFGRandomDungeonInfo)
        end,
        GetLFGReadyCheckUpdate = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGReadyCheckUpdate)
          end
          return checkCFunc(_G.GetLFGReadyCheckUpdate)
        end,
        GetLFGReadyCheckUpdateBattlegroundInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGReadyCheckUpdateBattlegroundInfo)
          end
          return checkCFunc(_G.GetLFGReadyCheckUpdateBattlegroundInfo)
        end,
        GetLFGRoleShortageRewards = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGRoleShortageRewards)
          end
          return checkCFunc(_G.GetLFGRoleShortageRewards)
        end,
        GetLFGRoleUpdate = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGRoleUpdate)
          end
          return checkCFunc(_G.GetLFGRoleUpdate)
        end,
        GetLFGRoleUpdateBattlegroundInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGRoleUpdateBattlegroundInfo)
          end
          return checkCFunc(_G.GetLFGRoleUpdateBattlegroundInfo)
        end,
        GetLFGRoleUpdateMember = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGRoleUpdateMember)
          end
          return checkCFunc(_G.GetLFGRoleUpdateMember)
        end,
        GetLFGRoleUpdateSlot = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGRoleUpdateSlot)
          end
          return checkCFunc(_G.GetLFGRoleUpdateSlot)
        end,
        GetLFGRoles = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGRoles)
          end
          return checkCFunc(_G.GetLFGRoles)
        end,
        GetLFGSuspendedPlayers = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFGSuspendedPlayers)
          end
          return checkCFunc(_G.GetLFGSuspendedPlayers)
        end,
        GetLFRChoiceOrder = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLFRChoiceOrder)
          end
          return checkCFunc(_G.GetLFRChoiceOrder)
        end,
        GetLanguageByIndex = function()
          return checkCFunc(_G.GetLanguageByIndex)
        end,
        GetLatestCompletedAchievements = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLatestCompletedAchievements)
          end
          return checkCFunc(_G.GetLatestCompletedAchievements)
        end,
        GetLatestCompletedComparisonAchievements = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLatestCompletedComparisonAchievements)
          end
          return checkCFunc(_G.GetLatestCompletedComparisonAchievements)
        end,
        GetLatestThreeSenders = function()
          return checkCFunc(_G.GetLatestThreeSenders)
        end,
        GetLatestUpdatedComparisonStats = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLatestUpdatedComparisonStats)
          end
          return checkCFunc(_G.GetLatestUpdatedComparisonStats)
        end,
        GetLatestUpdatedStats = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLatestUpdatedStats)
          end
          return checkCFunc(_G.GetLatestUpdatedStats)
        end,
        GetLegacyRaidDifficultyID = function()
          return checkCFunc(_G.GetLegacyRaidDifficultyID)
        end,
        GetLifesteal = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLifesteal)
          end
          return checkCFunc(_G.GetLifesteal)
        end,
        GetLocalGameTime = function()
          return checkCFunc(_G.GetLocalGameTime)
        end,
        GetLocale = function()
          return checkCFunc(_G.GetLocale)
        end,
        GetLooseMacroIcons = function()
          return checkCFunc(_G.GetLooseMacroIcons)
        end,
        GetLooseMacroItemIcons = function()
          return checkCFunc(_G.GetLooseMacroItemIcons)
        end,
        GetLootInfo = function()
          return checkCFunc(_G.GetLootInfo)
        end,
        GetLootMethod = function()
          return checkCFunc(_G.GetLootMethod)
        end,
        GetLootRollItemInfo = function()
          return checkCFunc(_G.GetLootRollItemInfo)
        end,
        GetLootRollItemLink = function()
          return checkCFunc(_G.GetLootRollItemLink)
        end,
        GetLootRollTimeLeft = function()
          return checkCFunc(_G.GetLootRollTimeLeft)
        end,
        GetLootSlotInfo = function()
          return checkCFunc(_G.GetLootSlotInfo)
        end,
        GetLootSlotLink = function()
          return checkCFunc(_G.GetLootSlotLink)
        end,
        GetLootSlotType = function()
          return checkCFunc(_G.GetLootSlotType)
        end,
        GetLootSourceInfo = function()
          return checkCFunc(_G.GetLootSourceInfo)
        end,
        GetLootSpecialization = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetLootSpecialization)
          end
          return checkCFunc(_G.GetLootSpecialization)
        end,
        GetLootThreshold = function()
          return checkCFunc(_G.GetLootThreshold)
        end,
        GetMacroBody = function()
          return checkCFunc(_G.GetMacroBody)
        end,
        GetMacroIcons = function()
          return checkCFunc(_G.GetMacroIcons)
        end,
        GetMacroIndexByName = function()
          return checkCFunc(_G.GetMacroIndexByName)
        end,
        GetMacroInfo = function()
          return checkCFunc(_G.GetMacroInfo)
        end,
        GetMacroItem = function()
          return checkCFunc(_G.GetMacroItem)
        end,
        GetMacroItemIcons = function()
          return checkCFunc(_G.GetMacroItemIcons)
        end,
        GetMacroSpell = function()
          return checkCFunc(_G.GetMacroSpell)
        end,
        GetManaRegen = function()
          return checkCFunc(_G.GetManaRegen)
        end,
        GetMasterLootCandidate = function()
          return checkCFunc(_G.GetMasterLootCandidate)
        end,
        GetMastery = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMastery)
          end
          return checkCFunc(_G.GetMastery)
        end,
        GetMasteryEffect = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMasteryEffect)
          end
          return checkCFunc(_G.GetMasteryEffect)
        end,
        GetMawPowerLinkBySpellID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMawPowerLinkBySpellID)
          end
          return checkCFunc(_G.GetMawPowerLinkBySpellID)
        end,
        GetMaxArenaCurrency = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMaxArenaCurrency)
          end
          return checkCFunc(_G.GetMaxArenaCurrency)
        end,
        GetMaxBattlefieldID = function()
          return checkCFunc(_G.GetMaxBattlefieldID)
        end,
        GetMaxCombatRatingBonus = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMaxCombatRatingBonus)
          end
          return checkCFunc(_G.GetMaxCombatRatingBonus)
        end,
        GetMaxDailyQuests = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMaxDailyQuests)
          end
          return checkCFunc(_G.GetMaxDailyQuests)
        end,
        GetMaxLevelForExpansionLevel = function()
          return checkCFunc(_G.GetMaxLevelForExpansionLevel)
        end,
        GetMaxLevelForLatestExpansion = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMaxLevelForLatestExpansion)
          end
          return checkCFunc(_G.GetMaxLevelForLatestExpansion)
        end,
        GetMaxLevelForPlayerExpansion = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMaxLevelForPlayerExpansion)
          end
          return checkCFunc(_G.GetMaxLevelForPlayerExpansion)
        end,
        GetMaxNumCUFProfiles = function()
          return checkCFunc(_G.GetMaxNumCUFProfiles)
        end,
        GetMaxPlayerLevel = function()
          return checkCFunc(_G.GetMaxPlayerLevel)
        end,
        GetMaxRenderScale = function()
          return checkCFunc(_G.GetMaxRenderScale)
        end,
        GetMaxRewardCurrencies = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMaxRewardCurrencies)
          end
          return checkCFunc(_G.GetMaxRewardCurrencies)
        end,
        GetMaxSpellStartRecoveryOffset = function()
          return checkCFunc(_G.GetMaxSpellStartRecoveryOffset)
        end,
        GetMaxTalentTier = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMaxTalentTier)
          end
          return checkCFunc(_G.GetMaxTalentTier)
        end,
        GetMaximumExpansionLevel = function()
          return checkCFunc(_G.GetMaximumExpansionLevel)
        end,
        GetMeleeHaste = function()
          return checkCFunc(_G.GetMeleeHaste)
        end,
        GetMerchantCurrencies = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMerchantCurrencies)
          end
          return checkCFunc(_G.GetMerchantCurrencies)
        end,
        GetMerchantFilter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMerchantFilter)
          end
          return checkCFunc(_G.GetMerchantFilter)
        end,
        GetMerchantItemCostInfo = function()
          return checkCFunc(_G.GetMerchantItemCostInfo)
        end,
        GetMerchantItemCostItem = function()
          return checkCFunc(_G.GetMerchantItemCostItem)
        end,
        GetMerchantItemID = function()
          return checkCFunc(_G.GetMerchantItemID)
        end,
        GetMerchantItemInfo = function()
          return checkCFunc(_G.GetMerchantItemInfo)
        end,
        GetMerchantItemLink = function()
          return checkCFunc(_G.GetMerchantItemLink)
        end,
        GetMerchantItemMaxStack = function()
          return checkCFunc(_G.GetMerchantItemMaxStack)
        end,
        GetMerchantNumItems = function()
          return checkCFunc(_G.GetMerchantNumItems)
        end,
        GetMinRenderScale = function()
          return checkCFunc(_G.GetMinRenderScale)
        end,
        GetMinimapZoneText = function()
          return checkCFunc(_G.GetMinimapZoneText)
        end,
        GetMinimumExpansionLevel = function()
          return checkCFunc(_G.GetMinimumExpansionLevel)
        end,
        GetMirrorTimerInfo = function()
          return checkCFunc(_G.GetMirrorTimerInfo)
        end,
        GetMirrorTimerProgress = function()
          return checkCFunc(_G.GetMirrorTimerProgress)
        end,
        GetModResilienceDamageReduction = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetModResilienceDamageReduction)
          end
          return checkCFunc(_G.GetModResilienceDamageReduction)
        end,
        GetModifiedClick = function()
          return checkCFunc(_G.GetModifiedClick)
        end,
        GetModifiedClickAction = function()
          return checkCFunc(_G.GetModifiedClickAction)
        end,
        GetMoney = function()
          return checkCFunc(_G.GetMoney)
        end,
        GetMonitorAspectRatio = function()
          return checkCFunc(_G.GetMonitorAspectRatio)
        end,
        GetMonitorCount = function()
          return checkCFunc(_G.GetMonitorCount)
        end,
        GetMonitorName = function()
          return checkCFunc(_G.GetMonitorName)
        end,
        GetMouseButtonClicked = function()
          return checkCFunc(_G.GetMouseButtonClicked)
        end,
        GetMouseButtonName = function()
          return checkCFunc(_G.GetMouseButtonName)
        end,
        GetMouseClickFocus = function()
          return checkCFunc(_G.GetMouseClickFocus)
        end,
        GetMouseFocus = function()
          return checkCFunc(_G.GetMouseFocus)
        end,
        GetMouseMotionFocus = function()
          return checkCFunc(_G.GetMouseMotionFocus)
        end,
        GetMovieDownloadProgress = function()
          return checkCFunc(_G.GetMovieDownloadProgress)
        end,
        GetMultiCastBarIndex = function()
          return checkCFunc(_G.GetMultiCastBarIndex)
        end,
        GetMultiCastTotemSpells = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetMultiCastTotemSpells)
          end
          return checkCFunc(_G.GetMultiCastTotemSpells)
        end,
        GetNegativeCorruptionEffectInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNegativeCorruptionEffectInfo)
          end
          return checkCFunc(_G.GetNegativeCorruptionEffectInfo)
        end,
        GetNetIpTypes = function()
          return checkCFunc(_G.GetNetIpTypes)
        end,
        GetNetStats = function()
          return checkCFunc(_G.GetNetStats)
        end,
        GetNewSocketInfo = function()
          return checkCFunc(_G.GetNewSocketInfo)
        end,
        GetNewSocketLink = function()
          return checkCFunc(_G.GetNewSocketLink)
        end,
        GetNextAchievement = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNextAchievement)
          end
          return checkCFunc(_G.GetNextAchievement)
        end,
        GetNextCompleatedTutorial = function()
          return checkCFunc(_G.GetNextCompleatedTutorial)
        end,
        GetNextPendingInviteConfirmation = function()
          return checkCFunc(_G.GetNextPendingInviteConfirmation)
        end,
        GetNextStableSlotCost = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNextStableSlotCost)
          end
          return checkCFunc(_G.GetNextStableSlotCost)
        end,
        GetNormalizedRealmName = function()
          return checkCFunc(_G.GetNormalizedRealmName)
        end,
        GetNumActiveQuests = function()
          return checkCFunc(_G.GetNumActiveQuests)
        end,
        GetNumAddOns = function()
          return checkCFunc(_G.GetNumAddOns)
        end,
        GetNumArchaeologyRaces = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumArchaeologyRaces)
          end
          return checkCFunc(_G.GetNumArchaeologyRaces)
        end,
        GetNumArenaOpponentSpecs = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumArenaOpponentSpecs)
          end
          return checkCFunc(_G.GetNumArenaOpponentSpecs)
        end,
        GetNumArenaOpponents = function()
          return checkCFunc(_G.GetNumArenaOpponents)
        end,
        GetNumArenaTeamMembers = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumArenaTeamMembers)
          end
          return checkCFunc(_G.GetNumArenaTeamMembers)
        end,
        GetNumArtifactsByRace = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumArtifactsByRace)
          end
          return checkCFunc(_G.GetNumArtifactsByRace)
        end,
        GetNumAuctionItems = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumAuctionItems)
          end
          return checkCFunc(_G.GetNumAuctionItems)
        end,
        GetNumAutoQuestPopUps = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumAutoQuestPopUps)
          end
          return checkCFunc(_G.GetNumAutoQuestPopUps)
        end,
        GetNumAvailableQuests = function()
          return checkCFunc(_G.GetNumAvailableQuests)
        end,
        GetNumBankSlots = function()
          return checkCFunc(_G.GetNumBankSlots)
        end,
        GetNumBattlefieldFlagPositions = function()
          return checkCFunc(_G.GetNumBattlefieldFlagPositions)
        end,
        GetNumBattlefieldScores = function()
          return checkCFunc(_G.GetNumBattlefieldScores)
        end,
        GetNumBattlefieldStats = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumBattlefieldStats)
          end
          return checkCFunc(_G.GetNumBattlefieldStats)
        end,
        GetNumBattlefieldVehicles = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumBattlefieldVehicles)
          end
          return checkCFunc(_G.GetNumBattlefieldVehicles)
        end,
        GetNumBattlefields = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumBattlefields)
          end
          return checkCFunc(_G.GetNumBattlefields)
        end,
        GetNumBattlegroundTypes = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumBattlegroundTypes)
          end
          return checkCFunc(_G.GetNumBattlegroundTypes)
        end,
        GetNumBindings = function()
          return checkCFunc(_G.GetNumBindings)
        end,
        GetNumBuybackItems = function()
          return checkCFunc(_G.GetNumBuybackItems)
        end,
        GetNumChannelMembers = function()
          return checkCFunc(_G.GetNumChannelMembers)
        end,
        GetNumClasses = function()
          return checkCFunc(_G.GetNumClasses)
        end,
        GetNumCompanions = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumCompanions)
          end
          return checkCFunc(_G.GetNumCompanions)
        end,
        GetNumComparisonCompletedAchievements = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumComparisonCompletedAchievements)
          end
          return checkCFunc(_G.GetNumComparisonCompletedAchievements)
        end,
        GetNumCompletedAchievements = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumCompletedAchievements)
          end
          return checkCFunc(_G.GetNumCompletedAchievements)
        end,
        GetNumCrafts = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumCrafts)
          end
          return checkCFunc(_G.GetNumCrafts)
        end,
        GetNumDeclensionSets = function()
          return checkCFunc(_G.GetNumDeclensionSets)
        end,
        GetNumDisplayChannels = function()
          return checkCFunc(_G.GetNumDisplayChannels)
        end,
        GetNumDungeonForRandomSlot = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumDungeonForRandomSlot)
          end
          return checkCFunc(_G.GetNumDungeonForRandomSlot)
        end,
        GetNumExpansions = function()
          return checkCFunc(_G.GetNumExpansions)
        end,
        GetNumFactions = function()
          return checkCFunc(_G.GetNumFactions)
        end,
        GetNumFilteredAchievements = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumFilteredAchievements)
          end
          return checkCFunc(_G.GetNumFilteredAchievements)
        end,
        GetNumFlexRaidDungeons = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumFlexRaidDungeons)
          end
          return checkCFunc(_G.GetNumFlexRaidDungeons)
        end,
        GetNumFlyouts = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumFlyouts)
          end
          return checkCFunc(_G.GetNumFlyouts)
        end,
        GetNumFrames = function()
          return checkCFunc(_G.GetNumFrames)
        end,
        GetNumGossipActiveQuests = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumGossipActiveQuests)
          end
          return checkCFunc(_G.GetNumGossipActiveQuests)
        end,
        GetNumGossipAvailableQuests = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumGossipAvailableQuests)
          end
          return checkCFunc(_G.GetNumGossipAvailableQuests)
        end,
        GetNumGossipOptions = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumGossipOptions)
          end
          return checkCFunc(_G.GetNumGossipOptions)
        end,
        GetNumGroupChannels = function()
          return checkCFunc(_G.GetNumGroupChannels)
        end,
        GetNumGroupMembers = function()
          return checkCFunc(_G.GetNumGroupMembers)
        end,
        GetNumGuildBankMoneyTransactions = function()
          return checkCFunc(_G.GetNumGuildBankMoneyTransactions)
        end,
        GetNumGuildBankTabs = function()
          return checkCFunc(_G.GetNumGuildBankTabs)
        end,
        GetNumGuildBankTransactions = function()
          return checkCFunc(_G.GetNumGuildBankTransactions)
        end,
        GetNumGuildChallenges = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumGuildChallenges)
          end
          return checkCFunc(_G.GetNumGuildChallenges)
        end,
        GetNumGuildEvents = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumGuildEvents)
          end
          return checkCFunc(_G.GetNumGuildEvents)
        end,
        GetNumGuildMembers = function()
          return checkCFunc(_G.GetNumGuildMembers)
        end,
        GetNumGuildNews = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumGuildNews)
          end
          return checkCFunc(_G.GetNumGuildNews)
        end,
        GetNumGuildPerks = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumGuildPerks)
          end
          return checkCFunc(_G.GetNumGuildPerks)
        end,
        GetNumGuildRewards = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumGuildRewards)
          end
          return checkCFunc(_G.GetNumGuildRewards)
        end,
        GetNumGuildTradeSkill = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumGuildTradeSkill)
          end
          return checkCFunc(_G.GetNumGuildTradeSkill)
        end,
        GetNumLanguages = function()
          return checkCFunc(_G.GetNumLanguages)
        end,
        GetNumLootItems = function()
          return checkCFunc(_G.GetNumLootItems)
        end,
        GetNumMacros = function()
          return checkCFunc(_G.GetNumMacros)
        end,
        GetNumMembersInRank = function()
          return checkCFunc(_G.GetNumMembersInRank)
        end,
        GetNumModifiedClickActions = function()
          return checkCFunc(_G.GetNumModifiedClickActions)
        end,
        GetNumPetitionNames = function()
          return checkCFunc(_G.GetNumPetitionNames)
        end,
        GetNumPrimaryProfessions = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumPrimaryProfessions)
          end
          return checkCFunc(_G.GetNumPrimaryProfessions)
        end,
        GetNumQuestChoices = function()
          return checkCFunc(_G.GetNumQuestChoices)
        end,
        GetNumQuestCurrencies = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumQuestCurrencies)
          end
          return checkCFunc(_G.GetNumQuestCurrencies)
        end,
        GetNumQuestItemDrops = function()
          return checkCFunc(_G.GetNumQuestItemDrops)
        end,
        GetNumQuestItems = function()
          return checkCFunc(_G.GetNumQuestItems)
        end,
        GetNumQuestLeaderBoards = function()
          return checkCFunc(_G.GetNumQuestLeaderBoards)
        end,
        GetNumQuestLogChoices = function()
          return checkCFunc(_G.GetNumQuestLogChoices)
        end,
        GetNumQuestLogEntries = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumQuestLogEntries)
          end
          return checkCFunc(_G.GetNumQuestLogEntries)
        end,
        GetNumQuestLogRewardCurrencies = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumQuestLogRewardCurrencies)
          end
          return checkCFunc(_G.GetNumQuestLogRewardCurrencies)
        end,
        GetNumQuestLogRewardFactions = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumQuestLogRewardFactions)
          end
          return checkCFunc(_G.GetNumQuestLogRewardFactions)
        end,
        GetNumQuestLogRewardSpells = function()
          return checkCFunc(_G.GetNumQuestLogRewardSpells)
        end,
        GetNumQuestLogRewards = function()
          return checkCFunc(_G.GetNumQuestLogRewards)
        end,
        GetNumQuestLogTasks = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumQuestLogTasks)
          end
          return checkCFunc(_G.GetNumQuestLogTasks)
        end,
        GetNumQuestPOIWorldEffects = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumQuestPOIWorldEffects)
          end
          return checkCFunc(_G.GetNumQuestPOIWorldEffects)
        end,
        GetNumQuestRewards = function()
          return checkCFunc(_G.GetNumQuestRewards)
        end,
        GetNumQuestWatches = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumQuestWatches)
          end
          return checkCFunc(_G.GetNumQuestWatches)
        end,
        GetNumRFDungeons = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumRFDungeons)
          end
          return checkCFunc(_G.GetNumRFDungeons)
        end,
        GetNumRaidProfiles = function()
          return checkCFunc(_G.GetNumRaidProfiles)
        end,
        GetNumRandomDungeons = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumRandomDungeons)
          end
          return checkCFunc(_G.GetNumRandomDungeons)
        end,
        GetNumRandomScenarios = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumRandomScenarios)
          end
          return checkCFunc(_G.GetNumRandomScenarios)
        end,
        GetNumRewardCurrencies = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumRewardCurrencies)
          end
          return checkCFunc(_G.GetNumRewardCurrencies)
        end,
        GetNumRewardSpells = function()
          return checkCFunc(_G.GetNumRewardSpells)
        end,
        GetNumRoutes = function()
          return checkCFunc(_G.GetNumRoutes)
        end,
        GetNumSavedInstances = function()
          return checkCFunc(_G.GetNumSavedInstances)
        end,
        GetNumSavedWorldBosses = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumSavedWorldBosses)
          end
          return checkCFunc(_G.GetNumSavedWorldBosses)
        end,
        GetNumScenarios = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumScenarios)
          end
          return checkCFunc(_G.GetNumScenarios)
        end,
        GetNumShapeshiftForms = function()
          return checkCFunc(_G.GetNumShapeshiftForms)
        end,
        GetNumSkillLines = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumSkillLines)
          end
          return checkCFunc(_G.GetNumSkillLines)
        end,
        GetNumSoRRemaining = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumSoRRemaining)
          end
          return checkCFunc(_G.GetNumSoRRemaining)
        end,
        GetNumSockets = function()
          return checkCFunc(_G.GetNumSockets)
        end,
        GetNumSpecGroups = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumSpecGroups)
          end
          return checkCFunc(_G.GetNumSpecGroups)
        end,
        GetNumSpecializations = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumSpecializations)
          end
          return checkCFunc(_G.GetNumSpecializations)
        end,
        GetNumSpecializationsForClassID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumSpecializationsForClassID)
          end
          return checkCFunc(_G.GetNumSpecializationsForClassID)
        end,
        GetNumSpellTabs = function()
          return checkCFunc(_G.GetNumSpellTabs)
        end,
        GetNumStableSlots = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumStableSlots)
          end
          return checkCFunc(_G.GetNumStableSlots)
        end,
        GetNumSubgroupMembers = function()
          return checkCFunc(_G.GetNumSubgroupMembers)
        end,
        GetNumTalentTabs = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumTalentTabs)
          end
          return checkCFunc(_G.GetNumTalentTabs)
        end,
        GetNumTalents = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumTalents)
          end
          return checkCFunc(_G.GetNumTalents)
        end,
        GetNumTitles = function()
          return checkCFunc(_G.GetNumTitles)
        end,
        GetNumTrackedAchievements = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumTrackedAchievements)
          end
          return checkCFunc(_G.GetNumTrackedAchievements)
        end,
        GetNumTrackingTypes = function()
          return checkCFunc(_G.GetNumTrackingTypes)
        end,
        GetNumTradeSkills = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumTradeSkills)
          end
          return checkCFunc(_G.GetNumTradeSkills)
        end,
        GetNumTrainerServices = function()
          return checkCFunc(_G.GetNumTrainerServices)
        end,
        GetNumTreasurePickerItems = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumTreasurePickerItems)
          end
          return checkCFunc(_G.GetNumTreasurePickerItems)
        end,
        GetNumUnspentPvpTalents = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumUnspentPvpTalents)
          end
          return checkCFunc(_G.GetNumUnspentPvpTalents)
        end,
        GetNumUnspentTalents = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumUnspentTalents)
          end
          return checkCFunc(_G.GetNumUnspentTalents)
        end,
        GetNumVoidTransferDeposit = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumVoidTransferDeposit)
          end
          return checkCFunc(_G.GetNumVoidTransferDeposit)
        end,
        GetNumVoidTransferWithdrawal = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumVoidTransferWithdrawal)
          end
          return checkCFunc(_G.GetNumVoidTransferWithdrawal)
        end,
        GetNumWarGameTypes = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumWarGameTypes)
          end
          return checkCFunc(_G.GetNumWarGameTypes)
        end,
        GetNumWorldPVPAreas = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetNumWorldPVPAreas)
          end
          return checkCFunc(_G.GetNumWorldPVPAreas)
        end,
        GetOSLocale = function()
          return checkCFunc(_G.GetOSLocale)
        end,
        GetObjectIconTextureCoords = function()
          return checkCFunc(_G.GetObjectIconTextureCoords)
        end,
        GetObjectiveText = function()
          return checkCFunc(_G.GetObjectiveText)
        end,
        GetOptOutOfLoot = function()
          return checkCFunc(_G.GetOptOutOfLoot)
        end,
        GetOverrideAPBySpellPower = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetOverrideAPBySpellPower)
          end
          return checkCFunc(_G.GetOverrideAPBySpellPower)
        end,
        GetOverrideBarIndex = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetOverrideBarIndex)
          end
          return checkCFunc(_G.GetOverrideBarIndex)
        end,
        GetOverrideBarSkin = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetOverrideBarSkin)
          end
          return checkCFunc(_G.GetOverrideBarSkin)
        end,
        GetOverrideSpellPowerByAP = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetOverrideSpellPowerByAP)
          end
          return checkCFunc(_G.GetOverrideSpellPowerByAP)
        end,
        GetOwnerAuctionItems = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetOwnerAuctionItems)
          end
          return checkCFunc(_G.GetOwnerAuctionItems)
        end,
        GetPOITextureCoords = function()
          return checkCFunc(_G.GetPOITextureCoords)
        end,
        GetPVPDesired = function()
          return checkCFunc(_G.GetPVPDesired)
        end,
        GetPVPGearStatRules = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPVPGearStatRules)
          end
          return checkCFunc(_G.GetPVPGearStatRules)
        end,
        GetPVPLastWeekStats = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPVPLastWeekStats)
          end
          return checkCFunc(_G.GetPVPLastWeekStats)
        end,
        GetPVPLifetimeStats = function()
          return checkCFunc(_G.GetPVPLifetimeStats)
        end,
        GetPVPRankInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPVPRankInfo)
          end
          return checkCFunc(_G.GetPVPRankInfo)
        end,
        GetPVPRankProgress = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPVPRankProgress)
          end
          return checkCFunc(_G.GetPVPRankProgress)
        end,
        GetPVPRoles = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPVPRoles)
          end
          return checkCFunc(_G.GetPVPRoles)
        end,
        GetPVPSessionStats = function()
          return checkCFunc(_G.GetPVPSessionStats)
        end,
        GetPVPThisWeekStats = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPVPThisWeekStats)
          end
          return checkCFunc(_G.GetPVPThisWeekStats)
        end,
        GetPVPTimer = function()
          return checkCFunc(_G.GetPVPTimer)
        end,
        GetPVPYesterdayStats = function()
          return checkCFunc(_G.GetPVPYesterdayStats)
        end,
        GetParryChance = function()
          return checkCFunc(_G.GetParryChance)
        end,
        GetParryChanceFromAttribute = function()
          return checkCFunc(_G.GetParryChanceFromAttribute)
        end,
        GetPartyAssignment = function()
          return checkCFunc(_G.GetPartyAssignment)
        end,
        GetPartyLFGBackfillInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPartyLFGBackfillInfo)
          end
          return checkCFunc(_G.GetPartyLFGBackfillInfo)
        end,
        GetPartyLFGID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPartyLFGID)
          end
          return checkCFunc(_G.GetPartyLFGID)
        end,
        GetPendingGlyphName = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPendingGlyphName)
          end
          return checkCFunc(_G.GetPendingGlyphName)
        end,
        GetPendingInviteConfirmations = function()
          return checkCFunc(_G.GetPendingInviteConfirmations)
        end,
        GetPersonalRatedInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPersonalRatedInfo)
          end
          return checkCFunc(_G.GetPersonalRatedInfo)
        end,
        GetPetActionCooldown = function()
          return checkCFunc(_G.GetPetActionCooldown)
        end,
        GetPetActionInfo = function()
          return checkCFunc(_G.GetPetActionInfo)
        end,
        GetPetActionSlotUsable = function()
          return checkCFunc(_G.GetPetActionSlotUsable)
        end,
        GetPetActionsUsable = function()
          return checkCFunc(_G.GetPetActionsUsable)
        end,
        GetPetExperience = function()
          return checkCFunc(_G.GetPetExperience)
        end,
        GetPetFoodTypes = function()
          return checkCFunc(_G.GetPetFoodTypes)
        end,
        GetPetHappiness = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPetHappiness)
          end
          return checkCFunc(_G.GetPetHappiness)
        end,
        GetPetIcon = function()
          return checkCFunc(_G.GetPetIcon)
        end,
        GetPetLoyalty = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPetLoyalty)
          end
          return checkCFunc(_G.GetPetLoyalty)
        end,
        GetPetMeleeHaste = function()
          return checkCFunc(_G.GetPetMeleeHaste)
        end,
        GetPetSpellBonusDamage = function()
          return checkCFunc(_G.GetPetSpellBonusDamage)
        end,
        GetPetTalentTree = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPetTalentTree)
          end
          return checkCFunc(_G.GetPetTalentTree)
        end,
        GetPetTimeRemaining = function()
          return checkCFunc(_G.GetPetTimeRemaining)
        end,
        GetPetTrainingPoints = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPetTrainingPoints)
          end
          return checkCFunc(_G.GetPetTrainingPoints)
        end,
        GetPetitionInfo = function()
          return checkCFunc(_G.GetPetitionInfo)
        end,
        GetPetitionItemPrice = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPetitionItemPrice)
          end
          return checkCFunc(_G.GetPetitionItemPrice)
        end,
        GetPetitionNameInfo = function()
          return checkCFunc(_G.GetPetitionNameInfo)
        end,
        GetPhysicalScreenSize = function()
          return checkCFunc(_G.GetPhysicalScreenSize)
        end,
        GetPlayerAuraBySpellID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPlayerAuraBySpellID)
          end
          return checkCFunc(_G.GetPlayerAuraBySpellID)
        end,
        GetPlayerFacing = function()
          return checkCFunc(_G.GetPlayerFacing)
        end,
        GetPlayerInfoByGUID = function()
          return checkCFunc(_G.GetPlayerInfoByGUID)
        end,
        GetPlayerTradeCurrency = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPlayerTradeCurrency)
          end
          return checkCFunc(_G.GetPlayerTradeCurrency)
        end,
        GetPlayerTradeMoney = function()
          return checkCFunc(_G.GetPlayerTradeMoney)
        end,
        GetPossessInfo = function()
          return checkCFunc(_G.GetPossessInfo)
        end,
        GetPowerRegen = function()
          return checkCFunc(_G.GetPowerRegen)
        end,
        GetPowerRegenForPowerType = function()
          return checkCFunc(_G.GetPowerRegenForPowerType)
        end,
        GetPrevCompleatedTutorial = function()
          return checkCFunc(_G.GetPrevCompleatedTutorial)
        end,
        GetPreviousAchievement = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPreviousAchievement)
          end
          return checkCFunc(_G.GetPreviousAchievement)
        end,
        GetPreviousArenaSeason = function()
          return checkCFunc(_G.GetPreviousArenaSeason)
        end,
        GetPrimarySpecialization = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPrimarySpecialization)
          end
          return checkCFunc(_G.GetPrimarySpecialization)
        end,
        GetProfessionInfo = function()
          return checkCFunc(_G.GetProfessionInfo)
        end,
        GetProfessions = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetProfessions)
          end
          return checkCFunc(_G.GetProfessions)
        end,
        GetProgressText = function()
          return checkCFunc(_G.GetProgressText)
        end,
        GetPromotionRank = function()
          return checkCFunc(_G.GetPromotionRank)
        end,
        GetPvpPowerDamage = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPvpPowerDamage)
          end
          return checkCFunc(_G.GetPvpPowerDamage)
        end,
        GetPvpPowerHealing = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPvpPowerHealing)
          end
          return checkCFunc(_G.GetPvpPowerHealing)
        end,
        GetPvpTalentInfoByID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPvpTalentInfoByID)
          end
          return checkCFunc(_G.GetPvpTalentInfoByID)
        end,
        GetPvpTalentInfoBySpecialization = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPvpTalentInfoBySpecialization)
          end
          return checkCFunc(_G.GetPvpTalentInfoBySpecialization)
        end,
        GetPvpTalentLink = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetPvpTalentLink)
          end
          return checkCFunc(_G.GetPvpTalentLink)
        end,
        GetQuestBackgroundMaterial = function()
          return checkCFunc(_G.GetQuestBackgroundMaterial)
        end,
        GetQuestCurrencyID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestCurrencyID)
          end
          return checkCFunc(_G.GetQuestCurrencyID)
        end,
        GetQuestCurrencyInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestCurrencyInfo)
          end
          return checkCFunc(_G.GetQuestCurrencyInfo)
        end,
        GetQuestExpansion = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestExpansion)
          end
          return checkCFunc(_G.GetQuestExpansion)
        end,
        GetQuestFactionGroup = function()
          return checkCFunc(_G.GetQuestFactionGroup)
        end,
        GetQuestGreenRange = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestGreenRange)
          end
          return checkCFunc(_G.GetQuestGreenRange)
        end,
        GetQuestID = function()
          return checkCFunc(_G.GetQuestID)
        end,
        GetQuestIndexForTimer = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestIndexForTimer)
          end
          return checkCFunc(_G.GetQuestIndexForTimer)
        end,
        GetQuestIndexForWatch = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestIndexForWatch)
          end
          return checkCFunc(_G.GetQuestIndexForWatch)
        end,
        GetQuestItemInfo = function()
          return checkCFunc(_G.GetQuestItemInfo)
        end,
        GetQuestItemInfoLootType = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestItemInfoLootType)
          end
          return checkCFunc(_G.GetQuestItemInfoLootType)
        end,
        GetQuestItemLink = function()
          return checkCFunc(_G.GetQuestItemLink)
        end,
        GetQuestLink = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLink)
          end
          return checkCFunc(_G.GetQuestLink)
        end,
        GetQuestLogChoiceInfo = function()
          return checkCFunc(_G.GetQuestLogChoiceInfo)
        end,
        GetQuestLogChoiceInfoLootType = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogChoiceInfoLootType)
          end
          return checkCFunc(_G.GetQuestLogChoiceInfoLootType)
        end,
        GetQuestLogCompletionText = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogCompletionText)
          end
          return checkCFunc(_G.GetQuestLogCompletionText)
        end,
        GetQuestLogCriteriaSpell = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogCriteriaSpell)
          end
          return checkCFunc(_G.GetQuestLogCriteriaSpell)
        end,
        GetQuestLogGroupNum = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogGroupNum)
          end
          return checkCFunc(_G.GetQuestLogGroupNum)
        end,
        GetQuestLogIndexByID = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogIndexByID)
          end
          return checkCFunc(_G.GetQuestLogIndexByID)
        end,
        GetQuestLogItemDrop = function()
          return checkCFunc(_G.GetQuestLogItemDrop)
        end,
        GetQuestLogItemLink = function()
          return checkCFunc(_G.GetQuestLogItemLink)
        end,
        GetQuestLogLeaderBoard = function()
          return checkCFunc(_G.GetQuestLogLeaderBoard)
        end,
        GetQuestLogPortraitTurnIn = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogPortraitTurnIn)
          end
          return checkCFunc(_G.GetQuestLogPortraitTurnIn)
        end,
        GetQuestLogPushable = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogPushable)
          end
          return checkCFunc(_G.GetQuestLogPushable)
        end,
        GetQuestLogQuestText = function()
          return checkCFunc(_G.GetQuestLogQuestText)
        end,
        GetQuestLogQuestType = function()
          return checkCFunc(_G.GetQuestLogQuestType)
        end,
        GetQuestLogRequiredMoney = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogRequiredMoney)
          end
          return checkCFunc(_G.GetQuestLogRequiredMoney)
        end,
        GetQuestLogRewardArtifactXP = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogRewardArtifactXP)
          end
          return checkCFunc(_G.GetQuestLogRewardArtifactXP)
        end,
        GetQuestLogRewardCurrencyInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogRewardCurrencyInfo)
          end
          return checkCFunc(_G.GetQuestLogRewardCurrencyInfo)
        end,
        GetQuestLogRewardFactionInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogRewardFactionInfo)
          end
          return checkCFunc(_G.GetQuestLogRewardFactionInfo)
        end,
        GetQuestLogRewardHonor = function()
          return checkCFunc(_G.GetQuestLogRewardHonor)
        end,
        GetQuestLogRewardInfo = function()
          return checkCFunc(_G.GetQuestLogRewardInfo)
        end,
        GetQuestLogRewardMoney = function()
          return checkCFunc(_G.GetQuestLogRewardMoney)
        end,
        GetQuestLogRewardSkillPoints = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogRewardSkillPoints)
          end
          return checkCFunc(_G.GetQuestLogRewardSkillPoints)
        end,
        GetQuestLogRewardSpell = function()
          return checkCFunc(_G.GetQuestLogRewardSpell)
        end,
        GetQuestLogRewardTitle = function()
          return checkCFunc(_G.GetQuestLogRewardTitle)
        end,
        GetQuestLogRewardXP = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogRewardXP)
          end
          return checkCFunc(_G.GetQuestLogRewardXP)
        end,
        GetQuestLogSelection = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogSelection)
          end
          return checkCFunc(_G.GetQuestLogSelection)
        end,
        GetQuestLogSpecialItemCooldown = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogSpecialItemCooldown)
          end
          return checkCFunc(_G.GetQuestLogSpecialItemCooldown)
        end,
        GetQuestLogSpecialItemInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogSpecialItemInfo)
          end
          return checkCFunc(_G.GetQuestLogSpecialItemInfo)
        end,
        GetQuestLogSpellLink = function()
          return checkCFunc(_G.GetQuestLogSpellLink)
        end,
        GetQuestLogTimeLeft = function()
          return checkCFunc(_G.GetQuestLogTimeLeft)
        end,
        GetQuestLogTitle = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestLogTitle)
          end
          return checkCFunc(_G.GetQuestLogTitle)
        end,
        GetQuestMoneyToGet = function()
          return checkCFunc(_G.GetQuestMoneyToGet)
        end,
        GetQuestObjectiveInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestObjectiveInfo)
          end
          return checkCFunc(_G.GetQuestObjectiveInfo)
        end,
        GetQuestPOIBlobCount = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestPOIBlobCount)
          end
          return checkCFunc(_G.GetQuestPOIBlobCount)
        end,
        GetQuestPOILeaderBoard = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestPOILeaderBoard)
          end
          return checkCFunc(_G.GetQuestPOILeaderBoard)
        end,
        GetQuestPOIs = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestPOIs)
          end
          return checkCFunc(_G.GetQuestPOIs)
        end,
        GetQuestPortraitGiver = function()
          return checkCFunc(_G.GetQuestPortraitGiver)
        end,
        GetQuestPortraitTurnIn = function()
          return checkCFunc(_G.GetQuestPortraitTurnIn)
        end,
        GetQuestProgressBarPercent = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestProgressBarPercent)
          end
          return checkCFunc(_G.GetQuestProgressBarPercent)
        end,
        GetQuestResetTime = function()
          return checkCFunc(_G.GetQuestResetTime)
        end,
        GetQuestReward = function()
          return checkCFunc(_G.GetQuestReward)
        end,
        GetQuestSortIndex = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestSortIndex)
          end
          return checkCFunc(_G.GetQuestSortIndex)
        end,
        GetQuestSpellLink = function()
          return checkCFunc(_G.GetQuestSpellLink)
        end,
        GetQuestTagInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestTagInfo)
          end
          return checkCFunc(_G.GetQuestTagInfo)
        end,
        GetQuestText = function()
          return checkCFunc(_G.GetQuestText)
        end,
        GetQuestTimers = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestTimers)
          end
          return checkCFunc(_G.GetQuestTimers)
        end,
        GetQuestUiMapID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestUiMapID)
          end
          return checkCFunc(_G.GetQuestUiMapID)
        end,
        GetQuestWatchIndex = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestWatchIndex)
          end
          return checkCFunc(_G.GetQuestWatchIndex)
        end,
        GetQuestWatchInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestWatchInfo)
          end
          return checkCFunc(_G.GetQuestWatchInfo)
        end,
        GetQuestsCompleted = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetQuestsCompleted)
          end
          return checkCFunc(_G.GetQuestsCompleted)
        end,
        GetRFDungeonInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRFDungeonInfo)
          end
          return checkCFunc(_G.GetRFDungeonInfo)
        end,
        GetRaidDifficultyID = function()
          return checkCFunc(_G.GetRaidDifficultyID)
        end,
        GetRaidProfileFlattenedOptions = function()
          return checkCFunc(_G.GetRaidProfileFlattenedOptions)
        end,
        GetRaidProfileName = function()
          return checkCFunc(_G.GetRaidProfileName)
        end,
        GetRaidProfileOption = function()
          return checkCFunc(_G.GetRaidProfileOption)
        end,
        GetRaidProfileSavedPosition = function()
          return checkCFunc(_G.GetRaidProfileSavedPosition)
        end,
        GetRaidRosterInfo = function()
          return checkCFunc(_G.GetRaidRosterInfo)
        end,
        GetRaidTargetIndex = function()
          return checkCFunc(_G.GetRaidTargetIndex)
        end,
        GetRandomDungeonBestChoice = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRandomDungeonBestChoice)
          end
          return checkCFunc(_G.GetRandomDungeonBestChoice)
        end,
        GetRandomScenarioBestChoice = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRandomScenarioBestChoice)
          end
          return checkCFunc(_G.GetRandomScenarioBestChoice)
        end,
        GetRandomScenarioInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRandomScenarioInfo)
          end
          return checkCFunc(_G.GetRandomScenarioInfo)
        end,
        GetRangedCritChance = function()
          return checkCFunc(_G.GetRangedCritChance)
        end,
        GetRangedHaste = function()
          return checkCFunc(_G.GetRangedHaste)
        end,
        GetRatedBattleGroundInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRatedBattleGroundInfo)
          end
          return checkCFunc(_G.GetRatedBattleGroundInfo)
        end,
        GetReadyCheckStatus = function()
          return checkCFunc(_G.GetReadyCheckStatus)
        end,
        GetReadyCheckTimeLeft = function()
          return checkCFunc(_G.GetReadyCheckTimeLeft)
        end,
        GetReagentBankCost = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetReagentBankCost)
          end
          return checkCFunc(_G.GetReagentBankCost)
        end,
        GetRealZoneText = function()
          return checkCFunc(_G.GetRealZoneText)
        end,
        GetRealmID = function()
          return checkCFunc(_G.GetRealmID)
        end,
        GetRealmName = function()
          return checkCFunc(_G.GetRealmName)
        end,
        GetReleaseTimeRemaining = function()
          return checkCFunc(_G.GetReleaseTimeRemaining)
        end,
        GetRepairAllCost = function()
          return checkCFunc(_G.GetRepairAllCost)
        end,
        GetResSicknessDuration = function()
          return checkCFunc(_G.GetResSicknessDuration)
        end,
        GetRestState = function()
          return checkCFunc(_G.GetRestState)
        end,
        GetRestrictedAccountData = function()
          return checkCFunc(_G.GetRestrictedAccountData)
        end,
        GetRewardArtifactXP = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRewardArtifactXP)
          end
          return checkCFunc(_G.GetRewardArtifactXP)
        end,
        GetRewardHonor = function()
          return checkCFunc(_G.GetRewardHonor)
        end,
        GetRewardMoney = function()
          return checkCFunc(_G.GetRewardMoney)
        end,
        GetRewardNumSkillUps = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRewardNumSkillUps)
          end
          return checkCFunc(_G.GetRewardNumSkillUps)
        end,
        GetRewardPackArtifactPower = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRewardPackArtifactPower)
          end
          return checkCFunc(_G.GetRewardPackArtifactPower)
        end,
        GetRewardPackCurrencies = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRewardPackCurrencies)
          end
          return checkCFunc(_G.GetRewardPackCurrencies)
        end,
        GetRewardPackItems = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRewardPackItems)
          end
          return checkCFunc(_G.GetRewardPackItems)
        end,
        GetRewardPackMoney = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRewardPackMoney)
          end
          return checkCFunc(_G.GetRewardPackMoney)
        end,
        GetRewardPackTitle = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRewardPackTitle)
          end
          return checkCFunc(_G.GetRewardPackTitle)
        end,
        GetRewardPackTitleName = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRewardPackTitleName)
          end
          return checkCFunc(_G.GetRewardPackTitleName)
        end,
        GetRewardSkillLineID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRewardSkillLineID)
          end
          return checkCFunc(_G.GetRewardSkillLineID)
        end,
        GetRewardSkillPoints = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRewardSkillPoints)
          end
          return checkCFunc(_G.GetRewardSkillPoints)
        end,
        GetRewardSpell = function()
          return checkCFunc(_G.GetRewardSpell)
        end,
        GetRewardText = function()
          return checkCFunc(_G.GetRewardText)
        end,
        GetRewardTitle = function()
          return checkCFunc(_G.GetRewardTitle)
        end,
        GetRewardXP = function()
          return checkCFunc(_G.GetRewardXP)
        end,
        GetRuneCooldown = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRuneCooldown)
          end
          return checkCFunc(_G.GetRuneCooldown)
        end,
        GetRuneCount = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetRuneCount)
          end
          return checkCFunc(_G.GetRuneCount)
        end,
        GetRunningMacro = function()
          return checkCFunc(_G.GetRunningMacro)
        end,
        GetRunningMacroButton = function()
          return checkCFunc(_G.GetRunningMacroButton)
        end,
        GetSavedInstanceChatLink = function()
          return checkCFunc(_G.GetSavedInstanceChatLink)
        end,
        GetSavedInstanceEncounterInfo = function()
          return checkCFunc(_G.GetSavedInstanceEncounterInfo)
        end,
        GetSavedInstanceInfo = function()
          return checkCFunc(_G.GetSavedInstanceInfo)
        end,
        GetSavedWorldBossInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSavedWorldBossInfo)
          end
          return checkCFunc(_G.GetSavedWorldBossInfo)
        end,
        GetScenariosChoiceOrder = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetScenariosChoiceOrder)
          end
          return checkCFunc(_G.GetScenariosChoiceOrder)
        end,
        GetSchoolString = function()
          return checkCFunc(_G.GetSchoolString)
        end,
        GetScreenDPIScale = function()
          return checkCFunc(_G.GetScreenDPIScale)
        end,
        GetScreenHeight = function()
          return checkCFunc(_G.GetScreenHeight)
        end,
        GetScreenResolutions = function()
          return checkCFunc(_G.GetScreenResolutions)
        end,
        GetScreenWidth = function()
          return checkCFunc(_G.GetScreenWidth)
        end,
        GetScriptCPUUsage = function()
          return checkCFunc(_G.GetScriptCPUUsage)
        end,
        GetSecondsUntilParentalControlsKick = function()
          return checkCFunc(_G.GetSecondsUntilParentalControlsKick)
        end,
        GetSelectedArtifactInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSelectedArtifactInfo)
          end
          return checkCFunc(_G.GetSelectedArtifactInfo)
        end,
        GetSelectedAuctionItem = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSelectedAuctionItem)
          end
          return checkCFunc(_G.GetSelectedAuctionItem)
        end,
        GetSelectedBattlefield = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSelectedBattlefield)
          end
          return checkCFunc(_G.GetSelectedBattlefield)
        end,
        GetSelectedDisplayChannel = function()
          return checkCFunc(_G.GetSelectedDisplayChannel)
        end,
        GetSelectedFaction = function()
          return checkCFunc(_G.GetSelectedFaction)
        end,
        GetSelectedSkill = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSelectedSkill)
          end
          return checkCFunc(_G.GetSelectedSkill)
        end,
        GetSelectedStablePet = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSelectedStablePet)
          end
          return checkCFunc(_G.GetSelectedStablePet)
        end,
        GetSelectedWarGameType = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSelectedWarGameType)
          end
          return checkCFunc(_G.GetSelectedWarGameType)
        end,
        GetSendMailCOD = function()
          return checkCFunc(_G.GetSendMailCOD)
        end,
        GetSendMailItem = function()
          return checkCFunc(_G.GetSendMailItem)
        end,
        GetSendMailItemLink = function()
          return checkCFunc(_G.GetSendMailItemLink)
        end,
        GetSendMailMoney = function()
          return checkCFunc(_G.GetSendMailMoney)
        end,
        GetSendMailPrice = function()
          return checkCFunc(_G.GetSendMailPrice)
        end,
        GetServerExpansionLevel = function()
          return checkCFunc(_G.GetServerExpansionLevel)
        end,
        GetServerTime = function()
          return checkCFunc(_G.GetServerTime)
        end,
        GetSessionTime = function()
          return checkCFunc(_G.GetSessionTime)
        end,
        GetSetBonusesForSpecializationByItemID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSetBonusesForSpecializationByItemID)
          end
          return checkCFunc(_G.GetSetBonusesForSpecializationByItemID)
        end,
        GetShapeshiftForm = function()
          return checkCFunc(_G.GetShapeshiftForm)
        end,
        GetShapeshiftFormCooldown = function()
          return checkCFunc(_G.GetShapeshiftFormCooldown)
        end,
        GetShapeshiftFormID = function()
          return checkCFunc(_G.GetShapeshiftFormID)
        end,
        GetShapeshiftFormInfo = function()
          return checkCFunc(_G.GetShapeshiftFormInfo)
        end,
        GetSheathState = function()
          return checkCFunc(_G.GetSheathState)
        end,
        GetShieldBlock = function()
          return checkCFunc(_G.GetShieldBlock)
        end,
        GetSkillLineInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSkillLineInfo)
          end
          return checkCFunc(_G.GetSkillLineInfo)
        end,
        GetSocketItemBoundTradeable = function()
          return checkCFunc(_G.GetSocketItemBoundTradeable)
        end,
        GetSocketItemInfo = function()
          return checkCFunc(_G.GetSocketItemInfo)
        end,
        GetSocketItemRefundable = function()
          return checkCFunc(_G.GetSocketItemRefundable)
        end,
        GetSocketTypes = function()
          return checkCFunc(_G.GetSocketTypes)
        end,
        GetSortBagsRightToLeft = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSortBagsRightToLeft)
          end
          return checkCFunc(_G.GetSortBagsRightToLeft)
        end,
        GetSpecChangeCost = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecChangeCost)
          end
          return checkCFunc(_G.GetSpecChangeCost)
        end,
        GetSpecialization = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecialization)
          end
          return checkCFunc(_G.GetSpecialization)
        end,
        GetSpecializationInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecializationInfo)
          end
          return checkCFunc(_G.GetSpecializationInfo)
        end,
        GetSpecializationInfoByID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecializationInfoByID)
          end
          return checkCFunc(_G.GetSpecializationInfoByID)
        end,
        GetSpecializationInfoForClassID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecializationInfoForClassID)
          end
          return checkCFunc(_G.GetSpecializationInfoForClassID)
        end,
        GetSpecializationInfoForSpecID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecializationInfoForSpecID)
          end
          return checkCFunc(_G.GetSpecializationInfoForSpecID)
        end,
        GetSpecializationMasterySpells = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecializationMasterySpells)
          end
          return checkCFunc(_G.GetSpecializationMasterySpells)
        end,
        GetSpecializationNameForSpecID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecializationNameForSpecID)
          end
          return checkCFunc(_G.GetSpecializationNameForSpecID)
        end,
        GetSpecializationRole = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecializationRole)
          end
          return checkCFunc(_G.GetSpecializationRole)
        end,
        GetSpecializationRoleByID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecializationRoleByID)
          end
          return checkCFunc(_G.GetSpecializationRoleByID)
        end,
        GetSpecializationSpells = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecializationSpells)
          end
          return checkCFunc(_G.GetSpecializationSpells)
        end,
        GetSpecsForSpell = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpecsForSpell)
          end
          return checkCFunc(_G.GetSpecsForSpell)
        end,
        GetSpeed = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpeed)
          end
          return checkCFunc(_G.GetSpeed)
        end,
        GetSpellAutocast = function()
          return checkCFunc(_G.GetSpellAutocast)
        end,
        GetSpellAvailableLevel = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpellAvailableLevel)
          end
          return checkCFunc(_G.GetSpellAvailableLevel)
        end,
        GetSpellBaseCooldown = function()
          return checkCFunc(_G.GetSpellBaseCooldown)
        end,
        GetSpellBonusDamage = function()
          return checkCFunc(_G.GetSpellBonusDamage)
        end,
        GetSpellBonusHealing = function()
          return checkCFunc(_G.GetSpellBonusHealing)
        end,
        GetSpellBookItemInfo = function()
          return checkCFunc(_G.GetSpellBookItemInfo)
        end,
        GetSpellBookItemName = function()
          return checkCFunc(_G.GetSpellBookItemName)
        end,
        GetSpellBookItemTexture = function()
          return checkCFunc(_G.GetSpellBookItemTexture)
        end,
        GetSpellCharges = function()
          return checkCFunc(_G.GetSpellCharges)
        end,
        GetSpellConfirmationPromptsInfo = function()
          return checkCFunc(_G.GetSpellConfirmationPromptsInfo)
        end,
        GetSpellCooldown = function()
          return checkCFunc(_G.GetSpellCooldown)
        end,
        GetSpellCount = function()
          return checkCFunc(_G.GetSpellCount)
        end,
        GetSpellCritChance = function()
          return checkCFunc(_G.GetSpellCritChance)
        end,
        GetSpellCritChanceFromIntellect = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpellCritChanceFromIntellect)
          end
          return checkCFunc(_G.GetSpellCritChanceFromIntellect)
        end,
        GetSpellDescription = function()
          return checkCFunc(_G.GetSpellDescription)
        end,
        GetSpellHitModifier = function()
          return checkCFunc(_G.GetSpellHitModifier)
        end,
        GetSpellInfo = function()
          return checkCFunc(_G.GetSpellInfo)
        end,
        GetSpellLevelLearned = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpellLevelLearned)
          end
          return checkCFunc(_G.GetSpellLevelLearned)
        end,
        GetSpellLink = function()
          return checkCFunc(_G.GetSpellLink)
        end,
        GetSpellLossOfControlCooldown = function()
          return checkCFunc(_G.GetSpellLossOfControlCooldown)
        end,
        GetSpellPenetration = function()
          return checkCFunc(_G.GetSpellPenetration)
        end,
        GetSpellPowerCost = function()
          return checkCFunc(_G.GetSpellPowerCost)
        end,
        GetSpellQueueWindow = function()
          return checkCFunc(_G.GetSpellQueueWindow)
        end,
        GetSpellRank = function()
          return checkCFunc(_G.GetSpellRank)
        end,
        GetSpellSubtext = function()
          return checkCFunc(_G.GetSpellSubtext)
        end,
        GetSpellTabInfo = function()
          return checkCFunc(_G.GetSpellTabInfo)
        end,
        GetSpellTexture = function()
          return checkCFunc(_G.GetSpellTexture)
        end,
        GetSpellTradeSkillLink = function()
          return checkCFunc(_G.GetSpellTradeSkillLink)
        end,
        GetSpellsForCharacterUpgradeTier = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSpellsForCharacterUpgradeTier)
          end
          return checkCFunc(_G.GetSpellsForCharacterUpgradeTier)
        end,
        GetStablePetFoodTypes = function()
          return checkCFunc(_G.GetStablePetFoodTypes)
        end,
        GetStablePetInfo = function()
          return checkCFunc(_G.GetStablePetInfo)
        end,
        GetStatistic = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetStatistic)
          end
          return checkCFunc(_G.GetStatistic)
        end,
        GetStatisticsCategoryList = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetStatisticsCategoryList)
          end
          return checkCFunc(_G.GetStatisticsCategoryList)
        end,
        GetSturdiness = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSturdiness)
          end
          return checkCFunc(_G.GetSturdiness)
        end,
        GetSubZoneText = function()
          return checkCFunc(_G.GetSubZoneText)
        end,
        GetSuggestedGroupNum = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSuggestedGroupNum)
          end
          return checkCFunc(_G.GetSuggestedGroupNum)
        end,
        GetSuggestedGroupSize = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSuggestedGroupSize)
          end
          return checkCFunc(_G.GetSuggestedGroupSize)
        end,
        GetSummonFriendCooldown = function()
          return checkCFunc(_G.GetSummonFriendCooldown)
        end,
        GetSuperTrackedQuestID = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetSuperTrackedQuestID)
          end
          return checkCFunc(_G.GetSuperTrackedQuestID)
        end,
        GetTabardCreationCost = function()
          return checkCFunc(_G.GetTabardCreationCost)
        end,
        GetTabardInfo = function()
          return checkCFunc(_G.GetTabardInfo)
        end,
        GetTalentInfo = function()
          return checkCFunc(_G.GetTalentInfo)
        end,
        GetTalentInfoByID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTalentInfoByID)
          end
          return checkCFunc(_G.GetTalentInfoByID)
        end,
        GetTalentInfoBySpecialization = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTalentInfoBySpecialization)
          end
          return checkCFunc(_G.GetTalentInfoBySpecialization)
        end,
        GetTalentLink = function()
          return checkCFunc(_G.GetTalentLink)
        end,
        GetTalentPrereqs = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTalentPrereqs)
          end
          return checkCFunc(_G.GetTalentPrereqs)
        end,
        GetTalentTabInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTalentTabInfo)
          end
          return checkCFunc(_G.GetTalentTabInfo)
        end,
        GetTalentTierInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTalentTierInfo)
          end
          return checkCFunc(_G.GetTalentTierInfo)
        end,
        GetTargetTradeCurrency = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTargetTradeCurrency)
          end
          return checkCFunc(_G.GetTargetTradeCurrency)
        end,
        GetTargetTradeMoney = function()
          return checkCFunc(_G.GetTargetTradeMoney)
        end,
        GetTaskInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTaskInfo)
          end
          return checkCFunc(_G.GetTaskInfo)
        end,
        GetTaskPOIs = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTaskPOIs)
          end
          return checkCFunc(_G.GetTaskPOIs)
        end,
        GetTasksTable = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTasksTable)
          end
          return checkCFunc(_G.GetTasksTable)
        end,
        GetTaxiBenchmarkMode = function()
          return checkCFunc(_G.GetTaxiBenchmarkMode)
        end,
        GetTaxiMapID = function()
          return checkCFunc(_G.GetTaxiMapID)
        end,
        GetTempShapeshiftBarIndex = function()
          return checkCFunc(_G.GetTempShapeshiftBarIndex)
        end,
        GetText = function()
          return checkCFunc(_G.GetText)
        end,
        GetThreatStatusColor = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetThreatStatusColor)
          end
          return checkCFunc(_G.GetThreatStatusColor)
        end,
        GetTickTime = function()
          return checkCFunc(_G.GetTickTime)
        end,
        GetTime = function()
          return checkCFunc(_G.GetTime)
        end,
        GetTimePreciseSec = function()
          return checkCFunc(_G.GetTimePreciseSec)
        end,
        GetTimeToWellRested = function()
          return checkCFunc(_G.GetTimeToWellRested)
        end,
        GetTitleName = function()
          return checkCFunc(_G.GetTitleName)
        end,
        GetTitleText = function()
          return checkCFunc(_G.GetTitleText)
        end,
        GetToolTipInfo = function()
          return checkCFunc(_G.GetToolTipInfo)
        end,
        GetTotalAchievementPoints = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTotalAchievementPoints)
          end
          return checkCFunc(_G.GetTotalAchievementPoints)
        end,
        GetTotemCannotDismiss = function()
          return checkCFunc(_G.GetTotemCannotDismiss)
        end,
        GetTotemInfo = function()
          return checkCFunc(_G.GetTotemInfo)
        end,
        GetTotemTimeLeft = function()
          return checkCFunc(_G.GetTotemTimeLeft)
        end,
        GetTrackedAchievements = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTrackedAchievements)
          end
          return checkCFunc(_G.GetTrackedAchievements)
        end,
        GetTrackingInfo = function()
          return checkCFunc(_G.GetTrackingInfo)
        end,
        GetTrackingTexture = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTrackingTexture)
          end
          return checkCFunc(_G.GetTrackingTexture)
        end,
        GetTradePlayerItemInfo = function()
          return checkCFunc(_G.GetTradePlayerItemInfo)
        end,
        GetTradePlayerItemLink = function()
          return checkCFunc(_G.GetTradePlayerItemLink)
        end,
        GetTradeSkillCooldown = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillCooldown)
          end
          return checkCFunc(_G.GetTradeSkillCooldown)
        end,
        GetTradeSkillIcon = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillIcon)
          end
          return checkCFunc(_G.GetTradeSkillIcon)
        end,
        GetTradeSkillInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillInfo)
          end
          return checkCFunc(_G.GetTradeSkillInfo)
        end,
        GetTradeSkillInvSlotFilter = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillInvSlotFilter)
          end
          return checkCFunc(_G.GetTradeSkillInvSlotFilter)
        end,
        GetTradeSkillInvSlots = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillInvSlots)
          end
          return checkCFunc(_G.GetTradeSkillInvSlots)
        end,
        GetTradeSkillItemLevelFilter = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillItemLevelFilter)
          end
          return checkCFunc(_G.GetTradeSkillItemLevelFilter)
        end,
        GetTradeSkillItemLink = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillItemLink)
          end
          return checkCFunc(_G.GetTradeSkillItemLink)
        end,
        GetTradeSkillItemNameFilter = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillItemNameFilter)
          end
          return checkCFunc(_G.GetTradeSkillItemNameFilter)
        end,
        GetTradeSkillItemStats = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillItemStats)
          end
          return checkCFunc(_G.GetTradeSkillItemStats)
        end,
        GetTradeSkillLine = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillLine)
          end
          return checkCFunc(_G.GetTradeSkillLine)
        end,
        GetTradeSkillNumMade = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillNumMade)
          end
          return checkCFunc(_G.GetTradeSkillNumMade)
        end,
        GetTradeSkillNumReagents = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillNumReagents)
          end
          return checkCFunc(_G.GetTradeSkillNumReagents)
        end,
        GetTradeSkillReagentInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillReagentInfo)
          end
          return checkCFunc(_G.GetTradeSkillReagentInfo)
        end,
        GetTradeSkillReagentItemLink = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillReagentItemLink)
          end
          return checkCFunc(_G.GetTradeSkillReagentItemLink)
        end,
        GetTradeSkillRecipeLink = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillRecipeLink)
          end
          return checkCFunc(_G.GetTradeSkillRecipeLink)
        end,
        GetTradeSkillSelectionIndex = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillSelectionIndex)
          end
          return checkCFunc(_G.GetTradeSkillSelectionIndex)
        end,
        GetTradeSkillSubClassFilter = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillSubClassFilter)
          end
          return checkCFunc(_G.GetTradeSkillSubClassFilter)
        end,
        GetTradeSkillSubClasses = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillSubClasses)
          end
          return checkCFunc(_G.GetTradeSkillSubClasses)
        end,
        GetTradeSkillTools = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeSkillTools)
          end
          return checkCFunc(_G.GetTradeSkillTools)
        end,
        GetTradeTargetItemInfo = function()
          return checkCFunc(_G.GetTradeTargetItemInfo)
        end,
        GetTradeTargetItemLink = function()
          return checkCFunc(_G.GetTradeTargetItemLink)
        end,
        GetTradeskillRepeatCount = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTradeskillRepeatCount)
          end
          return checkCFunc(_G.GetTradeskillRepeatCount)
        end,
        GetTrainerGreetingText = function()
          return checkCFunc(_G.GetTrainerGreetingText)
        end,
        GetTrainerSelectionIndex = function()
          return checkCFunc(_G.GetTrainerSelectionIndex)
        end,
        GetTrainerServiceAbilityReq = function()
          return checkCFunc(_G.GetTrainerServiceAbilityReq)
        end,
        GetTrainerServiceCost = function()
          return checkCFunc(_G.GetTrainerServiceCost)
        end,
        GetTrainerServiceDescription = function()
          return checkCFunc(_G.GetTrainerServiceDescription)
        end,
        GetTrainerServiceIcon = function()
          return checkCFunc(_G.GetTrainerServiceIcon)
        end,
        GetTrainerServiceInfo = function()
          return checkCFunc(_G.GetTrainerServiceInfo)
        end,
        GetTrainerServiceItemLink = function()
          return checkCFunc(_G.GetTrainerServiceItemLink)
        end,
        GetTrainerServiceLevelReq = function()
          return checkCFunc(_G.GetTrainerServiceLevelReq)
        end,
        GetTrainerServiceNumAbilityReq = function()
          return checkCFunc(_G.GetTrainerServiceNumAbilityReq)
        end,
        GetTrainerServiceSkillLine = function()
          return checkCFunc(_G.GetTrainerServiceSkillLine)
        end,
        GetTrainerServiceSkillReq = function()
          return checkCFunc(_G.GetTrainerServiceSkillReq)
        end,
        GetTrainerServiceStepIndex = function()
          return checkCFunc(_G.GetTrainerServiceStepIndex)
        end,
        GetTrainerServiceTypeFilter = function()
          return checkCFunc(_G.GetTrainerServiceTypeFilter)
        end,
        GetTrainerTradeskillRankValues = function()
          return checkCFunc(_G.GetTrainerTradeskillRankValues)
        end,
        GetTreasurePickerItemInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetTreasurePickerItemInfo)
          end
          return checkCFunc(_G.GetTreasurePickerItemInfo)
        end,
        GetTutorialsEnabled = function()
          return checkCFunc(_G.GetTutorialsEnabled)
        end,
        GetUICameraInfo = function()
          return checkCFunc(_G.GetUICameraInfo)
        end,
        GetUITextureKitInfo = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetUITextureKitInfo)
          end
          return checkCFunc(_G.GetUITextureKitInfo)
        end,
        GetUnitChargedPowerPoints = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetUnitChargedPowerPoints)
          end
          return checkCFunc(_G.GetUnitChargedPowerPoints)
        end,
        GetUnitHealthModifier = function()
          return checkCFunc(_G.GetUnitHealthModifier)
        end,
        GetUnitHealthRegenRateFromSpirit = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetUnitHealthRegenRateFromSpirit)
          end
          return checkCFunc(_G.GetUnitHealthRegenRateFromSpirit)
        end,
        GetUnitManaRegenRateFromSpirit = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetUnitManaRegenRateFromSpirit)
          end
          return checkCFunc(_G.GetUnitManaRegenRateFromSpirit)
        end,
        GetUnitMaxHealthModifier = function()
          return checkCFunc(_G.GetUnitMaxHealthModifier)
        end,
        GetUnitPowerBarInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetUnitPowerBarInfo)
          end
          return checkCFunc(_G.GetUnitPowerBarInfo)
        end,
        GetUnitPowerBarInfoByID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetUnitPowerBarInfoByID)
          end
          return checkCFunc(_G.GetUnitPowerBarInfoByID)
        end,
        GetUnitPowerBarStrings = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetUnitPowerBarStrings)
          end
          return checkCFunc(_G.GetUnitPowerBarStrings)
        end,
        GetUnitPowerBarStringsByID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetUnitPowerBarStringsByID)
          end
          return checkCFunc(_G.GetUnitPowerBarStringsByID)
        end,
        GetUnitPowerBarTextureInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetUnitPowerBarTextureInfo)
          end
          return checkCFunc(_G.GetUnitPowerBarTextureInfo)
        end,
        GetUnitPowerBarTextureInfoByID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetUnitPowerBarTextureInfoByID)
          end
          return checkCFunc(_G.GetUnitPowerBarTextureInfoByID)
        end,
        GetUnitPowerModifier = function()
          return checkCFunc(_G.GetUnitPowerModifier)
        end,
        GetUnitSpeed = function()
          return checkCFunc(_G.GetUnitSpeed)
        end,
        GetVehicleBarIndex = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetVehicleBarIndex)
          end
          return checkCFunc(_G.GetVehicleBarIndex)
        end,
        GetVehicleUIIndicator = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetVehicleUIIndicator)
          end
          return checkCFunc(_G.GetVehicleUIIndicator)
        end,
        GetVehicleUIIndicatorSeat = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetVehicleUIIndicatorSeat)
          end
          return checkCFunc(_G.GetVehicleUIIndicatorSeat)
        end,
        GetVersatilityBonus = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetVersatilityBonus)
          end
          return checkCFunc(_G.GetVersatilityBonus)
        end,
        GetVideoCaps = function()
          return checkCFunc(_G.GetVideoCaps)
        end,
        GetVideoOptions = function()
          return checkCFunc(_G.GetVideoOptions)
        end,
        GetVoidItemHyperlinkString = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetVoidItemHyperlinkString)
          end
          return checkCFunc(_G.GetVoidItemHyperlinkString)
        end,
        GetVoidItemInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetVoidItemInfo)
          end
          return checkCFunc(_G.GetVoidItemInfo)
        end,
        GetVoidStorageSlotPageIndex = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetVoidStorageSlotPageIndex)
          end
          return checkCFunc(_G.GetVoidStorageSlotPageIndex)
        end,
        GetVoidTransferCost = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetVoidTransferCost)
          end
          return checkCFunc(_G.GetVoidTransferCost)
        end,
        GetVoidTransferDepositInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetVoidTransferDepositInfo)
          end
          return checkCFunc(_G.GetVoidTransferDepositInfo)
        end,
        GetVoidTransferWithdrawalInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetVoidTransferWithdrawalInfo)
          end
          return checkCFunc(_G.GetVoidTransferWithdrawalInfo)
        end,
        GetVoidUnlockCost = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetVoidUnlockCost)
          end
          return checkCFunc(_G.GetVoidUnlockCost)
        end,
        GetWarGameQueueStatus = function()
          return checkCFunc(_G.GetWarGameQueueStatus)
        end,
        GetWarGameTypeInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetWarGameTypeInfo)
          end
          return checkCFunc(_G.GetWarGameTypeInfo)
        end,
        GetWatchedFactionInfo = function()
          return checkCFunc(_G.GetWatchedFactionInfo)
        end,
        GetWeaponEnchantInfo = function()
          return checkCFunc(_G.GetWeaponEnchantInfo)
        end,
        GetWebTicket = function()
          return checkCFunc(_G.GetWebTicket)
        end,
        GetWorldElapsedTime = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetWorldElapsedTime)
          end
          return checkCFunc(_G.GetWorldElapsedTime)
        end,
        GetWorldElapsedTimers = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetWorldElapsedTimers)
          end
          return checkCFunc(_G.GetWorldElapsedTimers)
        end,
        GetWorldMapActionButtonSpellInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetWorldMapActionButtonSpellInfo)
          end
          return checkCFunc(_G.GetWorldMapActionButtonSpellInfo)
        end,
        GetWorldPVPAreaInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetWorldPVPAreaInfo)
          end
          return checkCFunc(_G.GetWorldPVPAreaInfo)
        end,
        GetWorldPVPQueueStatus = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GetWorldPVPQueueStatus)
          end
          return checkCFunc(_G.GetWorldPVPQueueStatus)
        end,
        GetXPExhaustion = function()
          return checkCFunc(_G.GetXPExhaustion)
        end,
        GetZonePVPInfo = function()
          return checkCFunc(_G.GetZonePVPInfo)
        end,
        GetZoneText = function()
          return checkCFunc(_G.GetZoneText)
        end,
        GiveMasterLoot = function()
          return checkCFunc(_G.GiveMasterLoot)
        end,
        GroupHasOfflineMember = function()
          return checkCFunc(_G.GroupHasOfflineMember)
        end,
        GuildControlAddRank = function()
          return checkCFunc(_G.GuildControlAddRank)
        end,
        GuildControlDelRank = function()
          return checkCFunc(_G.GuildControlDelRank)
        end,
        GuildControlGetAllowedShifts = function()
          return checkCFunc(_G.GuildControlGetAllowedShifts)
        end,
        GuildControlGetNumRanks = function()
          return checkCFunc(_G.GuildControlGetNumRanks)
        end,
        GuildControlGetRankFlags = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GuildControlGetRankFlags)
          end
          return checkCFunc(_G.GuildControlGetRankFlags)
        end,
        GuildControlGetRankName = function()
          return checkCFunc(_G.GuildControlGetRankName)
        end,
        GuildControlSaveRank = function()
          return checkCFunc(_G.GuildControlSaveRank)
        end,
        GuildControlSetRank = function()
          return checkCFunc(_G.GuildControlSetRank)
        end,
        GuildControlSetRankFlag = function()
          return checkCFunc(_G.GuildControlSetRankFlag)
        end,
        GuildControlShiftRankDown = function()
          return checkCFunc(_G.GuildControlShiftRankDown)
        end,
        GuildControlShiftRankUp = function()
          return checkCFunc(_G.GuildControlShiftRankUp)
        end,
        GuildDemote = function()
          return checkCFunc(_G.GuildDemote)
        end,
        GuildDisband = function()
          return checkCFunc(_G.GuildDisband)
        end,
        GuildInfo = function()
          return checkCFunc(_G.GuildInfo)
        end,
        GuildInvite = function()
          return checkCFunc(_G.GuildInvite)
        end,
        GuildLeave = function()
          return checkCFunc(_G.GuildLeave)
        end,
        GuildMasterAbsent = function()
          return checkCFunc(_G.GuildMasterAbsent)
        end,
        GuildNewsSetSticky = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GuildNewsSetSticky)
          end
          return checkCFunc(_G.GuildNewsSetSticky)
        end,
        GuildNewsSort = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GuildNewsSort)
          end
          return checkCFunc(_G.GuildNewsSort)
        end,
        GuildPromote = function()
          return checkCFunc(_G.GuildPromote)
        end,
        GuildRosterSendSoR = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.GuildRosterSendSoR)
          end
          return checkCFunc(_G.GuildRosterSendSoR)
        end,
        GuildRosterSetOfficerNote = function()
          return checkCFunc(_G.GuildRosterSetOfficerNote)
        end,
        GuildRosterSetPublicNote = function()
          return checkCFunc(_G.GuildRosterSetPublicNote)
        end,
        GuildSetLeader = function()
          return checkCFunc(_G.GuildSetLeader)
        end,
        GuildSetMOTD = function()
          return checkCFunc(_G.GuildSetMOTD)
        end,
        GuildUninvite = function()
          return checkCFunc(_G.GuildUninvite)
        end,
        HandleAtlasMemberCommand = function()
          return checkCFunc(_G.HandleAtlasMemberCommand)
        end,
        HasAPEffectsSpellPower = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasAPEffectsSpellPower)
          end
          return checkCFunc(_G.HasAPEffectsSpellPower)
        end,
        HasAction = function()
          return checkCFunc(_G.HasAction)
        end,
        HasArtifactEquipped = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasArtifactEquipped)
          end
          return checkCFunc(_G.HasArtifactEquipped)
        end,
        HasAttachedGlyph = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasAttachedGlyph)
          end
          return checkCFunc(_G.HasAttachedGlyph)
        end,
        HasBonusActionBar = function()
          return checkCFunc(_G.HasBonusActionBar)
        end,
        HasBoundGemProposed = function()
          return checkCFunc(_G.HasBoundGemProposed)
        end,
        HasCompletedAnyAchievement = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasCompletedAnyAchievement)
          end
          return checkCFunc(_G.HasCompletedAnyAchievement)
        end,
        HasDualWieldPenalty = function()
          return checkCFunc(_G.HasDualWieldPenalty)
        end,
        HasExtraActionBar = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasExtraActionBar)
          end
          return checkCFunc(_G.HasExtraActionBar)
        end,
        HasFilledPetition = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasFilledPetition)
          end
          return checkCFunc(_G.HasFilledPetition)
        end,
        HasFullControl = function()
          return checkCFunc(_G.HasFullControl)
        end,
        HasIgnoreDualWieldWeapon = function()
          return checkCFunc(_G.HasIgnoreDualWieldWeapon)
        end,
        HasInboxItem = function()
          return checkCFunc(_G.HasInboxItem)
        end,
        HasInspectHonorData = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasInspectHonorData)
          end
          return checkCFunc(_G.HasInspectHonorData)
        end,
        HasKey = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasKey)
          end
          return checkCFunc(_G.HasKey)
        end,
        HasLFGRestrictions = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasLFGRestrictions)
          end
          return checkCFunc(_G.HasLFGRestrictions)
        end,
        HasLoadedCUFProfiles = function()
          return checkCFunc(_G.HasLoadedCUFProfiles)
        end,
        HasNewMail = function()
          return checkCFunc(_G.HasNewMail)
        end,
        HasNoReleaseAura = function()
          return checkCFunc(_G.HasNoReleaseAura)
        end,
        HasOverrideActionBar = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasOverrideActionBar)
          end
          return checkCFunc(_G.HasOverrideActionBar)
        end,
        HasPendingGlyphCast = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasPendingGlyphCast)
          end
          return checkCFunc(_G.HasPendingGlyphCast)
        end,
        HasPetSpells = function()
          return checkCFunc(_G.HasPetSpells)
        end,
        HasPetUI = function()
          return checkCFunc(_G.HasPetUI)
        end,
        HasSPEffectsAttackPower = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasSPEffectsAttackPower)
          end
          return checkCFunc(_G.HasSPEffectsAttackPower)
        end,
        HasSendMailItem = function()
          return checkCFunc(_G.HasSendMailItem)
        end,
        HasTempShapeshiftActionBar = function()
          return checkCFunc(_G.HasTempShapeshiftActionBar)
        end,
        HasVehicleActionBar = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HasVehicleActionBar)
          end
          return checkCFunc(_G.HasVehicleActionBar)
        end,
        HasWandEquipped = function()
          return checkCFunc(_G.HasWandEquipped)
        end,
        HaveQuestData = function()
          return checkCFunc(_G.HaveQuestData)
        end,
        HaveQuestRewardData = function()
          return checkCFunc(_G.HaveQuestRewardData)
        end,
        HearthAndResurrectFromArea = function()
          return checkCFunc(_G.HearthAndResurrectFromArea)
        end,
        HideRepairCursor = function()
          return checkCFunc(_G.HideRepairCursor)
        end,
        HonorSystemEnabled = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.HonorSystemEnabled)
          end
          return checkCFunc(_G.HonorSystemEnabled)
        end,
        InActiveBattlefield = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.InActiveBattlefield)
          end
          return checkCFunc(_G.InActiveBattlefield)
        end,
        InCinematic = function()
          return checkCFunc(_G.InCinematic)
        end,
        InCombatLockdown = function()
          return checkCFunc(_G.InCombatLockdown)
        end,
        InGuildParty = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.InGuildParty)
          end
          return checkCFunc(_G.InGuildParty)
        end,
        InRepairMode = function()
          return checkCFunc(_G.InRepairMode)
        end,
        InboxItemCanDelete = function()
          return checkCFunc(_G.InboxItemCanDelete)
        end,
        InitiateRolePoll = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.InitiateRolePoll)
          end
          return checkCFunc(_G.InitiateRolePoll)
        end,
        InitiateTrade = function()
          return checkCFunc(_G.InitiateTrade)
        end,
        InteractUnit = function()
          return checkCFunc(_G.InteractUnit)
        end,
        InviteUnit = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.InviteUnit)
          end
          return checkCFunc(_G.InviteUnit)
        end,
        Is64BitClient = function()
          return checkCFunc(_G.Is64BitClient)
        end,
        IsAccountSecured = function()
          return checkCFunc(_G.IsAccountSecured)
        end,
        IsAchievementEligible = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsAchievementEligible)
          end
          return checkCFunc(_G.IsAchievementEligible)
        end,
        IsActionInRange = function()
          return checkCFunc(_G.IsActionInRange)
        end,
        IsActiveBattlefieldArena = function()
          return checkCFunc(_G.IsActiveBattlefieldArena)
        end,
        IsActiveQuestLegendary = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsActiveQuestLegendary)
          end
          return checkCFunc(_G.IsActiveQuestLegendary)
        end,
        IsActiveQuestTrivial = function()
          return checkCFunc(_G.IsActiveQuestTrivial)
        end,
        IsAddOnLoadOnDemand = function()
          return checkCFunc(_G.IsAddOnLoadOnDemand)
        end,
        IsAddOnLoaded = function()
          return checkCFunc(_G.IsAddOnLoaded)
        end,
        IsAddonVersionCheckEnabled = function()
          return checkCFunc(_G.IsAddonVersionCheckEnabled)
        end,
        IsAllowedToUserTeleport = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsAllowedToUserTeleport)
          end
          return checkCFunc(_G.IsAllowedToUserTeleport)
        end,
        IsAltKeyDown = function()
          return checkCFunc(_G.IsAltKeyDown)
        end,
        IsArenaSeasonActive = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsArenaSeasonActive)
          end
          return checkCFunc(_G.IsArenaSeasonActive)
        end,
        IsArenaSkirmish = function()
          return checkCFunc(_G.IsArenaSkirmish)
        end,
        IsArenaTeamCaptain = function()
          return checkCFunc(_G.IsArenaTeamCaptain)
        end,
        IsArtifactCompletionHistoryAvailable = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsArtifactCompletionHistoryAvailable)
          end
          return checkCFunc(_G.IsArtifactCompletionHistoryAvailable)
        end,
        IsArtifactPowerItem = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsArtifactPowerItem)
          end
          return checkCFunc(_G.IsArtifactPowerItem)
        end,
        IsArtifactRelicItem = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsArtifactRelicItem)
          end
          return checkCFunc(_G.IsArtifactRelicItem)
        end,
        IsAtStableMaster = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsAtStableMaster)
          end
          return checkCFunc(_G.IsAtStableMaster)
        end,
        IsAttackAction = function()
          return checkCFunc(_G.IsAttackAction)
        end,
        IsAttackSpell = function()
          return checkCFunc(_G.IsAttackSpell)
        end,
        IsAuctionSortReversed = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsAuctionSortReversed)
          end
          return checkCFunc(_G.IsAuctionSortReversed)
        end,
        IsAutoRepeatAction = function()
          return checkCFunc(_G.IsAutoRepeatAction)
        end,
        IsAutoRepeatSpell = function()
          return checkCFunc(_G.IsAutoRepeatSpell)
        end,
        IsAvailableQuestTrivial = function()
          return checkCFunc(_G.IsAvailableQuestTrivial)
        end,
        IsBNLogin = function()
          return checkCFunc(_G.IsBNLogin)
        end,
        IsBagSlotFlagEnabledOnOtherBags = function()
          return checkCFunc(_G.IsBagSlotFlagEnabledOnOtherBags)
        end,
        IsBagSlotFlagEnabledOnOtherBankBags = function()
          return checkCFunc(_G.IsBagSlotFlagEnabledOnOtherBankBags)
        end,
        IsBattlePayItem = function()
          return checkCFunc(_G.IsBattlePayItem)
        end,
        IsBattlefieldArena = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsBattlefieldArena)
          end
          return checkCFunc(_G.IsBattlefieldArena)
        end,
        IsBindingForGamePad = function()
          return checkCFunc(_G.IsBindingForGamePad)
        end,
        IsBreadcrumbQuest = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsBreadcrumbQuest)
          end
          return checkCFunc(_G.IsBreadcrumbQuest)
        end,
        IsCastingGlyph = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsCastingGlyph)
          end
          return checkCFunc(_G.IsCastingGlyph)
        end,
        IsCemeterySelectionAvailable = function()
          return checkCFunc(_G.IsCemeterySelectionAvailable)
        end,
        IsCharacterNewlyBoosted = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsCharacterNewlyBoosted)
          end
          return checkCFunc(_G.IsCharacterNewlyBoosted)
        end,
        IsChatAFK = function()
          return checkCFunc(_G.IsChatAFK)
        end,
        IsChatChannelRaid = function()
          return checkCFunc(_G.IsChatChannelRaid)
        end,
        IsChatDND = function()
          return checkCFunc(_G.IsChatDND)
        end,
        IsCompetitiveModeEnabled = function()
          return checkCFunc(_G.IsCompetitiveModeEnabled)
        end,
        IsConsumableAction = function()
          return checkCFunc(_G.IsConsumableAction)
        end,
        IsConsumableItem = function()
          return checkCFunc(_G.IsConsumableItem)
        end,
        IsConsumableSpell = function()
          return checkCFunc(_G.IsConsumableSpell)
        end,
        IsContainerFiltered = function()
          return checkCFunc(_G.IsContainerFiltered)
        end,
        IsContainerItemAnUpgrade = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsContainerItemAnUpgrade)
          end
          return checkCFunc(_G.IsContainerItemAnUpgrade)
        end,
        IsControlKeyDown = function()
          return checkCFunc(_G.IsControlKeyDown)
        end,
        IsCorruptedItem = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsCorruptedItem)
          end
          return checkCFunc(_G.IsCorruptedItem)
        end,
        IsCosmeticItem = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsCosmeticItem)
          end
          return checkCFunc(_G.IsCosmeticItem)
        end,
        IsCurrentAction = function()
          return checkCFunc(_G.IsCurrentAction)
        end,
        IsCurrentItem = function()
          return checkCFunc(_G.IsCurrentItem)
        end,
        IsCurrentQuestFailed = function()
          return checkCFunc(_G.IsCurrentQuestFailed)
        end,
        IsCurrentSpell = function()
          return checkCFunc(_G.IsCurrentSpell)
        end,
        IsDebugBuild = function()
          return checkCFunc(_G.IsDebugBuild)
        end,
        IsDemonHunterAvailable = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsDemonHunterAvailable)
          end
          return checkCFunc(_G.IsDemonHunterAvailable)
        end,
        IsDesaturateSupported = function()
          return checkCFunc(_G.IsDesaturateSupported)
        end,
        IsDisplayChannelModerator = function()
          return checkCFunc(_G.IsDisplayChannelModerator)
        end,
        IsDisplayChannelOwner = function()
          return checkCFunc(_G.IsDisplayChannelOwner)
        end,
        IsDressableItem = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsDressableItem)
          end
          return checkCFunc(_G.IsDressableItem)
        end,
        IsDualWielding = function()
          return checkCFunc(_G.IsDualWielding)
        end,
        IsEncounterInProgress = function()
          return checkCFunc(_G.IsEncounterInProgress)
        end,
        IsEncounterLimitingResurrections = function()
          return checkCFunc(_G.IsEncounterLimitingResurrections)
        end,
        IsEncounterSuppressingRelease = function()
          return checkCFunc(_G.IsEncounterSuppressingRelease)
        end,
        IsEquippableItem = function()
          return checkCFunc(_G.IsEquippableItem)
        end,
        IsEquippedAction = function()
          return checkCFunc(_G.IsEquippedAction)
        end,
        IsEquippedItem = function()
          return checkCFunc(_G.IsEquippedItem)
        end,
        IsEquippedItemType = function()
          return checkCFunc(_G.IsEquippedItemType)
        end,
        IsEuropeanNumbers = function()
          return checkCFunc(_G.IsEuropeanNumbers)
        end,
        IsEveryoneAssistant = function()
          return checkCFunc(_G.IsEveryoneAssistant)
        end,
        IsExpansionTrial = function()
          return checkCFunc(_G.IsExpansionTrial)
        end,
        IsFactionInactive = function()
          return checkCFunc(_G.IsFactionInactive)
        end,
        IsFalling = function()
          return checkCFunc(_G.IsFalling)
        end,
        IsFishingLoot = function()
          return checkCFunc(_G.IsFishingLoot)
        end,
        IsFlyableArea = function()
          return checkCFunc(_G.IsFlyableArea)
        end,
        IsFlying = function()
          return checkCFunc(_G.IsFlying)
        end,
        IsGMClient = function()
          return checkCFunc(_G.IsGMClient)
        end,
        IsGUIDInGroup = function()
          return checkCFunc(_G.IsGUIDInGroup)
        end,
        IsGamePadCursorControlEnabled = function()
          return checkCFunc(_G.IsGamePadCursorControlEnabled)
        end,
        IsGamePadFreelookEnabled = function()
          return checkCFunc(_G.IsGamePadFreelookEnabled)
        end,
        IsGuildLeader = function()
          return checkCFunc(_G.IsGuildLeader)
        end,
        IsGuildMember = function()
          return checkCFunc(_G.IsGuildMember)
        end,
        IsGuildRankAssignmentAllowed = function()
          return checkCFunc(_G.IsGuildRankAssignmentAllowed)
        end,
        IsHarmfulItem = function()
          return checkCFunc(_G.IsHarmfulItem)
        end,
        IsHarmfulSpell = function()
          return checkCFunc(_G.IsHarmfulSpell)
        end,
        IsHelpfulItem = function()
          return checkCFunc(_G.IsHelpfulItem)
        end,
        IsHelpfulSpell = function()
          return checkCFunc(_G.IsHelpfulSpell)
        end,
        IsInActiveWorldPVP = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsInActiveWorldPVP)
          end
          return checkCFunc(_G.IsInActiveWorldPVP)
        end,
        IsInArenaTeam = function()
          return checkCFunc(_G.IsInArenaTeam)
        end,
        IsInAuthenticatedRank = function()
          return checkCFunc(_G.IsInAuthenticatedRank)
        end,
        IsInCinematicScene = function()
          return checkCFunc(_G.IsInCinematicScene)
        end,
        IsInGroup = function()
          return checkCFunc(_G.IsInGroup)
        end,
        IsInGuild = function()
          return checkCFunc(_G.IsInGuild)
        end,
        IsInGuildGroup = function()
          return checkCFunc(_G.IsInGuildGroup)
        end,
        IsInInstance = function()
          return checkCFunc(_G.IsInInstance)
        end,
        IsInJailersTower = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsInJailersTower)
          end
          return checkCFunc(_G.IsInJailersTower)
        end,
        IsInLFGDungeon = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsInLFGDungeon)
          end
          return checkCFunc(_G.IsInLFGDungeon)
        end,
        IsInRaid = function()
          return checkCFunc(_G.IsInRaid)
        end,
        IsInScenarioGroup = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsInScenarioGroup)
          end
          return checkCFunc(_G.IsInScenarioGroup)
        end,
        IsIndoors = function()
          return checkCFunc(_G.IsIndoors)
        end,
        IsInsane = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsInsane)
          end
          return checkCFunc(_G.IsInsane)
        end,
        IsInventoryItemAnUpgrade = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsInventoryItemAnUpgrade)
          end
          return checkCFunc(_G.IsInventoryItemAnUpgrade)
        end,
        IsInventoryItemLocked = function()
          return checkCFunc(_G.IsInventoryItemLocked)
        end,
        IsInventoryItemProfessionBag = function()
          return checkCFunc(_G.IsInventoryItemProfessionBag)
        end,
        IsItemAction = function()
          return checkCFunc(_G.IsItemAction)
        end,
        IsItemInRange = function()
          return checkCFunc(_G.IsItemInRange)
        end,
        IsJailersTowerLayerTimeLocked = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsJailersTowerLayerTimeLocked)
          end
          return checkCFunc(_G.IsJailersTowerLayerTimeLocked)
        end,
        IsKeyDown = function()
          return checkCFunc(_G.IsKeyDown)
        end,
        IsLFGComplete = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsLFGComplete)
          end
          return checkCFunc(_G.IsLFGComplete)
        end,
        IsLFGDungeonJoinable = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsLFGDungeonJoinable)
          end
          return checkCFunc(_G.IsLFGDungeonJoinable)
        end,
        IsLeftAltKeyDown = function()
          return checkCFunc(_G.IsLeftAltKeyDown)
        end,
        IsLeftControlKeyDown = function()
          return checkCFunc(_G.IsLeftControlKeyDown)
        end,
        IsLeftMetaKeyDown = function()
          return checkCFunc(_G.IsLeftMetaKeyDown)
        end,
        IsLeftShiftKeyDown = function()
          return checkCFunc(_G.IsLeftShiftKeyDown)
        end,
        IsLegacyDifficulty = function()
          return checkCFunc(_G.IsLegacyDifficulty)
        end,
        IsLinuxClient = function()
          return checkCFunc(_G.IsLinuxClient)
        end,
        IsLoggedIn = function()
          return checkCFunc(_G.IsLoggedIn)
        end,
        IsMacClient = function()
          return checkCFunc(_G.IsMacClient)
        end,
        IsMasterLooter = function()
          return checkCFunc(_G.IsMasterLooter)
        end,
        IsMetaKeyDown = function()
          return checkCFunc(_G.IsMetaKeyDown)
        end,
        IsModifiedClick = function()
          return checkCFunc(_G.IsModifiedClick)
        end,
        IsModifierKeyDown = function()
          return checkCFunc(_G.IsModifierKeyDown)
        end,
        IsMounted = function()
          return checkCFunc(_G.IsMounted)
        end,
        IsMouseButtonDown = function()
          return checkCFunc(_G.IsMouseButtonDown)
        end,
        IsMouselooking = function()
          return checkCFunc(_G.IsMouselooking)
        end,
        IsMovieLocal = function()
          return checkCFunc(_G.IsMovieLocal)
        end,
        IsMoviePlayable = function()
          return checkCFunc(_G.IsMoviePlayable)
        end,
        IsOnGlueScreen = function()
          return checkCFunc(_G.IsOnGlueScreen)
        end,
        IsOnGroundFloorInJailersTower = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsOnGroundFloorInJailersTower)
          end
          return checkCFunc(_G.IsOnGroundFloorInJailersTower)
        end,
        IsOnTournamentRealm = function()
          return checkCFunc(_G.IsOnTournamentRealm)
        end,
        IsOutOfBounds = function()
          return checkCFunc(_G.IsOutOfBounds)
        end,
        IsOutdoors = function()
          return checkCFunc(_G.IsOutdoors)
        end,
        IsOutlineModeSupported = function()
          return checkCFunc(_G.IsOutlineModeSupported)
        end,
        IsPVPTimerRunning = function()
          return checkCFunc(_G.IsPVPTimerRunning)
        end,
        IsPartyLFG = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsPartyLFG)
          end
          return checkCFunc(_G.IsPartyLFG)
        end,
        IsPartyWorldPVP = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsPartyWorldPVP)
          end
          return checkCFunc(_G.IsPartyWorldPVP)
        end,
        IsPassiveSpell = function()
          return checkCFunc(_G.IsPassiveSpell)
        end,
        IsPendingGlyphRemoval = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsPendingGlyphRemoval)
          end
          return checkCFunc(_G.IsPendingGlyphRemoval)
        end,
        IsPetActive = function()
          return checkCFunc(_G.IsPetActive)
        end,
        IsPetAttackAction = function()
          return checkCFunc(_G.IsPetAttackAction)
        end,
        IsPetAttackActive = function()
          return checkCFunc(_G.IsPetAttackActive)
        end,
        IsPlayerAttacking = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsPlayerAttacking)
          end
          return checkCFunc(_G.IsPlayerAttacking)
        end,
        IsPlayerInWorld = function()
          return checkCFunc(_G.IsPlayerInWorld)
        end,
        IsPlayerMoving = function()
          return checkCFunc(_G.IsPlayerMoving)
        end,
        IsPlayerNeutral = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsPlayerNeutral)
          end
          return checkCFunc(_G.IsPlayerNeutral)
        end,
        IsPlayerSpell = function()
          return checkCFunc(_G.IsPlayerSpell)
        end,
        IsPossessBarVisible = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsPossessBarVisible)
          end
          return checkCFunc(_G.IsPossessBarVisible)
        end,
        IsPublicBuild = function()
          return checkCFunc(_G.IsPublicBuild)
        end,
        IsPvpTalentSpell = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsPvpTalentSpell)
          end
          return checkCFunc(_G.IsPvpTalentSpell)
        end,
        IsQuestCompletable = function()
          return checkCFunc(_G.IsQuestCompletable)
        end,
        IsQuestComplete = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsQuestComplete)
          end
          return checkCFunc(_G.IsQuestComplete)
        end,
        IsQuestHardWatched = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsQuestHardWatched)
          end
          return checkCFunc(_G.IsQuestHardWatched)
        end,
        IsQuestIDValidSpellTarget = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsQuestIDValidSpellTarget)
          end
          return checkCFunc(_G.IsQuestIDValidSpellTarget)
        end,
        IsQuestItemHidden = function()
          return checkCFunc(_G.IsQuestItemHidden)
        end,
        IsQuestLogSpecialItemInRange = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsQuestLogSpecialItemInRange)
          end
          return checkCFunc(_G.IsQuestLogSpecialItemInRange)
        end,
        IsQuestSequenced = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsQuestSequenced)
          end
          return checkCFunc(_G.IsQuestSequenced)
        end,
        IsQuestWatched = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsQuestWatched)
          end
          return checkCFunc(_G.IsQuestWatched)
        end,
        IsRaidMarkerActive = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsRaidMarkerActive)
          end
          return checkCFunc(_G.IsRaidMarkerActive)
        end,
        IsRangedWeapon = function()
          return checkCFunc(_G.IsRangedWeapon)
        end,
        IsReagentBankUnlocked = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsReagentBankUnlocked)
          end
          return checkCFunc(_G.IsReagentBankUnlocked)
        end,
        IsRecognizedName = function()
          return checkCFunc(_G.IsRecognizedName)
        end,
        IsRecruitAFriendLinked = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsRecruitAFriendLinked)
          end
          return checkCFunc(_G.IsRecruitAFriendLinked)
        end,
        IsReferAFriendLinked = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsReferAFriendLinked)
          end
          return checkCFunc(_G.IsReferAFriendLinked)
        end,
        IsReplacingUnit = function()
          return checkCFunc(_G.IsReplacingUnit)
        end,
        IsResting = function()
          return checkCFunc(_G.IsResting)
        end,
        IsRestrictedAccount = function()
          return checkCFunc(_G.IsRestrictedAccount)
        end,
        IsRightAltKeyDown = function()
          return checkCFunc(_G.IsRightAltKeyDown)
        end,
        IsRightControlKeyDown = function()
          return checkCFunc(_G.IsRightControlKeyDown)
        end,
        IsRightMetaKeyDown = function()
          return checkCFunc(_G.IsRightMetaKeyDown)
        end,
        IsRightShiftKeyDown = function()
          return checkCFunc(_G.IsRightShiftKeyDown)
        end,
        IsSelectedSpellBookItem = function()
          return checkCFunc(_G.IsSelectedSpellBookItem)
        end,
        IsServerControlledBackfill = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsServerControlledBackfill)
          end
          return checkCFunc(_G.IsServerControlledBackfill)
        end,
        IsShiftKeyDown = function()
          return checkCFunc(_G.IsShiftKeyDown)
        end,
        IsSpellClassOrSpec = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsSpellClassOrSpec)
          end
          return checkCFunc(_G.IsSpellClassOrSpec)
        end,
        IsSpellInRange = function()
          return checkCFunc(_G.IsSpellInRange)
        end,
        IsSpellKnown = function()
          return checkCFunc(_G.IsSpellKnown)
        end,
        IsSpellKnownOrOverridesKnown = function()
          return checkCFunc(_G.IsSpellKnownOrOverridesKnown)
        end,
        IsSpellOverlayed = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsSpellOverlayed)
          end
          return checkCFunc(_G.IsSpellOverlayed)
        end,
        IsSpellValidForPendingGlyph = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsSpellValidForPendingGlyph)
          end
          return checkCFunc(_G.IsSpellValidForPendingGlyph)
        end,
        IsSplashFramePrimaryFeatureUnlocked = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsSplashFramePrimaryFeatureUnlocked)
          end
          return checkCFunc(_G.IsSplashFramePrimaryFeatureUnlocked)
        end,
        IsStackableAction = function()
          return checkCFunc(_G.IsStackableAction)
        end,
        IsStealthed = function()
          return checkCFunc(_G.IsStealthed)
        end,
        IsStoryQuest = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsStoryQuest)
          end
          return checkCFunc(_G.IsStoryQuest)
        end,
        IsSubZonePVPPOI = function()
          return checkCFunc(_G.IsSubZonePVPPOI)
        end,
        IsSubmerged = function()
          return checkCFunc(_G.IsSubmerged)
        end,
        IsSwimming = function()
          return checkCFunc(_G.IsSwimming)
        end,
        IsTalentSpell = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsTalentSpell)
          end
          return checkCFunc(_G.IsTalentSpell)
        end,
        IsTestBuild = function()
          return checkCFunc(_G.IsTestBuild)
        end,
        IsThreatWarningEnabled = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsThreatWarningEnabled)
          end
          return checkCFunc(_G.IsThreatWarningEnabled)
        end,
        IsTitleKnown = function()
          return checkCFunc(_G.IsTitleKnown)
        end,
        IsTrackedAchievement = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsTrackedAchievement)
          end
          return checkCFunc(_G.IsTrackedAchievement)
        end,
        IsTrackingBattlePets = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsTrackingBattlePets)
          end
          return checkCFunc(_G.IsTrackingBattlePets)
        end,
        IsTrackingHiddenQuests = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsTrackingHiddenQuests)
          end
          return checkCFunc(_G.IsTrackingHiddenQuests)
        end,
        IsTradeskillTrainer = function()
          return checkCFunc(_G.IsTradeskillTrainer)
        end,
        IsTrainerServiceLearnSpell = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsTrainerServiceLearnSpell)
          end
          return checkCFunc(_G.IsTrainerServiceLearnSpell)
        end,
        IsTrialAccount = function()
          return checkCFunc(_G.IsTrialAccount)
        end,
        IsTutorialFlagged = function()
          return checkCFunc(_G.IsTutorialFlagged)
        end,
        IsUnitModelReadyForUI = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsUnitModelReadyForUI)
          end
          return checkCFunc(_G.IsUnitModelReadyForUI)
        end,
        IsUnitOnQuest = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsUnitOnQuest)
          end
          return checkCFunc(_G.IsUnitOnQuest)
        end,
        IsUnitOnQuestByQuestID = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsUnitOnQuestByQuestID)
          end
          return checkCFunc(_G.IsUnitOnQuestByQuestID)
        end,
        IsUsableAction = function()
          return checkCFunc(_G.IsUsableAction)
        end,
        IsUsableItem = function()
          return checkCFunc(_G.IsUsableItem)
        end,
        IsUsableSpell = function()
          return checkCFunc(_G.IsUsableSpell)
        end,
        IsUsingFixedTimeStep = function()
          return checkCFunc(_G.IsUsingFixedTimeStep)
        end,
        IsUsingVehicleControls = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsUsingVehicleControls)
          end
          return checkCFunc(_G.IsUsingVehicleControls)
        end,
        IsVehicleAimAngleAdjustable = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsVehicleAimAngleAdjustable)
          end
          return checkCFunc(_G.IsVehicleAimAngleAdjustable)
        end,
        IsVehicleAimPowerAdjustable = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsVehicleAimPowerAdjustable)
          end
          return checkCFunc(_G.IsVehicleAimPowerAdjustable)
        end,
        IsVeteranTrialAccount = function()
          return checkCFunc(_G.IsVeteranTrialAccount)
        end,
        IsVoidStorageReady = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsVoidStorageReady)
          end
          return checkCFunc(_G.IsVoidStorageReady)
        end,
        IsWargame = function()
          return checkCFunc(_G.IsWargame)
        end,
        IsWindowsClient = function()
          return checkCFunc(_G.IsWindowsClient)
        end,
        IsXPUserDisabled = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.IsXPUserDisabled)
          end
          return checkCFunc(_G.IsXPUserDisabled)
        end,
        ItemAddedToArtifact = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ItemAddedToArtifact)
          end
          return checkCFunc(_G.ItemAddedToArtifact)
        end,
        ItemCanTargetGarrisonFollowerAbility = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ItemCanTargetGarrisonFollowerAbility)
          end
          return checkCFunc(_G.ItemCanTargetGarrisonFollowerAbility)
        end,
        ItemHasRange = function()
          return checkCFunc(_G.ItemHasRange)
        end,
        ItemTextGetCreator = function()
          return checkCFunc(_G.ItemTextGetCreator)
        end,
        ItemTextGetItem = function()
          return checkCFunc(_G.ItemTextGetItem)
        end,
        ItemTextGetMaterial = function()
          return checkCFunc(_G.ItemTextGetMaterial)
        end,
        ItemTextGetPage = function()
          return checkCFunc(_G.ItemTextGetPage)
        end,
        ItemTextGetText = function()
          return checkCFunc(_G.ItemTextGetText)
        end,
        ItemTextHasNextPage = function()
          return checkCFunc(_G.ItemTextHasNextPage)
        end,
        ItemTextIsFullPage = function()
          return checkCFunc(_G.ItemTextIsFullPage)
        end,
        ItemTextNextPage = function()
          return checkCFunc(_G.ItemTextNextPage)
        end,
        ItemTextPrevPage = function()
          return checkCFunc(_G.ItemTextPrevPage)
        end,
        JoinArena = function()
          return checkCFunc(_G.JoinArena)
        end,
        JoinBattlefield = function()
          return checkCFunc(_G.JoinBattlefield)
        end,
        JoinChannelByName = function()
          return checkCFunc(_G.JoinChannelByName)
        end,
        JoinLFG = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.JoinLFG)
          end
          return checkCFunc(_G.JoinLFG)
        end,
        JoinPermanentChannel = function()
          return checkCFunc(_G.JoinPermanentChannel)
        end,
        JoinRatedBattlefield = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.JoinRatedBattlefield)
          end
          return checkCFunc(_G.JoinRatedBattlefield)
        end,
        JoinSingleLFG = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.JoinSingleLFG)
          end
          return checkCFunc(_G.JoinSingleLFG)
        end,
        JoinSkirmish = function()
          return checkCFunc(_G.JoinSkirmish)
        end,
        JoinTemporaryChannel = function()
          return checkCFunc(_G.JoinTemporaryChannel)
        end,
        JumpOrAscendStart = function()
          return checkCFunc(_G.JumpOrAscendStart)
        end,
        KBArticle_BeginLoading = function()
          return checkCFunc(_G.KBArticle_BeginLoading)
        end,
        KBArticle_GetData = function()
          return checkCFunc(_G.KBArticle_GetData)
        end,
        KBArticle_IsLoaded = function()
          return checkCFunc(_G.KBArticle_IsLoaded)
        end,
        KBQuery_BeginLoading = function()
          return checkCFunc(_G.KBQuery_BeginLoading)
        end,
        KBQuery_GetArticleHeaderCount = function()
          return checkCFunc(_G.KBQuery_GetArticleHeaderCount)
        end,
        KBQuery_GetArticleHeaderData = function()
          return checkCFunc(_G.KBQuery_GetArticleHeaderData)
        end,
        KBQuery_GetTotalArticleCount = function()
          return checkCFunc(_G.KBQuery_GetTotalArticleCount)
        end,
        KBQuery_IsLoaded = function()
          return checkCFunc(_G.KBQuery_IsLoaded)
        end,
        KBSetup_BeginLoading = function()
          return checkCFunc(_G.KBSetup_BeginLoading)
        end,
        KBSetup_GetArticleHeaderCount = function()
          return checkCFunc(_G.KBSetup_GetArticleHeaderCount)
        end,
        KBSetup_GetArticleHeaderData = function()
          return checkCFunc(_G.KBSetup_GetArticleHeaderData)
        end,
        KBSetup_GetCategoryCount = function()
          return checkCFunc(_G.KBSetup_GetCategoryCount)
        end,
        KBSetup_GetCategoryData = function()
          return checkCFunc(_G.KBSetup_GetCategoryData)
        end,
        KBSetup_GetLanguageCount = function()
          return checkCFunc(_G.KBSetup_GetLanguageCount)
        end,
        KBSetup_GetLanguageData = function()
          return checkCFunc(_G.KBSetup_GetLanguageData)
        end,
        KBSetup_GetSubCategoryCount = function()
          return checkCFunc(_G.KBSetup_GetSubCategoryCount)
        end,
        KBSetup_GetSubCategoryData = function()
          return checkCFunc(_G.KBSetup_GetSubCategoryData)
        end,
        KBSetup_GetTotalArticleCount = function()
          return checkCFunc(_G.KBSetup_GetTotalArticleCount)
        end,
        KBSetup_IsLoaded = function()
          return checkCFunc(_G.KBSetup_IsLoaded)
        end,
        KBSystem_GetMOTD = function()
          return checkCFunc(_G.KBSystem_GetMOTD)
        end,
        KBSystem_GetServerNotice = function()
          return checkCFunc(_G.KBSystem_GetServerNotice)
        end,
        KBSystem_GetServerStatus = function()
          return checkCFunc(_G.KBSystem_GetServerStatus)
        end,
        KeyRingButtonIDToInvSlotID = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.KeyRingButtonIDToInvSlotID)
          end
          return checkCFunc(_G.KeyRingButtonIDToInvSlotID)
        end,
        LFGTeleport = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.LFGTeleport)
          end
          return checkCFunc(_G.LFGTeleport)
        end,
        LearnPvpTalent = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.LearnPvpTalent)
          end
          return checkCFunc(_G.LearnPvpTalent)
        end,
        LearnPvpTalents = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.LearnPvpTalents)
          end
          return checkCFunc(_G.LearnPvpTalents)
        end,
        LearnTalent = function()
          return checkCFunc(_G.LearnTalent)
        end,
        LearnTalents = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.LearnTalents)
          end
          return checkCFunc(_G.LearnTalents)
        end,
        LeaveBattlefield = function()
          return checkCFunc(_G.LeaveBattlefield)
        end,
        LeaveChannelByLocalID = function()
          return checkCFunc(_G.LeaveChannelByLocalID)
        end,
        LeaveChannelByName = function()
          return checkCFunc(_G.LeaveChannelByName)
        end,
        LeaveLFG = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.LeaveLFG)
          end
          return checkCFunc(_G.LeaveLFG)
        end,
        LeaveParty = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.LeaveParty)
          end
          return checkCFunc(_G.LeaveParty)
        end,
        LeaveSingleLFG = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.LeaveSingleLFG)
          end
          return checkCFunc(_G.LeaveSingleLFG)
        end,
        ListChannelByName = function()
          return checkCFunc(_G.ListChannelByName)
        end,
        ListChannels = function()
          return checkCFunc(_G.ListChannels)
        end,
        LoadAddOn = function()
          return checkCFunc(_G.LoadAddOn)
        end,
        LoadBindings = function()
          return checkCFunc(_G.LoadBindings)
        end,
        LoadURLIndex = function()
          return checkCFunc(_G.LoadURLIndex)
        end,
        LoggingChat = function()
          return checkCFunc(_G.LoggingChat)
        end,
        LoggingCombat = function()
          return checkCFunc(_G.LoggingCombat)
        end,
        Logout = function()
          return checkCFunc(_G.Logout)
        end,
        LootMoneyNotify = function()
          return checkCFunc(_G.LootMoneyNotify)
        end,
        LootSlot = function()
          return checkCFunc(_G.LootSlot)
        end,
        LootSlotHasItem = function()
          return checkCFunc(_G.LootSlotHasItem)
        end,
        MacOptions_AreOSShortcutsDisabled = function()
          return checkCFunc(_G.MacOptions_AreOSShortcutsDisabled)
        end,
        MacOptions_GetGameBundleName = function()
          return checkCFunc(_G.MacOptions_GetGameBundleName)
        end,
        MacOptions_HasNewStyleInputMonitoring = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.MacOptions_HasNewStyleInputMonitoring)
          end
          return checkCFunc(_G.MacOptions_HasNewStyleInputMonitoring)
        end,
        MacOptions_HasNewStyleUniversalAccess = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.MacOptions_HasNewStyleUniversalAccess)
          end
          return checkCFunc(_G.MacOptions_HasNewStyleUniversalAccess)
        end,
        MacOptions_IsInputMonitoringEnabled = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.MacOptions_IsInputMonitoringEnabled)
          end
          return checkCFunc(_G.MacOptions_IsInputMonitoringEnabled)
        end,
        MacOptions_IsMicrophoneEnabled = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.MacOptions_IsMicrophoneEnabled)
          end
          return checkCFunc(_G.MacOptions_IsMicrophoneEnabled)
        end,
        MacOptions_IsUniversalAccessEnabled = function()
          return checkCFunc(_G.MacOptions_IsUniversalAccessEnabled)
        end,
        MacOptions_OpenInputMonitoring = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.MacOptions_OpenInputMonitoring)
          end
          return checkCFunc(_G.MacOptions_OpenInputMonitoring)
        end,
        MacOptions_OpenMicrophoneRequestDialogue = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.MacOptions_OpenMicrophoneRequestDialogue)
          end
          return checkCFunc(_G.MacOptions_OpenMicrophoneRequestDialogue)
        end,
        MacOptions_OpenUniversalAccess = function()
          return checkCFunc(_G.MacOptions_OpenUniversalAccess)
        end,
        MacOptions_SetOSShortcutsDisabled = function()
          return checkCFunc(_G.MacOptions_SetOSShortcutsDisabled)
        end,
        MouseOverrideCinematicDisable = function()
          return checkCFunc(_G.MouseOverrideCinematicDisable)
        end,
        MouselookStart = function()
          return checkCFunc(_G.MouselookStart)
        end,
        MouselookStop = function()
          return checkCFunc(_G.MouselookStop)
        end,
        MoveAndSteerStart = function()
          return checkCFunc(_G.MoveAndSteerStart)
        end,
        MoveAndSteerStop = function()
          return checkCFunc(_G.MoveAndSteerStop)
        end,
        MoveBackwardStart = function()
          return checkCFunc(_G.MoveBackwardStart)
        end,
        MoveBackwardStop = function()
          return checkCFunc(_G.MoveBackwardStop)
        end,
        MoveForwardStart = function()
          return checkCFunc(_G.MoveForwardStart)
        end,
        MoveForwardStop = function()
          return checkCFunc(_G.MoveForwardStop)
        end,
        MoveViewDownStart = function()
          return checkCFunc(_G.MoveViewDownStart)
        end,
        MoveViewDownStop = function()
          return checkCFunc(_G.MoveViewDownStop)
        end,
        MoveViewInStart = function()
          return checkCFunc(_G.MoveViewInStart)
        end,
        MoveViewInStop = function()
          return checkCFunc(_G.MoveViewInStop)
        end,
        MoveViewLeftStart = function()
          return checkCFunc(_G.MoveViewLeftStart)
        end,
        MoveViewLeftStop = function()
          return checkCFunc(_G.MoveViewLeftStop)
        end,
        MoveViewOutStart = function()
          return checkCFunc(_G.MoveViewOutStart)
        end,
        MoveViewOutStop = function()
          return checkCFunc(_G.MoveViewOutStop)
        end,
        MoveViewRightStart = function()
          return checkCFunc(_G.MoveViewRightStart)
        end,
        MoveViewRightStop = function()
          return checkCFunc(_G.MoveViewRightStop)
        end,
        MoveViewUpStart = function()
          return checkCFunc(_G.MoveViewUpStart)
        end,
        MoveViewUpStop = function()
          return checkCFunc(_G.MoveViewUpStop)
        end,
        MultiSampleAntiAliasingSupported = function()
          return checkCFunc(_G.MultiSampleAntiAliasingSupported)
        end,
        MuteSoundFile = function()
          return checkCFunc(_G.MuteSoundFile)
        end,
        NeutralPlayerSelectFaction = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.NeutralPlayerSelectFaction)
          end
          return checkCFunc(_G.NeutralPlayerSelectFaction)
        end,
        NextView = function()
          return checkCFunc(_G.NextView)
        end,
        NoPlayTime = function()
          return checkCFunc(_G.NoPlayTime)
        end,
        NotWhileDeadError = function()
          return checkCFunc(_G.NotWhileDeadError)
        end,
        NotifyInspect = function()
          return checkCFunc(_G.NotifyInspect)
        end,
        NumTaxiNodes = function()
          return checkCFunc(_G.NumTaxiNodes)
        end,
        OfferPetition = function()
          return checkCFunc(_G.OfferPetition)
        end,
        OpenTrainer = function()
          return checkCFunc(_G.OpenTrainer)
        end,
        OpeningCinematic = function()
          return checkCFunc(_G.OpeningCinematic)
        end,
        PI = function()
          assertEquals('number', type(_G.PI))
        end,
        PartialPlayTime = function()
          return checkCFunc(_G.PartialPlayTime)
        end,
        PartyLFGStartBackfill = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PartyLFGStartBackfill)
          end
          return checkCFunc(_G.PartyLFGStartBackfill)
        end,
        PetAbandon = function()
          return checkCFunc(_G.PetAbandon)
        end,
        PetAggressiveMode = function()
          return checkCFunc(_G.PetAggressiveMode)
        end,
        PetAssistMode = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PetAssistMode)
          end
          return checkCFunc(_G.PetAssistMode)
        end,
        PetAttack = function()
          return checkCFunc(_G.PetAttack)
        end,
        PetCanBeAbandoned = function()
          return checkCFunc(_G.PetCanBeAbandoned)
        end,
        PetCanBeDismissed = function()
          return checkCFunc(_G.PetCanBeDismissed)
        end,
        PetCanBeRenamed = function()
          return checkCFunc(_G.PetCanBeRenamed)
        end,
        PetDefensiveAssistMode = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PetDefensiveAssistMode)
          end
          return checkCFunc(_G.PetDefensiveAssistMode)
        end,
        PetDefensiveMode = function()
          return checkCFunc(_G.PetDefensiveMode)
        end,
        PetDismiss = function()
          return checkCFunc(_G.PetDismiss)
        end,
        PetFollow = function()
          return checkCFunc(_G.PetFollow)
        end,
        PetHasActionBar = function()
          return checkCFunc(_G.PetHasActionBar)
        end,
        PetHasSpellbook = function()
          return checkCFunc(_G.PetHasSpellbook)
        end,
        PetMoveTo = function()
          return checkCFunc(_G.PetMoveTo)
        end,
        PetPassiveMode = function()
          return checkCFunc(_G.PetPassiveMode)
        end,
        PetRename = function()
          return checkCFunc(_G.PetRename)
        end,
        PetStopAttack = function()
          return checkCFunc(_G.PetStopAttack)
        end,
        PetUsesPetFrame = function()
          return checkCFunc(_G.PetUsesPetFrame)
        end,
        PetWait = function()
          return checkCFunc(_G.PetWait)
        end,
        PickupAction = function()
          return checkCFunc(_G.PickupAction)
        end,
        PickupBagFromSlot = function()
          return checkCFunc(_G.PickupBagFromSlot)
        end,
        PickupCompanion = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PickupCompanion)
          end
          return checkCFunc(_G.PickupCompanion)
        end,
        PickupContainerItem = function()
          return checkCFunc(_G.PickupContainerItem)
        end,
        PickupGuildBankItem = function()
          return checkCFunc(_G.PickupGuildBankItem)
        end,
        PickupGuildBankMoney = function()
          return checkCFunc(_G.PickupGuildBankMoney)
        end,
        PickupInventoryItem = function()
          return checkCFunc(_G.PickupInventoryItem)
        end,
        PickupItem = function()
          return checkCFunc(_G.PickupItem)
        end,
        PickupMacro = function()
          return checkCFunc(_G.PickupMacro)
        end,
        PickupMerchantItem = function()
          return checkCFunc(_G.PickupMerchantItem)
        end,
        PickupPetAction = function()
          return checkCFunc(_G.PickupPetAction)
        end,
        PickupPetSpell = function()
          return checkCFunc(_G.PickupPetSpell)
        end,
        PickupPlayerMoney = function()
          return checkCFunc(_G.PickupPlayerMoney)
        end,
        PickupPvpTalent = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PickupPvpTalent)
          end
          return checkCFunc(_G.PickupPvpTalent)
        end,
        PickupSpell = function()
          return checkCFunc(_G.PickupSpell)
        end,
        PickupSpellBookItem = function()
          return checkCFunc(_G.PickupSpellBookItem)
        end,
        PickupStablePet = function()
          return checkCFunc(_G.PickupStablePet)
        end,
        PickupTalent = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PickupTalent)
          end
          return checkCFunc(_G.PickupTalent)
        end,
        PickupTradeMoney = function()
          return checkCFunc(_G.PickupTradeMoney)
        end,
        PitchDownStart = function()
          return checkCFunc(_G.PitchDownStart)
        end,
        PitchDownStop = function()
          return checkCFunc(_G.PitchDownStop)
        end,
        PitchUpStart = function()
          return checkCFunc(_G.PitchUpStart)
        end,
        PitchUpStop = function()
          return checkCFunc(_G.PitchUpStop)
        end,
        PlaceAction = function()
          return checkCFunc(_G.PlaceAction)
        end,
        PlaceAuctionBid = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PlaceAuctionBid)
          end
          return checkCFunc(_G.PlaceAuctionBid)
        end,
        PlaceRaidMarker = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PlaceRaidMarker)
          end
          return checkCFunc(_G.PlaceRaidMarker)
        end,
        PlayAutoAcceptQuestSound = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PlayAutoAcceptQuestSound)
          end
          return checkCFunc(_G.PlayAutoAcceptQuestSound)
        end,
        PlayMusic = function()
          return checkCFunc(_G.PlayMusic)
        end,
        PlaySound = function()
          return checkCFunc(_G.PlaySound)
        end,
        PlaySoundFile = function()
          return checkCFunc(_G.PlaySoundFile)
        end,
        PlayVocalErrorSoundID = function()
          return checkCFunc(_G.PlayVocalErrorSoundID)
        end,
        PlayerCanTeleport = function()
          return checkCFunc(_G.PlayerCanTeleport)
        end,
        PlayerEffectiveAttackPower = function()
          return checkCFunc(_G.PlayerEffectiveAttackPower)
        end,
        PlayerHasHearthstone = function()
          return checkCFunc(_G.PlayerHasHearthstone)
        end,
        PlayerHasToy = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PlayerHasToy)
          end
          return checkCFunc(_G.PlayerHasToy)
        end,
        PlayerIsPVPInactive = function()
          return checkCFunc(_G.PlayerIsPVPInactive)
        end,
        PlayerVehicleHasComboPoints = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PlayerVehicleHasComboPoints)
          end
          return checkCFunc(_G.PlayerVehicleHasComboPoints)
        end,
        PortGraveyard = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PortGraveyard)
          end
          return checkCFunc(_G.PortGraveyard)
        end,
        PostAuction = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.PostAuction)
          end
          return checkCFunc(_G.PostAuction)
        end,
        PreloadMovie = function()
          return checkCFunc(_G.PreloadMovie)
        end,
        PrevView = function()
          return checkCFunc(_G.PrevView)
        end,
        ProcessExceptionClient = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ProcessExceptionClient)
          end
          return checkCFunc(_G.ProcessExceptionClient)
        end,
        ProcessQuestLogRewardFactions = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ProcessQuestLogRewardFactions)
          end
          return checkCFunc(_G.ProcessQuestLogRewardFactions)
        end,
        PromoteToAssistant = function()
          return checkCFunc(_G.PromoteToAssistant)
        end,
        PromoteToLeader = function()
          return checkCFunc(_G.PromoteToLeader)
        end,
        PurchaseSlot = function()
          return checkCFunc(_G.PurchaseSlot)
        end,
        PutItemInBackpack = function()
          return checkCFunc(_G.PutItemInBackpack)
        end,
        PutItemInBag = function()
          return checkCFunc(_G.PutItemInBag)
        end,
        QueryAuctionItems = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QueryAuctionItems)
          end
          return checkCFunc(_G.QueryAuctionItems)
        end,
        QueryGuildBankLog = function()
          return checkCFunc(_G.QueryGuildBankLog)
        end,
        QueryGuildBankTab = function()
          return checkCFunc(_G.QueryGuildBankTab)
        end,
        QueryGuildBankText = function()
          return checkCFunc(_G.QueryGuildBankText)
        end,
        QueryGuildEventLog = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QueryGuildEventLog)
          end
          return checkCFunc(_G.QueryGuildEventLog)
        end,
        QueryGuildNews = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QueryGuildNews)
          end
          return checkCFunc(_G.QueryGuildNews)
        end,
        QueryGuildRecipes = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QueryGuildRecipes)
          end
          return checkCFunc(_G.QueryGuildRecipes)
        end,
        QuestChooseRewardError = function()
          return checkCFunc(_G.QuestChooseRewardError)
        end,
        QuestFlagsPVP = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestFlagsPVP)
          end
          return checkCFunc(_G.QuestFlagsPVP)
        end,
        QuestGetAutoAccept = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestGetAutoAccept)
          end
          return checkCFunc(_G.QuestGetAutoAccept)
        end,
        QuestGetAutoLaunched = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestGetAutoLaunched)
          end
          return checkCFunc(_G.QuestGetAutoLaunched)
        end,
        QuestHasPOIInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestHasPOIInfo)
          end
          return checkCFunc(_G.QuestHasPOIInfo)
        end,
        QuestIsDaily = function()
          return checkCFunc(_G.QuestIsDaily)
        end,
        QuestIsFromAdventureMap = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestIsFromAdventureMap)
          end
          return checkCFunc(_G.QuestIsFromAdventureMap)
        end,
        QuestIsFromAreaTrigger = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestIsFromAreaTrigger)
          end
          return checkCFunc(_G.QuestIsFromAreaTrigger)
        end,
        QuestIsWeekly = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestIsWeekly)
          end
          return checkCFunc(_G.QuestIsWeekly)
        end,
        QuestLogPushQuest = function()
          return checkCFunc(_G.QuestLogPushQuest)
        end,
        QuestLogRewardHasTreasurePicker = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestLogRewardHasTreasurePicker)
          end
          return checkCFunc(_G.QuestLogRewardHasTreasurePicker)
        end,
        QuestLogShouldShowPortrait = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestLogShouldShowPortrait)
          end
          return checkCFunc(_G.QuestLogShouldShowPortrait)
        end,
        QuestMapUpdateAllQuests = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestMapUpdateAllQuests)
          end
          return checkCFunc(_G.QuestMapUpdateAllQuests)
        end,
        QuestPOIGetIconInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestPOIGetIconInfo)
          end
          return checkCFunc(_G.QuestPOIGetIconInfo)
        end,
        QuestPOIGetSecondaryLocations = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestPOIGetSecondaryLocations)
          end
          return checkCFunc(_G.QuestPOIGetSecondaryLocations)
        end,
        QuestPOIUpdateIcons = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.QuestPOIUpdateIcons)
          end
          return checkCFunc(_G.QuestPOIUpdateIcons)
        end,
        Quit = function()
          return checkCFunc(_G.Quit)
        end,
        RaidProfileExists = function()
          return checkCFunc(_G.RaidProfileExists)
        end,
        RaidProfileHasUnsavedChanges = function()
          return checkCFunc(_G.RaidProfileHasUnsavedChanges)
        end,
        RandomRoll = function()
          return checkCFunc(_G.RandomRoll)
        end,
        ReagentBankButtonIDToInvSlotID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ReagentBankButtonIDToInvSlotID)
          end
          return checkCFunc(_G.ReagentBankButtonIDToInvSlotID)
        end,
        RedockChatWindows = function()
          return checkCFunc(_G.RedockChatWindows)
        end,
        RefreshLFGList = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RefreshLFGList)
          end
          return checkCFunc(_G.RefreshLFGList)
        end,
        RegisterStaticConstants = function()
          return checkCFunc(_G.RegisterStaticConstants)
        end,
        RejectProposal = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RejectProposal)
          end
          return checkCFunc(_G.RejectProposal)
        end,
        RemoveAutoQuestPopUp = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RemoveAutoQuestPopUp)
          end
          return checkCFunc(_G.RemoveAutoQuestPopUp)
        end,
        RemoveChatWindowChannel = function()
          return checkCFunc(_G.RemoveChatWindowChannel)
        end,
        RemoveChatWindowMessages = function()
          return checkCFunc(_G.RemoveChatWindowMessages)
        end,
        RemoveItemFromArtifact = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RemoveItemFromArtifact)
          end
          return checkCFunc(_G.RemoveItemFromArtifact)
        end,
        RemovePvpTalent = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RemovePvpTalent)
          end
          return checkCFunc(_G.RemovePvpTalent)
        end,
        RemoveQuestWatch = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RemoveQuestWatch)
          end
          return checkCFunc(_G.RemoveQuestWatch)
        end,
        RemoveTalent = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RemoveTalent)
          end
          return checkCFunc(_G.RemoveTalent)
        end,
        RemoveTrackedAchievement = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RemoveTrackedAchievement)
          end
          return checkCFunc(_G.RemoveTrackedAchievement)
        end,
        RenamePetition = function()
          return checkCFunc(_G.RenamePetition)
        end,
        ReopenInteraction = function()
          return checkCFunc(_G.ReopenInteraction)
        end,
        RepairAllItems = function()
          return checkCFunc(_G.RepairAllItems)
        end,
        ReplaceEnchant = function()
          return checkCFunc(_G.ReplaceEnchant)
        end,
        ReplaceGuildMaster = function()
          return checkCFunc(_G.ReplaceGuildMaster)
        end,
        ReplaceTradeEnchant = function()
          return checkCFunc(_G.ReplaceTradeEnchant)
        end,
        RepopMe = function()
          return checkCFunc(_G.RepopMe)
        end,
        ReportBug = function()
          return checkCFunc(_G.ReportBug)
        end,
        ReportPlayerIsPVPAFK = function()
          return checkCFunc(_G.ReportPlayerIsPVPAFK)
        end,
        ReportSuggestion = function()
          return checkCFunc(_G.ReportSuggestion)
        end,
        RequestArtifactCompletionHistory = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestArtifactCompletionHistory)
          end
          return checkCFunc(_G.RequestArtifactCompletionHistory)
        end,
        RequestBattlefieldScoreData = function()
          return checkCFunc(_G.RequestBattlefieldScoreData)
        end,
        RequestBattlegroundInstanceInfo = function()
          return checkCFunc(_G.RequestBattlegroundInstanceInfo)
        end,
        RequestBottomLeftActionBar = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestBottomLeftActionBar)
          end
          return checkCFunc(_G.RequestBottomLeftActionBar)
        end,
        RequestGuildChallengeInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestGuildChallengeInfo)
          end
          return checkCFunc(_G.RequestGuildChallengeInfo)
        end,
        RequestGuildPartyState = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestGuildPartyState)
          end
          return checkCFunc(_G.RequestGuildPartyState)
        end,
        RequestGuildRewards = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestGuildRewards)
          end
          return checkCFunc(_G.RequestGuildRewards)
        end,
        RequestInspectHonorData = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestInspectHonorData)
          end
          return checkCFunc(_G.RequestInspectHonorData)
        end,
        RequestLFDPartyLockInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestLFDPartyLockInfo)
          end
          return checkCFunc(_G.RequestLFDPartyLockInfo)
        end,
        RequestLFDPlayerLockInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestLFDPlayerLockInfo)
          end
          return checkCFunc(_G.RequestLFDPlayerLockInfo)
        end,
        RequestPVPOptionsEnabled = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestPVPOptionsEnabled)
          end
          return checkCFunc(_G.RequestPVPOptionsEnabled)
        end,
        RequestPVPRewards = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestPVPRewards)
          end
          return checkCFunc(_G.RequestPVPRewards)
        end,
        RequestRaidInfo = function()
          return checkCFunc(_G.RequestRaidInfo)
        end,
        RequestRandomBattlegroundInstanceInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestRandomBattlegroundInstanceInfo)
          end
          return checkCFunc(_G.RequestRandomBattlegroundInstanceInfo)
        end,
        RequestRatedInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.RequestRatedInfo)
          end
          return checkCFunc(_G.RequestRatedInfo)
        end,
        RequestTimePlayed = function()
          return checkCFunc(_G.RequestTimePlayed)
        end,
        RequeueSkirmish = function()
          return checkCFunc(_G.RequeueSkirmish)
        end,
        ResetAddOns = function()
          return checkCFunc(_G.ResetAddOns)
        end,
        ResetCPUUsage = function()
          return checkCFunc(_G.ResetCPUUsage)
        end,
        ResetChatColors = function()
          return checkCFunc(_G.ResetChatColors)
        end,
        ResetChatWindows = function()
          return checkCFunc(_G.ResetChatWindows)
        end,
        ResetCursor = function()
          return checkCFunc(_G.ResetCursor)
        end,
        ResetDisabledAddOns = function()
          return checkCFunc(_G.ResetDisabledAddOns)
        end,
        ResetInstances = function()
          return checkCFunc(_G.ResetInstances)
        end,
        ResetSetMerchantFilter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ResetSetMerchantFilter)
          end
          return checkCFunc(_G.ResetSetMerchantFilter)
        end,
        ResetTutorials = function()
          return checkCFunc(_G.ResetTutorials)
        end,
        ResetView = function()
          return checkCFunc(_G.ResetView)
        end,
        ResistancePercent = function()
          return checkCFunc(_G.ResistancePercent)
        end,
        RespondInstanceLock = function()
          return checkCFunc(_G.RespondInstanceLock)
        end,
        RespondMailLockSendItem = function()
          return checkCFunc(_G.RespondMailLockSendItem)
        end,
        RespondToInviteConfirmation = function()
          return checkCFunc(_G.RespondToInviteConfirmation)
        end,
        RestartGx = function()
          return checkCFunc(_G.RestartGx)
        end,
        RestoreRaidProfileFromCopy = function()
          return checkCFunc(_G.RestoreRaidProfileFromCopy)
        end,
        ResurrectGetOfferer = function()
          return checkCFunc(_G.ResurrectGetOfferer)
        end,
        ResurrectHasSickness = function()
          return checkCFunc(_G.ResurrectHasSickness)
        end,
        ResurrectHasTimer = function()
          return checkCFunc(_G.ResurrectHasTimer)
        end,
        RetrieveCorpse = function()
          return checkCFunc(_G.RetrieveCorpse)
        end,
        ReturnInboxItem = function()
          return checkCFunc(_G.ReturnInboxItem)
        end,
        RollOnLoot = function()
          return checkCFunc(_G.RollOnLoot)
        end,
        RunBinding = function()
          return checkCFunc(_G.RunBinding)
        end,
        RunMacro = function()
          return checkCFunc(_G.RunMacro)
        end,
        RunMacroText = function()
          return checkCFunc(_G.RunMacroText)
        end,
        RunScript = function()
          return checkCFunc(_G.RunScript)
        end,
        SaveAddOns = function()
          return checkCFunc(_G.SaveAddOns)
        end,
        SaveBindings = function()
          return checkCFunc(_G.SaveBindings)
        end,
        SaveRaidProfileCopy = function()
          return checkCFunc(_G.SaveRaidProfileCopy)
        end,
        SaveView = function()
          return checkCFunc(_G.SaveView)
        end,
        Screenshot = function()
          return checkCFunc(_G.Screenshot)
        end,
        ScriptsDisallowedForBeta = function()
          return checkCFunc(_G.ScriptsDisallowedForBeta)
        end,
        SearchLFGGetEncounterResults = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SearchLFGGetEncounterResults)
          end
          return checkCFunc(_G.SearchLFGGetEncounterResults)
        end,
        SearchLFGGetJoinedID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SearchLFGGetJoinedID)
          end
          return checkCFunc(_G.SearchLFGGetJoinedID)
        end,
        SearchLFGGetNumResults = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SearchLFGGetNumResults)
          end
          return checkCFunc(_G.SearchLFGGetNumResults)
        end,
        SearchLFGGetPartyResults = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SearchLFGGetPartyResults)
          end
          return checkCFunc(_G.SearchLFGGetPartyResults)
        end,
        SearchLFGGetResults = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SearchLFGGetResults)
          end
          return checkCFunc(_G.SearchLFGGetResults)
        end,
        SearchLFGJoin = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SearchLFGJoin)
          end
          return checkCFunc(_G.SearchLFGJoin)
        end,
        SearchLFGLeave = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SearchLFGLeave)
          end
          return checkCFunc(_G.SearchLFGLeave)
        end,
        SearchLFGSort = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SearchLFGSort)
          end
          return checkCFunc(_G.SearchLFGSort)
        end,
        SecureCmdOptionParse = function()
          return checkCFunc(_G.SecureCmdOptionParse)
        end,
        SelectActiveQuest = function()
          return checkCFunc(_G.SelectActiveQuest)
        end,
        SelectAvailableQuest = function()
          return checkCFunc(_G.SelectAvailableQuest)
        end,
        SelectCraft = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SelectCraft)
          end
          return checkCFunc(_G.SelectCraft)
        end,
        SelectGossipActiveQuest = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SelectGossipActiveQuest)
          end
          return checkCFunc(_G.SelectGossipActiveQuest)
        end,
        SelectGossipAvailableQuest = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SelectGossipAvailableQuest)
          end
          return checkCFunc(_G.SelectGossipAvailableQuest)
        end,
        SelectGossipOption = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SelectGossipOption)
          end
          return checkCFunc(_G.SelectGossipOption)
        end,
        SelectQuestLogEntry = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SelectQuestLogEntry)
          end
          return checkCFunc(_G.SelectQuestLogEntry)
        end,
        SelectTradeSkill = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SelectTradeSkill)
          end
          return checkCFunc(_G.SelectTradeSkill)
        end,
        SelectTrainerService = function()
          return checkCFunc(_G.SelectTrainerService)
        end,
        SelectedRealmName = function()
          return checkCFunc(_G.SelectedRealmName)
        end,
        SellCursorItem = function()
          return checkCFunc(_G.SellCursorItem)
        end,
        SendChatMessage = function()
          return checkCFunc(_G.SendChatMessage)
        end,
        SendMail = function()
          return checkCFunc(_G.SendMail)
        end,
        SendSoRByText = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SendSoRByText)
          end
          return checkCFunc(_G.SendSoRByText)
        end,
        SendSubscriptionInterstitialResponse = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SendSubscriptionInterstitialResponse)
          end
          return checkCFunc(_G.SendSubscriptionInterstitialResponse)
        end,
        SendSystemMessage = function()
          return checkCFunc(_G.SendSystemMessage)
        end,
        SetAbandonQuest = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetAbandonQuest)
          end
          return checkCFunc(_G.SetAbandonQuest)
        end,
        SetAchievementComparisonUnit = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetAchievementComparisonUnit)
          end
          return checkCFunc(_G.SetAchievementComparisonUnit)
        end,
        SetAchievementSearchString = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetAchievementSearchString)
          end
          return checkCFunc(_G.SetAchievementSearchString)
        end,
        SetActionBarToggles = function()
          return checkCFunc(_G.SetActionBarToggles)
        end,
        SetActionUIButton = function()
          return checkCFunc(_G.SetActionUIButton)
        end,
        SetAddonVersionCheck = function()
          return checkCFunc(_G.SetAddonVersionCheck)
        end,
        SetAllowDangerousScripts = function()
          return checkCFunc(_G.SetAllowDangerousScripts)
        end,
        SetAllowLowLevelRaid = function()
          return checkCFunc(_G.SetAllowLowLevelRaid)
        end,
        SetArenaTeamRosterSelection = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetArenaTeamRosterSelection)
          end
          return checkCFunc(_G.SetArenaTeamRosterSelection)
        end,
        SetArenaTeamRosterShowOffline = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetArenaTeamRosterShowOffline)
          end
          return checkCFunc(_G.SetArenaTeamRosterShowOffline)
        end,
        SetAuctionsTabShowing = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetAuctionsTabShowing)
          end
          return checkCFunc(_G.SetAuctionsTabShowing)
        end,
        SetAutoDeclineGuildInvites = function()
          return checkCFunc(_G.SetAutoDeclineGuildInvites)
        end,
        SetBackpackAutosortDisabled = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetBackpackAutosortDisabled)
          end
          return checkCFunc(_G.SetBackpackAutosortDisabled)
        end,
        SetBagPortraitTexture = function()
          return checkCFunc(_G.SetBagPortraitTexture)
        end,
        SetBagSlotFlag = function()
          return checkCFunc(_G.SetBagSlotFlag)
        end,
        SetBankAutosortDisabled = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetBankAutosortDisabled)
          end
          return checkCFunc(_G.SetBankAutosortDisabled)
        end,
        SetBankBagSlotFlag = function()
          return checkCFunc(_G.SetBankBagSlotFlag)
        end,
        SetBarSlotFromIntro = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetBarSlotFromIntro)
          end
          return checkCFunc(_G.SetBarSlotFromIntro)
        end,
        SetBattlefieldScoreFaction = function()
          return checkCFunc(_G.SetBattlefieldScoreFaction)
        end,
        SetBinding = function()
          return checkCFunc(_G.SetBinding)
        end,
        SetBindingClick = function()
          return checkCFunc(_G.SetBindingClick)
        end,
        SetBindingItem = function()
          return checkCFunc(_G.SetBindingItem)
        end,
        SetBindingMacro = function()
          return checkCFunc(_G.SetBindingMacro)
        end,
        SetBindingSpell = function()
          return checkCFunc(_G.SetBindingSpell)
        end,
        SetCemeteryPreference = function()
          return checkCFunc(_G.SetCemeteryPreference)
        end,
        SetChannelOwner = function()
          return checkCFunc(_G.SetChannelOwner)
        end,
        SetChannelPassword = function()
          return checkCFunc(_G.SetChannelPassword)
        end,
        SetChatColorNameByClass = function()
          return checkCFunc(_G.SetChatColorNameByClass)
        end,
        SetChatWindowAlpha = function()
          return checkCFunc(_G.SetChatWindowAlpha)
        end,
        SetChatWindowColor = function()
          return checkCFunc(_G.SetChatWindowColor)
        end,
        SetChatWindowDocked = function()
          return checkCFunc(_G.SetChatWindowDocked)
        end,
        SetChatWindowLocked = function()
          return checkCFunc(_G.SetChatWindowLocked)
        end,
        SetChatWindowName = function()
          return checkCFunc(_G.SetChatWindowName)
        end,
        SetChatWindowSavedDimensions = function()
          return checkCFunc(_G.SetChatWindowSavedDimensions)
        end,
        SetChatWindowSavedPosition = function()
          return checkCFunc(_G.SetChatWindowSavedPosition)
        end,
        SetChatWindowShown = function()
          return checkCFunc(_G.SetChatWindowShown)
        end,
        SetChatWindowSize = function()
          return checkCFunc(_G.SetChatWindowSize)
        end,
        SetChatWindowUninteractable = function()
          return checkCFunc(_G.SetChatWindowUninteractable)
        end,
        SetConsoleKey = function()
          return checkCFunc(_G.SetConsoleKey)
        end,
        SetCraftFilter = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetCraftFilter)
          end
          return checkCFunc(_G.SetCraftFilter)
        end,
        SetCurrentGraphicsSetting = function()
          return checkCFunc(_G.SetCurrentGraphicsSetting)
        end,
        SetCurrentGuildBankTab = function()
          return checkCFunc(_G.SetCurrentGuildBankTab)
        end,
        SetCurrentTitle = function()
          return checkCFunc(_G.SetCurrentTitle)
        end,
        SetCursor = function()
          return checkCFunc(_G.SetCursor)
        end,
        SetCursorVirtualItem = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetCursorVirtualItem)
          end
          return checkCFunc(_G.SetCursorVirtualItem)
        end,
        SetDefaultVideoOptions = function()
          return checkCFunc(_G.SetDefaultVideoOptions)
        end,
        SetDungeonDifficultyID = function()
          return checkCFunc(_G.SetDungeonDifficultyID)
        end,
        SetEuropeanNumbers = function()
          return checkCFunc(_G.SetEuropeanNumbers)
        end,
        SetEveryoneIsAssistant = function()
          return checkCFunc(_G.SetEveryoneIsAssistant)
        end,
        SetFactionActive = function()
          return checkCFunc(_G.SetFactionActive)
        end,
        SetFactionInactive = function()
          return checkCFunc(_G.SetFactionInactive)
        end,
        SetFocusedAchievement = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetFocusedAchievement)
          end
          return checkCFunc(_G.SetFocusedAchievement)
        end,
        SetGamePadCursorControl = function()
          return checkCFunc(_G.SetGamePadCursorControl)
        end,
        SetGamePadFreeLook = function()
          return checkCFunc(_G.SetGamePadFreeLook)
        end,
        SetGuildBankTabInfo = function()
          return checkCFunc(_G.SetGuildBankTabInfo)
        end,
        SetGuildBankTabItemWithdraw = function()
          return checkCFunc(_G.SetGuildBankTabItemWithdraw)
        end,
        SetGuildBankTabPermissions = function()
          return checkCFunc(_G.SetGuildBankTabPermissions)
        end,
        SetGuildBankText = function()
          return checkCFunc(_G.SetGuildBankText)
        end,
        SetGuildBankWithdrawGoldLimit = function()
          return checkCFunc(_G.SetGuildBankWithdrawGoldLimit)
        end,
        SetGuildInfoText = function()
          return checkCFunc(_G.SetGuildInfoText)
        end,
        SetGuildMemberRank = function()
          return checkCFunc(_G.SetGuildMemberRank)
        end,
        SetGuildNewsFilter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetGuildNewsFilter)
          end
          return checkCFunc(_G.SetGuildNewsFilter)
        end,
        SetGuildRosterSelection = function()
          return checkCFunc(_G.SetGuildRosterSelection)
        end,
        SetGuildRosterShowOffline = function()
          return checkCFunc(_G.SetGuildRosterShowOffline)
        end,
        SetGuildTradeSkillCategoryFilter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetGuildTradeSkillCategoryFilter)
          end
          return checkCFunc(_G.SetGuildTradeSkillCategoryFilter)
        end,
        SetGuildTradeSkillItemNameFilter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetGuildTradeSkillItemNameFilter)
          end
          return checkCFunc(_G.SetGuildTradeSkillItemNameFilter)
        end,
        SetInWorldUIVisibility = function()
          return checkCFunc(_G.SetInWorldUIVisibility)
        end,
        SetInsertItemsLeftToRight = function()
          return checkCFunc(_G.SetInsertItemsLeftToRight)
        end,
        SetInventoryPortraitTexture = function()
          return checkCFunc(_G.SetInventoryPortraitTexture)
        end,
        SetItemSearch = function()
          return checkCFunc(_G.SetItemSearch)
        end,
        SetLFGBootVote = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetLFGBootVote)
          end
          return checkCFunc(_G.SetLFGBootVote)
        end,
        SetLFGComment = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetLFGComment)
          end
          return checkCFunc(_G.SetLFGComment)
        end,
        SetLFGDungeon = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetLFGDungeon)
          end
          return checkCFunc(_G.SetLFGDungeon)
        end,
        SetLFGDungeonEnabled = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetLFGDungeonEnabled)
          end
          return checkCFunc(_G.SetLFGDungeonEnabled)
        end,
        SetLFGHeaderCollapsed = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetLFGHeaderCollapsed)
          end
          return checkCFunc(_G.SetLFGHeaderCollapsed)
        end,
        SetLFGRoles = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetLFGRoles)
          end
          return checkCFunc(_G.SetLFGRoles)
        end,
        SetLegacyRaidDifficultyID = function()
          return checkCFunc(_G.SetLegacyRaidDifficultyID)
        end,
        SetLootMethod = function()
          return checkCFunc(_G.SetLootMethod)
        end,
        SetLootPortrait = function()
          return checkCFunc(_G.SetLootPortrait)
        end,
        SetLootSpecialization = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetLootSpecialization)
          end
          return checkCFunc(_G.SetLootSpecialization)
        end,
        SetLootThreshold = function()
          return checkCFunc(_G.SetLootThreshold)
        end,
        SetMacroItem = function()
          return checkCFunc(_G.SetMacroItem)
        end,
        SetMacroSpell = function()
          return checkCFunc(_G.SetMacroSpell)
        end,
        SetMerchantFilter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetMerchantFilter)
          end
          return checkCFunc(_G.SetMerchantFilter)
        end,
        SetModifiedClick = function()
          return checkCFunc(_G.SetModifiedClick)
        end,
        SetMouselookOverrideBinding = function()
          return checkCFunc(_G.SetMouselookOverrideBinding)
        end,
        SetMoveEnabled = function()
          return checkCFunc(_G.SetMoveEnabled)
        end,
        SetMultiCastSpell = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetMultiCastSpell)
          end
          return checkCFunc(_G.SetMultiCastSpell)
        end,
        SetOptOutOfLoot = function()
          return checkCFunc(_G.SetOptOutOfLoot)
        end,
        SetOverrideBinding = function()
          return checkCFunc(_G.SetOverrideBinding)
        end,
        SetOverrideBindingClick = function()
          return checkCFunc(_G.SetOverrideBindingClick)
        end,
        SetOverrideBindingItem = function()
          return checkCFunc(_G.SetOverrideBindingItem)
        end,
        SetOverrideBindingMacro = function()
          return checkCFunc(_G.SetOverrideBindingMacro)
        end,
        SetOverrideBindingSpell = function()
          return checkCFunc(_G.SetOverrideBindingSpell)
        end,
        SetPOIIconOverlapDistance = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetPOIIconOverlapDistance)
          end
          return checkCFunc(_G.SetPOIIconOverlapDistance)
        end,
        SetPOIIconOverlapPushDistance = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetPOIIconOverlapPushDistance)
          end
          return checkCFunc(_G.SetPOIIconOverlapPushDistance)
        end,
        SetPVP = function()
          return checkCFunc(_G.SetPVP)
        end,
        SetPVPRoles = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetPVPRoles)
          end
          return checkCFunc(_G.SetPVPRoles)
        end,
        SetPartyAssignment = function()
          return checkCFunc(_G.SetPartyAssignment)
        end,
        SetPendingReportArenaTeamName = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetPendingReportArenaTeamName)
          end
          return checkCFunc(_G.SetPendingReportArenaTeamName)
        end,
        SetPendingReportPetTarget = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetPendingReportPetTarget)
          end
          return checkCFunc(_G.SetPendingReportPetTarget)
        end,
        SetPendingReportTarget = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetPendingReportTarget)
          end
          return checkCFunc(_G.SetPendingReportTarget)
        end,
        SetPetSlot = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetPetSlot)
          end
          return checkCFunc(_G.SetPetSlot)
        end,
        SetPetStablePaperdoll = function()
          return checkCFunc(_G.SetPetStablePaperdoll)
        end,
        SetPortraitTexture = function()
          return checkCFunc(_G.SetPortraitTexture)
        end,
        SetPortraitTextureFromCreatureDisplayID = function()
          return checkCFunc(_G.SetPortraitTextureFromCreatureDisplayID)
        end,
        SetPortraitToTexture = function()
          return checkCFunc(_G.SetPortraitToTexture)
        end,
        SetRaidDifficultyID = function()
          return checkCFunc(_G.SetRaidDifficultyID)
        end,
        SetRaidProfileOption = function()
          return checkCFunc(_G.SetRaidProfileOption)
        end,
        SetRaidProfileSavedPosition = function()
          return checkCFunc(_G.SetRaidProfileSavedPosition)
        end,
        SetRaidSubgroup = function()
          return checkCFunc(_G.SetRaidSubgroup)
        end,
        SetRaidTarget = function()
          return checkCFunc(_G.SetRaidTarget)
        end,
        SetRaidTargetProtected = function()
          return checkCFunc(_G.SetRaidTargetProtected)
        end,
        SetSavedInstanceExtend = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetSavedInstanceExtend)
          end
          return checkCFunc(_G.SetSavedInstanceExtend)
        end,
        SetScreenResolution = function()
          return checkCFunc(_G.SetScreenResolution)
        end,
        SetSelectedArtifact = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetSelectedArtifact)
          end
          return checkCFunc(_G.SetSelectedArtifact)
        end,
        SetSelectedAuctionItem = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetSelectedAuctionItem)
          end
          return checkCFunc(_G.SetSelectedAuctionItem)
        end,
        SetSelectedBattlefield = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetSelectedBattlefield)
          end
          return checkCFunc(_G.SetSelectedBattlefield)
        end,
        SetSelectedDisplayChannel = function()
          return checkCFunc(_G.SetSelectedDisplayChannel)
        end,
        SetSelectedFaction = function()
          return checkCFunc(_G.SetSelectedFaction)
        end,
        SetSelectedScreenResolutionIndex = function()
          return checkCFunc(_G.SetSelectedScreenResolutionIndex)
        end,
        SetSelectedSkill = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetSelectedSkill)
          end
          return checkCFunc(_G.SetSelectedSkill)
        end,
        SetSelectedWarGameType = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetSelectedWarGameType)
          end
          return checkCFunc(_G.SetSelectedWarGameType)
        end,
        SetSendMailCOD = function()
          return checkCFunc(_G.SetSendMailCOD)
        end,
        SetSendMailMoney = function()
          return checkCFunc(_G.SetSendMailMoney)
        end,
        SetSendMailShowing = function()
          return checkCFunc(_G.SetSendMailShowing)
        end,
        SetSortBagsRightToLeft = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetSortBagsRightToLeft)
          end
          return checkCFunc(_G.SetSortBagsRightToLeft)
        end,
        SetSpecialization = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetSpecialization)
          end
          return checkCFunc(_G.SetSpecialization)
        end,
        SetSpellbookPetAction = function()
          return checkCFunc(_G.SetSpellbookPetAction)
        end,
        SetSuperTrackedQuestID = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetSuperTrackedQuestID)
          end
          return checkCFunc(_G.SetSuperTrackedQuestID)
        end,
        SetTaxiBenchmarkMode = function()
          return checkCFunc(_G.SetTaxiBenchmarkMode)
        end,
        SetTaxiMap = function()
          return checkCFunc(_G.SetTaxiMap)
        end,
        SetTracking = function()
          return checkCFunc(_G.SetTracking)
        end,
        SetTradeCurrency = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetTradeCurrency)
          end
          return checkCFunc(_G.SetTradeCurrency)
        end,
        SetTradeMoney = function()
          return checkCFunc(_G.SetTradeMoney)
        end,
        SetTradeSkillInvSlotFilter = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetTradeSkillInvSlotFilter)
          end
          return checkCFunc(_G.SetTradeSkillInvSlotFilter)
        end,
        SetTradeSkillItemLevelFilter = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetTradeSkillItemLevelFilter)
          end
          return checkCFunc(_G.SetTradeSkillItemLevelFilter)
        end,
        SetTradeSkillItemNameFilter = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetTradeSkillItemNameFilter)
          end
          return checkCFunc(_G.SetTradeSkillItemNameFilter)
        end,
        SetTradeSkillSubClassFilter = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SetTradeSkillSubClassFilter)
          end
          return checkCFunc(_G.SetTradeSkillSubClassFilter)
        end,
        SetTrainerServiceTypeFilter = function()
          return checkCFunc(_G.SetTrainerServiceTypeFilter)
        end,
        SetTurnEnabled = function()
          return checkCFunc(_G.SetTurnEnabled)
        end,
        SetUIVisibility = function()
          return checkCFunc(_G.SetUIVisibility)
        end,
        SetView = function()
          return checkCFunc(_G.SetView)
        end,
        SetWatchedFactionIndex = function()
          return checkCFunc(_G.SetWatchedFactionIndex)
        end,
        SetupFullscreenScale = function()
          return checkCFunc(_G.SetupFullscreenScale)
        end,
        ShouldKnowUnitHealth = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ShouldKnowUnitHealth)
          end
          return checkCFunc(_G.ShouldKnowUnitHealth)
        end,
        ShouldShowIslandsWeeklyPOI = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ShouldShowIslandsWeeklyPOI)
          end
          return checkCFunc(_G.ShouldShowIslandsWeeklyPOI)
        end,
        ShouldShowSpecialSplashScreen = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ShouldShowSpecialSplashScreen)
          end
          return checkCFunc(_G.ShouldShowSpecialSplashScreen)
        end,
        ShowAccountAchievements = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ShowAccountAchievements)
          end
          return checkCFunc(_G.ShowAccountAchievements)
        end,
        ShowBossFrameWhenUninteractable = function()
          return checkCFunc(_G.ShowBossFrameWhenUninteractable)
        end,
        ShowBuybackSellCursor = function()
          return checkCFunc(_G.ShowBuybackSellCursor)
        end,
        ShowCloak = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ShowCloak)
          end
          return checkCFunc(_G.ShowCloak)
        end,
        ShowContainerSellCursor = function()
          return checkCFunc(_G.ShowContainerSellCursor)
        end,
        ShowHelm = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ShowHelm)
          end
          return checkCFunc(_G.ShowHelm)
        end,
        ShowInventorySellCursor = function()
          return checkCFunc(_G.ShowInventorySellCursor)
        end,
        ShowQuestComplete = function()
          return checkCFunc(_G.ShowQuestComplete)
        end,
        ShowQuestOffer = function()
          return checkCFunc(_G.ShowQuestOffer)
        end,
        ShowRepairCursor = function()
          return checkCFunc(_G.ShowRepairCursor)
        end,
        ShowingCloak = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ShowingCloak)
          end
          return checkCFunc(_G.ShowingCloak)
        end,
        ShowingHelm = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ShowingHelm)
          end
          return checkCFunc(_G.ShowingHelm)
        end,
        SignPetition = function()
          return checkCFunc(_G.SignPetition)
        end,
        SitStandOrDescendStart = function()
          return checkCFunc(_G.SitStandOrDescendStart)
        end,
        SocketContainerItem = function()
          return checkCFunc(_G.SocketContainerItem)
        end,
        SocketInventoryItem = function()
          return checkCFunc(_G.SocketInventoryItem)
        end,
        SocketItemToArtifact = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SocketItemToArtifact)
          end
          return checkCFunc(_G.SocketItemToArtifact)
        end,
        SolveArtifact = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SolveArtifact)
          end
          return checkCFunc(_G.SolveArtifact)
        end,
        SortArenaTeamRoster = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SortArenaTeamRoster)
          end
          return checkCFunc(_G.SortArenaTeamRoster)
        end,
        SortAuctionApplySort = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SortAuctionApplySort)
          end
          return checkCFunc(_G.SortAuctionApplySort)
        end,
        SortAuctionClearSort = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SortAuctionClearSort)
          end
          return checkCFunc(_G.SortAuctionClearSort)
        end,
        SortAuctionItems = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SortAuctionItems)
          end
          return checkCFunc(_G.SortAuctionItems)
        end,
        SortAuctionSetSort = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SortAuctionSetSort)
          end
          return checkCFunc(_G.SortAuctionSetSort)
        end,
        SortBGList = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SortBGList)
          end
          return checkCFunc(_G.SortBGList)
        end,
        SortBags = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SortBags)
          end
          return checkCFunc(_G.SortBags)
        end,
        SortBankBags = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SortBankBags)
          end
          return checkCFunc(_G.SortBankBags)
        end,
        SortBattlefieldScoreData = function()
          return checkCFunc(_G.SortBattlefieldScoreData)
        end,
        SortGuildRoster = function()
          return checkCFunc(_G.SortGuildRoster)
        end,
        SortGuildTradeSkill = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SortGuildTradeSkill)
          end
          return checkCFunc(_G.SortGuildTradeSkill)
        end,
        SortQuestSortTypes = function()
          return checkCFunc(_G.SortQuestSortTypes)
        end,
        SortQuestWatches = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SortQuestWatches)
          end
          return checkCFunc(_G.SortQuestWatches)
        end,
        SortQuests = function()
          return checkCFunc(_G.SortQuests)
        end,
        SortReagentBankBags = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SortReagentBankBags)
          end
          return checkCFunc(_G.SortReagentBankBags)
        end,
        Sound_ChatSystem_GetInputDriverNameByIndex = function()
          return checkCFunc(_G.Sound_ChatSystem_GetInputDriverNameByIndex)
        end,
        Sound_ChatSystem_GetNumInputDrivers = function()
          return checkCFunc(_G.Sound_ChatSystem_GetNumInputDrivers)
        end,
        Sound_ChatSystem_GetNumOutputDrivers = function()
          return checkCFunc(_G.Sound_ChatSystem_GetNumOutputDrivers)
        end,
        Sound_ChatSystem_GetOutputDriverNameByIndex = function()
          return checkCFunc(_G.Sound_ChatSystem_GetOutputDriverNameByIndex)
        end,
        Sound_GameSystem_GetInputDriverNameByIndex = function()
          return checkCFunc(_G.Sound_GameSystem_GetInputDriverNameByIndex)
        end,
        Sound_GameSystem_GetNumInputDrivers = function()
          return checkCFunc(_G.Sound_GameSystem_GetNumInputDrivers)
        end,
        Sound_GameSystem_GetNumOutputDrivers = function()
          return checkCFunc(_G.Sound_GameSystem_GetNumOutputDrivers)
        end,
        Sound_GameSystem_GetOutputDriverNameByIndex = function()
          return checkCFunc(_G.Sound_GameSystem_GetOutputDriverNameByIndex)
        end,
        Sound_GameSystem_RestartSoundSystem = function()
          return checkCFunc(_G.Sound_GameSystem_RestartSoundSystem)
        end,
        SpellCanTargetGarrisonFollower = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SpellCanTargetGarrisonFollower)
          end
          return checkCFunc(_G.SpellCanTargetGarrisonFollower)
        end,
        SpellCanTargetGarrisonFollowerAbility = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SpellCanTargetGarrisonFollowerAbility)
          end
          return checkCFunc(_G.SpellCanTargetGarrisonFollowerAbility)
        end,
        SpellCanTargetGarrisonMission = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SpellCanTargetGarrisonMission)
          end
          return checkCFunc(_G.SpellCanTargetGarrisonMission)
        end,
        SpellCanTargetItem = function()
          return checkCFunc(_G.SpellCanTargetItem)
        end,
        SpellCanTargetItemID = function()
          return checkCFunc(_G.SpellCanTargetItemID)
        end,
        SpellCanTargetQuest = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SpellCanTargetQuest)
          end
          return checkCFunc(_G.SpellCanTargetQuest)
        end,
        SpellCanTargetUnit = function()
          return checkCFunc(_G.SpellCanTargetUnit)
        end,
        SpellCancelQueuedSpell = function()
          return checkCFunc(_G.SpellCancelQueuedSpell)
        end,
        SpellGetVisibilityInfo = function()
          return checkCFunc(_G.SpellGetVisibilityInfo)
        end,
        SpellHasRange = function()
          return checkCFunc(_G.SpellHasRange)
        end,
        SpellIsAlwaysShown = function()
          return checkCFunc(_G.SpellIsAlwaysShown)
        end,
        SpellIsPriorityAura = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SpellIsPriorityAura)
          end
          return checkCFunc(_G.SpellIsPriorityAura)
        end,
        SpellIsSelfBuff = function()
          return checkCFunc(_G.SpellIsSelfBuff)
        end,
        SpellIsTargeting = function()
          return checkCFunc(_G.SpellIsTargeting)
        end,
        SpellStopCasting = function()
          return checkCFunc(_G.SpellStopCasting)
        end,
        SpellStopTargeting = function()
          return checkCFunc(_G.SpellStopTargeting)
        end,
        SpellTargetItem = function()
          return checkCFunc(_G.SpellTargetItem)
        end,
        SpellTargetUnit = function()
          return checkCFunc(_G.SpellTargetUnit)
        end,
        SplashFrameCanBeShown = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SplashFrameCanBeShown)
          end
          return checkCFunc(_G.SplashFrameCanBeShown)
        end,
        SplitContainerItem = function()
          return checkCFunc(_G.SplitContainerItem)
        end,
        SplitGuildBankItem = function()
          return checkCFunc(_G.SplitGuildBankItem)
        end,
        StablePet = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.StablePet)
          end
          return checkCFunc(_G.StablePet)
        end,
        StartAttack = function()
          return checkCFunc(_G.StartAttack)
        end,
        StartAuction = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.StartAuction)
          end
          return checkCFunc(_G.StartAuction)
        end,
        StartAutoRun = function()
          return checkCFunc(_G.StartAutoRun)
        end,
        StartDuel = function()
          return checkCFunc(_G.StartDuel)
        end,
        StartSoloShuffleWarGameByName = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.StartSoloShuffleWarGameByName)
          end
          return checkCFunc(_G.StartSoloShuffleWarGameByName)
        end,
        StartSpectatorSoloShuffleWarGame = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.StartSpectatorSoloShuffleWarGame)
          end
          return checkCFunc(_G.StartSpectatorSoloShuffleWarGame)
        end,
        StartSpectatorWarGame = function()
          return checkCFunc(_G.StartSpectatorWarGame)
        end,
        StartWarGame = function()
          return checkCFunc(_G.StartWarGame)
        end,
        StartWarGameByName = function()
          return checkCFunc(_G.StartWarGameByName)
        end,
        StopAttack = function()
          return checkCFunc(_G.StopAttack)
        end,
        StopAutoRun = function()
          return checkCFunc(_G.StopAutoRun)
        end,
        StopCinematic = function()
          return checkCFunc(_G.StopCinematic)
        end,
        StopMacro = function()
          return checkCFunc(_G.StopMacro)
        end,
        StopMusic = function()
          return checkCFunc(_G.StopMusic)
        end,
        StopSound = function()
          return checkCFunc(_G.StopSound)
        end,
        StoreSecureReference = function()
          return checkCFunc(_G.StoreSecureReference)
        end,
        StrafeLeftStart = function()
          return checkCFunc(_G.StrafeLeftStart)
        end,
        StrafeLeftStop = function()
          return checkCFunc(_G.StrafeLeftStop)
        end,
        StrafeRightStart = function()
          return checkCFunc(_G.StrafeRightStart)
        end,
        StrafeRightStop = function()
          return checkCFunc(_G.StrafeRightStop)
        end,
        Stuck = function()
          return checkCFunc(_G.Stuck)
        end,
        SubmitRequiredGuildRename = function()
          return checkCFunc(_G.SubmitRequiredGuildRename)
        end,
        SummonFriend = function()
          return checkCFunc(_G.SummonFriend)
        end,
        SummonRandomCritter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SummonRandomCritter)
          end
          return checkCFunc(_G.SummonRandomCritter)
        end,
        SupportsClipCursor = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SupportsClipCursor)
          end
          return checkCFunc(_G.SupportsClipCursor)
        end,
        SurrenderArena = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SurrenderArena)
          end
          return checkCFunc(_G.SurrenderArena)
        end,
        SwapRaidSubgroup = function()
          return checkCFunc(_G.SwapRaidSubgroup)
        end,
        SwitchAchievementSearchTab = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.SwitchAchievementSearchTab)
          end
          return checkCFunc(_G.SwitchAchievementSearchTab)
        end,
        TakeInboxItem = function()
          return checkCFunc(_G.TakeInboxItem)
        end,
        TakeInboxMoney = function()
          return checkCFunc(_G.TakeInboxMoney)
        end,
        TakeInboxTextItem = function()
          return checkCFunc(_G.TakeInboxTextItem)
        end,
        TakeTaxiNode = function()
          return checkCFunc(_G.TakeTaxiNode)
        end,
        TargetDirectionEnemy = function()
          return checkCFunc(_G.TargetDirectionEnemy)
        end,
        TargetDirectionFinished = function()
          return checkCFunc(_G.TargetDirectionFinished)
        end,
        TargetDirectionFriend = function()
          return checkCFunc(_G.TargetDirectionFriend)
        end,
        TargetLastEnemy = function()
          return checkCFunc(_G.TargetLastEnemy)
        end,
        TargetLastFriend = function()
          return checkCFunc(_G.TargetLastFriend)
        end,
        TargetLastTarget = function()
          return checkCFunc(_G.TargetLastTarget)
        end,
        TargetNearest = function()
          return checkCFunc(_G.TargetNearest)
        end,
        TargetNearestEnemy = function()
          return checkCFunc(_G.TargetNearestEnemy)
        end,
        TargetNearestEnemyPlayer = function()
          return checkCFunc(_G.TargetNearestEnemyPlayer)
        end,
        TargetNearestFriend = function()
          return checkCFunc(_G.TargetNearestFriend)
        end,
        TargetNearestFriendPlayer = function()
          return checkCFunc(_G.TargetNearestFriendPlayer)
        end,
        TargetNearestPartyMember = function()
          return checkCFunc(_G.TargetNearestPartyMember)
        end,
        TargetNearestRaidMember = function()
          return checkCFunc(_G.TargetNearestRaidMember)
        end,
        TargetPriorityHighlightEnd = function()
          return checkCFunc(_G.TargetPriorityHighlightEnd)
        end,
        TargetPriorityHighlightStart = function()
          return checkCFunc(_G.TargetPriorityHighlightStart)
        end,
        TargetSpellReplacesBonusTree = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.TargetSpellReplacesBonusTree)
          end
          return checkCFunc(_G.TargetSpellReplacesBonusTree)
        end,
        TargetTotem = function()
          return checkCFunc(_G.TargetTotem)
        end,
        TargetUnit = function()
          return checkCFunc(_G.TargetUnit)
        end,
        TaxiGetDestX = function()
          return checkCFunc(_G.TaxiGetDestX)
        end,
        TaxiGetDestY = function()
          return checkCFunc(_G.TaxiGetDestY)
        end,
        TaxiGetNodeSlot = function()
          return checkCFunc(_G.TaxiGetNodeSlot)
        end,
        TaxiGetSrcX = function()
          return checkCFunc(_G.TaxiGetSrcX)
        end,
        TaxiGetSrcY = function()
          return checkCFunc(_G.TaxiGetSrcY)
        end,
        TaxiIsDirectFlight = function()
          return checkCFunc(_G.TaxiIsDirectFlight)
        end,
        TaxiNodeCost = function()
          return checkCFunc(_G.TaxiNodeCost)
        end,
        TaxiNodeGetType = function()
          return checkCFunc(_G.TaxiNodeGetType)
        end,
        TaxiNodeName = function()
          return checkCFunc(_G.TaxiNodeName)
        end,
        TaxiNodePosition = function()
          return checkCFunc(_G.TaxiNodePosition)
        end,
        TaxiRequestEarlyLanding = function()
          return checkCFunc(_G.TaxiRequestEarlyLanding)
        end,
        TimeoutResurrect = function()
          return checkCFunc(_G.TimeoutResurrect)
        end,
        ToggleAnimKitDisplay = function()
          return checkCFunc(_G.ToggleAnimKitDisplay)
        end,
        ToggleAutoRun = function()
          return checkCFunc(_G.ToggleAutoRun)
        end,
        ToggleDebugAIDisplay = function()
          return checkCFunc(_G.ToggleDebugAIDisplay)
        end,
        TogglePVP = function()
          return checkCFunc(_G.TogglePVP)
        end,
        TogglePetAutocast = function()
          return checkCFunc(_G.TogglePetAutocast)
        end,
        ToggleRun = function()
          return checkCFunc(_G.ToggleRun)
        end,
        ToggleSelfHighlight = function()
          return checkCFunc(_G.ToggleSelfHighlight)
        end,
        ToggleSheath = function()
          return checkCFunc(_G.ToggleSheath)
        end,
        ToggleSpellAutocast = function()
          return checkCFunc(_G.ToggleSpellAutocast)
        end,
        ToggleWindowed = function()
          return checkCFunc(_G.ToggleWindowed)
        end,
        TradeSkillOnlyShowMakeable = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.TradeSkillOnlyShowMakeable)
          end
          return checkCFunc(_G.TradeSkillOnlyShowMakeable)
        end,
        TriggerTutorial = function()
          return checkCFunc(_G.TriggerTutorial)
        end,
        TurnInArenaPetition = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.TurnInArenaPetition)
          end
          return checkCFunc(_G.TurnInArenaPetition)
        end,
        TurnInGuildCharter = function()
          return checkCFunc(_G.TurnInGuildCharter)
        end,
        TurnLeftStart = function()
          return checkCFunc(_G.TurnLeftStart)
        end,
        TurnLeftStop = function()
          return checkCFunc(_G.TurnLeftStop)
        end,
        TurnOrActionStart = function()
          return checkCFunc(_G.TurnOrActionStart)
        end,
        TurnOrActionStop = function()
          return checkCFunc(_G.TurnOrActionStop)
        end,
        TurnRightStart = function()
          return checkCFunc(_G.TurnRightStart)
        end,
        TurnRightStop = function()
          return checkCFunc(_G.TurnRightStop)
        end,
        UninviteUnit = function()
          return checkCFunc(_G.UninviteUnit)
        end,
        UnitAffectingCombat = function()
          return checkCFunc(_G.UnitAffectingCombat)
        end,
        UnitAlliedRaceInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitAlliedRaceInfo)
          end
          return checkCFunc(_G.UnitAlliedRaceInfo)
        end,
        UnitArmor = function()
          return checkCFunc(_G.UnitArmor)
        end,
        UnitAttackBothHands = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitAttackBothHands)
          end
          return checkCFunc(_G.UnitAttackBothHands)
        end,
        UnitAttackPower = function()
          return checkCFunc(_G.UnitAttackPower)
        end,
        UnitAttackSpeed = function()
          return checkCFunc(_G.UnitAttackSpeed)
        end,
        UnitAura = function()
          return checkCFunc(_G.UnitAura)
        end,
        UnitAuraBySlot = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitAuraBySlot)
          end
          return checkCFunc(_G.UnitAuraBySlot)
        end,
        UnitAuraSlots = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitAuraSlots)
          end
          return checkCFunc(_G.UnitAuraSlots)
        end,
        UnitBattlePetLevel = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitBattlePetLevel)
          end
          return checkCFunc(_G.UnitBattlePetLevel)
        end,
        UnitBattlePetSpeciesID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitBattlePetSpeciesID)
          end
          return checkCFunc(_G.UnitBattlePetSpeciesID)
        end,
        UnitBattlePetType = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitBattlePetType)
          end
          return checkCFunc(_G.UnitBattlePetType)
        end,
        UnitBuff = function()
          return checkCFunc(_G.UnitBuff)
        end,
        UnitCanAssist = function()
          return checkCFunc(_G.UnitCanAssist)
        end,
        UnitCanAttack = function()
          return checkCFunc(_G.UnitCanAttack)
        end,
        UnitCanCooperate = function()
          return checkCFunc(_G.UnitCanCooperate)
        end,
        UnitCanPetBattle = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitCanPetBattle)
          end
          return checkCFunc(_G.UnitCanPetBattle)
        end,
        UnitCastingInfo = function()
          return checkCFunc(_G.UnitCastingInfo)
        end,
        UnitChannelInfo = function()
          return checkCFunc(_G.UnitChannelInfo)
        end,
        UnitCharacterPoints = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitCharacterPoints)
          end
          return checkCFunc(_G.UnitCharacterPoints)
        end,
        UnitChromieTimeID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitChromieTimeID)
          end
          return checkCFunc(_G.UnitChromieTimeID)
        end,
        UnitClass = function()
          return checkCFunc(_G.UnitClass)
        end,
        UnitClassBase = function()
          return checkCFunc(_G.UnitClassBase)
        end,
        UnitClassification = function()
          return checkCFunc(_G.UnitClassification)
        end,
        UnitControllingVehicle = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitControllingVehicle)
          end
          return checkCFunc(_G.UnitControllingVehicle)
        end,
        UnitCreatureFamily = function()
          return checkCFunc(_G.UnitCreatureFamily)
        end,
        UnitCreatureType = function()
          return checkCFunc(_G.UnitCreatureType)
        end,
        UnitDamage = function()
          return checkCFunc(_G.UnitDamage)
        end,
        UnitDebuff = function()
          return checkCFunc(_G.UnitDebuff)
        end,
        UnitDefense = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitDefense)
          end
          return checkCFunc(_G.UnitDefense)
        end,
        UnitDetailedThreatSituation = function()
          return checkCFunc(_G.UnitDetailedThreatSituation)
        end,
        UnitDistanceSquared = function()
          return checkCFunc(_G.UnitDistanceSquared)
        end,
        UnitEffectiveLevel = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitEffectiveLevel)
          end
          return checkCFunc(_G.UnitEffectiveLevel)
        end,
        UnitExists = function()
          return checkCFunc(_G.UnitExists)
        end,
        UnitFactionGroup = function()
          return checkCFunc(_G.UnitFactionGroup)
        end,
        UnitFullName = function()
          return checkCFunc(_G.UnitFullName)
        end,
        UnitGUID = function()
          return checkCFunc(_G.UnitGUID)
        end,
        UnitGetAvailableRoles = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitGetAvailableRoles)
          end
          return checkCFunc(_G.UnitGetAvailableRoles)
        end,
        UnitGetIncomingHeals = function()
          return checkCFunc(_G.UnitGetIncomingHeals)
        end,
        UnitGetTotalAbsorbs = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitGetTotalAbsorbs)
          end
          return checkCFunc(_G.UnitGetTotalAbsorbs)
        end,
        UnitGetTotalHealAbsorbs = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitGetTotalHealAbsorbs)
          end
          return checkCFunc(_G.UnitGetTotalHealAbsorbs)
        end,
        UnitGroupRolesAssigned = function()
          return checkCFunc(_G.UnitGroupRolesAssigned)
        end,
        UnitHPPerStamina = function()
          return checkCFunc(_G.UnitHPPerStamina)
        end,
        UnitHasIncomingResurrection = function()
          return checkCFunc(_G.UnitHasIncomingResurrection)
        end,
        UnitHasLFGDeserter = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitHasLFGDeserter)
          end
          return checkCFunc(_G.UnitHasLFGDeserter)
        end,
        UnitHasLFGRandomCooldown = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitHasLFGRandomCooldown)
          end
          return checkCFunc(_G.UnitHasLFGRandomCooldown)
        end,
        UnitHasRelicSlot = function()
          return checkCFunc(_G.UnitHasRelicSlot)
        end,
        UnitHasVehiclePlayerFrameUI = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitHasVehiclePlayerFrameUI)
          end
          return checkCFunc(_G.UnitHasVehiclePlayerFrameUI)
        end,
        UnitHasVehicleUI = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitHasVehicleUI)
          end
          return checkCFunc(_G.UnitHasVehicleUI)
        end,
        UnitHealth = function()
          return checkCFunc(_G.UnitHealth)
        end,
        UnitHealthMax = function()
          return checkCFunc(_G.UnitHealthMax)
        end,
        UnitHonor = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitHonor)
          end
          return checkCFunc(_G.UnitHonor)
        end,
        UnitHonorLevel = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitHonorLevel)
          end
          return checkCFunc(_G.UnitHonorLevel)
        end,
        UnitHonorMax = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitHonorMax)
          end
          return checkCFunc(_G.UnitHonorMax)
        end,
        UnitInAnyGroup = function()
          return checkCFunc(_G.UnitInAnyGroup)
        end,
        UnitInBattleground = function()
          return checkCFunc(_G.UnitInBattleground)
        end,
        UnitInOtherParty = function()
          return checkCFunc(_G.UnitInOtherParty)
        end,
        UnitInParty = function()
          return checkCFunc(_G.UnitInParty)
        end,
        UnitInPartyShard = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitInPartyShard)
          end
          return checkCFunc(_G.UnitInPartyShard)
        end,
        UnitInPhase = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitInPhase)
          end
          return checkCFunc(_G.UnitInPhase)
        end,
        UnitInRaid = function()
          return checkCFunc(_G.UnitInRaid)
        end,
        UnitInRange = function()
          return checkCFunc(_G.UnitInRange)
        end,
        UnitInSubgroup = function()
          return checkCFunc(_G.UnitInSubgroup)
        end,
        UnitInVehicle = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitInVehicle)
          end
          return checkCFunc(_G.UnitInVehicle)
        end,
        UnitInVehicleControlSeat = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitInVehicleControlSeat)
          end
          return checkCFunc(_G.UnitInVehicleControlSeat)
        end,
        UnitInVehicleHidesPetFrame = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitInVehicleHidesPetFrame)
          end
          return checkCFunc(_G.UnitInVehicleHidesPetFrame)
        end,
        UnitIsAFK = function()
          return checkCFunc(_G.UnitIsAFK)
        end,
        UnitIsBattlePet = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitIsBattlePet)
          end
          return checkCFunc(_G.UnitIsBattlePet)
        end,
        UnitIsBattlePetCompanion = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitIsBattlePetCompanion)
          end
          return checkCFunc(_G.UnitIsBattlePetCompanion)
        end,
        UnitIsCharmed = function()
          return checkCFunc(_G.UnitIsCharmed)
        end,
        UnitIsCivilian = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitIsCivilian)
          end
          return checkCFunc(_G.UnitIsCivilian)
        end,
        UnitIsConnected = function()
          return checkCFunc(_G.UnitIsConnected)
        end,
        UnitIsControlling = function()
          return checkCFunc(_G.UnitIsControlling)
        end,
        UnitIsCorpse = function()
          return checkCFunc(_G.UnitIsCorpse)
        end,
        UnitIsDND = function()
          return checkCFunc(_G.UnitIsDND)
        end,
        UnitIsDead = function()
          return checkCFunc(_G.UnitIsDead)
        end,
        UnitIsDeadOrGhost = function()
          return checkCFunc(_G.UnitIsDeadOrGhost)
        end,
        UnitIsEnemy = function()
          return checkCFunc(_G.UnitIsEnemy)
        end,
        UnitIsFeignDeath = function()
          return checkCFunc(_G.UnitIsFeignDeath)
        end,
        UnitIsFriend = function()
          return checkCFunc(_G.UnitIsFriend)
        end,
        UnitIsGhost = function()
          return checkCFunc(_G.UnitIsGhost)
        end,
        UnitIsGroupAssistant = function()
          return checkCFunc(_G.UnitIsGroupAssistant)
        end,
        UnitIsGroupLeader = function()
          return checkCFunc(_G.UnitIsGroupLeader)
        end,
        UnitIsInMyGuild = function()
          return checkCFunc(_G.UnitIsInMyGuild)
        end,
        UnitIsMercenary = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitIsMercenary)
          end
          return checkCFunc(_G.UnitIsMercenary)
        end,
        UnitIsOtherPlayersBattlePet = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitIsOtherPlayersBattlePet)
          end
          return checkCFunc(_G.UnitIsOtherPlayersBattlePet)
        end,
        UnitIsOtherPlayersPet = function()
          return checkCFunc(_G.UnitIsOtherPlayersPet)
        end,
        UnitIsOwnerOrControllerOfUnit = function()
          return checkCFunc(_G.UnitIsOwnerOrControllerOfUnit)
        end,
        UnitIsPVP = function()
          return checkCFunc(_G.UnitIsPVP)
        end,
        UnitIsPVPFreeForAll = function()
          return checkCFunc(_G.UnitIsPVPFreeForAll)
        end,
        UnitIsPVPSanctuary = function()
          return checkCFunc(_G.UnitIsPVPSanctuary)
        end,
        UnitIsPlayer = function()
          return checkCFunc(_G.UnitIsPlayer)
        end,
        UnitIsPossessed = function()
          return checkCFunc(_G.UnitIsPossessed)
        end,
        UnitIsQuestBoss = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitIsQuestBoss)
          end
          return checkCFunc(_G.UnitIsQuestBoss)
        end,
        UnitIsRaidOfficer = function()
          return checkCFunc(_G.UnitIsRaidOfficer)
        end,
        UnitIsSameServer = function()
          return checkCFunc(_G.UnitIsSameServer)
        end,
        UnitIsTapDenied = function()
          return checkCFunc(_G.UnitIsTapDenied)
        end,
        UnitIsTrivial = function()
          return checkCFunc(_G.UnitIsTrivial)
        end,
        UnitIsUnconscious = function()
          return checkCFunc(_G.UnitIsUnconscious)
        end,
        UnitIsUnit = function()
          return checkCFunc(_G.UnitIsUnit)
        end,
        UnitIsVisible = function()
          return checkCFunc(_G.UnitIsVisible)
        end,
        UnitIsWildBattlePet = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitIsWildBattlePet)
          end
          return checkCFunc(_G.UnitIsWildBattlePet)
        end,
        UnitLeadsAnyGroup = function()
          return checkCFunc(_G.UnitLeadsAnyGroup)
        end,
        UnitLevel = function()
          return checkCFunc(_G.UnitLevel)
        end,
        UnitName = function()
          return checkCFunc(_G.UnitName)
        end,
        UnitNameUnmodified = function()
          return checkCFunc(_G.UnitNameUnmodified)
        end,
        UnitNameplateShowsWidgetsOnly = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitNameplateShowsWidgetsOnly)
          end
          return checkCFunc(_G.UnitNameplateShowsWidgetsOnly)
        end,
        UnitNumPowerBarTimers = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitNumPowerBarTimers)
          end
          return checkCFunc(_G.UnitNumPowerBarTimers)
        end,
        UnitOnTaxi = function()
          return checkCFunc(_G.UnitOnTaxi)
        end,
        UnitPVPName = function()
          return checkCFunc(_G.UnitPVPName)
        end,
        UnitPVPRank = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitPVPRank)
          end
          return checkCFunc(_G.UnitPVPRank)
        end,
        UnitPhaseReason = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitPhaseReason)
          end
          return checkCFunc(_G.UnitPhaseReason)
        end,
        UnitPlayerControlled = function()
          return checkCFunc(_G.UnitPlayerControlled)
        end,
        UnitPlayerOrPetInParty = function()
          return checkCFunc(_G.UnitPlayerOrPetInParty)
        end,
        UnitPlayerOrPetInRaid = function()
          return checkCFunc(_G.UnitPlayerOrPetInRaid)
        end,
        UnitPosition = function()
          return checkCFunc(_G.UnitPosition)
        end,
        UnitPower = function()
          return checkCFunc(_G.UnitPower)
        end,
        UnitPowerBarID = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitPowerBarID)
          end
          return checkCFunc(_G.UnitPowerBarID)
        end,
        UnitPowerBarTimerInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitPowerBarTimerInfo)
          end
          return checkCFunc(_G.UnitPowerBarTimerInfo)
        end,
        UnitPowerDisplayMod = function()
          return checkCFunc(_G.UnitPowerDisplayMod)
        end,
        UnitPowerMax = function()
          return checkCFunc(_G.UnitPowerMax)
        end,
        UnitPowerType = function()
          return checkCFunc(_G.UnitPowerType)
        end,
        UnitPvpClassification = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitPvpClassification)
          end
          return checkCFunc(_G.UnitPvpClassification)
        end,
        UnitQuestTrivialLevelRange = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitQuestTrivialLevelRange)
          end
          return checkCFunc(_G.UnitQuestTrivialLevelRange)
        end,
        UnitQuestTrivialLevelRangeScaling = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitQuestTrivialLevelRangeScaling)
          end
          return checkCFunc(_G.UnitQuestTrivialLevelRangeScaling)
        end,
        UnitRace = function()
          return checkCFunc(_G.UnitRace)
        end,
        UnitRangedAttack = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitRangedAttack)
          end
          return checkCFunc(_G.UnitRangedAttack)
        end,
        UnitRangedAttackPower = function()
          return checkCFunc(_G.UnitRangedAttackPower)
        end,
        UnitRangedDamage = function()
          return checkCFunc(_G.UnitRangedDamage)
        end,
        UnitReaction = function()
          return checkCFunc(_G.UnitReaction)
        end,
        UnitRealmRelationship = function()
          return checkCFunc(_G.UnitRealmRelationship)
        end,
        UnitResistance = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitResistance)
          end
          return checkCFunc(_G.UnitResistance)
        end,
        UnitSelectionColor = function()
          return checkCFunc(_G.UnitSelectionColor)
        end,
        UnitSelectionType = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitSelectionType)
          end
          return checkCFunc(_G.UnitSelectionType)
        end,
        UnitSetRole = function()
          return checkCFunc(_G.UnitSetRole)
        end,
        UnitSex = function()
          return checkCFunc(_G.UnitSex)
        end,
        UnitShouldDisplayName = function()
          return checkCFunc(_G.UnitShouldDisplayName)
        end,
        UnitSpellHaste = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitSpellHaste)
          end
          return checkCFunc(_G.UnitSpellHaste)
        end,
        UnitStagger = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitStagger)
          end
          return checkCFunc(_G.UnitStagger)
        end,
        UnitStat = function()
          return checkCFunc(_G.UnitStat)
        end,
        UnitSwitchToVehicleSeat = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitSwitchToVehicleSeat)
          end
          return checkCFunc(_G.UnitSwitchToVehicleSeat)
        end,
        UnitTargetsVehicleInRaidUI = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitTargetsVehicleInRaidUI)
          end
          return checkCFunc(_G.UnitTargetsVehicleInRaidUI)
        end,
        UnitThreatPercentageOfLead = function()
          return checkCFunc(_G.UnitThreatPercentageOfLead)
        end,
        UnitThreatSituation = function()
          return checkCFunc(_G.UnitThreatSituation)
        end,
        UnitTreatAsPlayerForDisplay = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitTreatAsPlayerForDisplay)
          end
          return checkCFunc(_G.UnitTreatAsPlayerForDisplay)
        end,
        UnitTrialBankedLevels = function()
          return checkCFunc(_G.UnitTrialBankedLevels)
        end,
        UnitTrialXP = function()
          return checkCFunc(_G.UnitTrialXP)
        end,
        UnitUsingVehicle = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitUsingVehicle)
          end
          return checkCFunc(_G.UnitUsingVehicle)
        end,
        UnitVehicleSeatCount = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitVehicleSeatCount)
          end
          return checkCFunc(_G.UnitVehicleSeatCount)
        end,
        UnitVehicleSeatInfo = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitVehicleSeatInfo)
          end
          return checkCFunc(_G.UnitVehicleSeatInfo)
        end,
        UnitVehicleSkin = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitVehicleSkin)
          end
          return checkCFunc(_G.UnitVehicleSkin)
        end,
        UnitWeaponAttackPower = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitWeaponAttackPower)
          end
          return checkCFunc(_G.UnitWeaponAttackPower)
        end,
        UnitWidgetSet = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnitWidgetSet)
          end
          return checkCFunc(_G.UnitWidgetSet)
        end,
        UnitXP = function()
          return checkCFunc(_G.UnitXP)
        end,
        UnitXPMax = function()
          return checkCFunc(_G.UnitXPMax)
        end,
        UnlearnSpecialization = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnlearnSpecialization)
          end
          return checkCFunc(_G.UnlearnSpecialization)
        end,
        UnlockVoidStorage = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnlockVoidStorage)
          end
          return checkCFunc(_G.UnlockVoidStorage)
        end,
        UnmuteSoundFile = function()
          return checkCFunc(_G.UnmuteSoundFile)
        end,
        UnstablePet = function()
          if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UnstablePet)
          end
          return checkCFunc(_G.UnstablePet)
        end,
        UpdateAddOnCPUUsage = function()
          return checkCFunc(_G.UpdateAddOnCPUUsage)
        end,
        UpdateAddOnMemoryUsage = function()
          return checkCFunc(_G.UpdateAddOnMemoryUsage)
        end,
        UpdateInventoryAlertStatus = function()
          return checkCFunc(_G.UpdateInventoryAlertStatus)
        end,
        UpdateWarGamesList = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UpdateWarGamesList)
          end
          return checkCFunc(_G.UpdateWarGamesList)
        end,
        UpdateWindow = function()
          return checkCFunc(_G.UpdateWindow)
        end,
        UseAction = function()
          return checkCFunc(_G.UseAction)
        end,
        UseContainerItem = function()
          return checkCFunc(_G.UseContainerItem)
        end,
        UseHearthstone = function()
          return checkCFunc(_G.UseHearthstone)
        end,
        UseInventoryItem = function()
          return checkCFunc(_G.UseInventoryItem)
        end,
        UseItemByName = function()
          return checkCFunc(_G.UseItemByName)
        end,
        UseQuestLogSpecialItem = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UseQuestLogSpecialItem)
          end
          return checkCFunc(_G.UseQuestLogSpecialItem)
        end,
        UseToy = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UseToy)
          end
          return checkCFunc(_G.UseToy)
        end,
        UseToyByName = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UseToyByName)
          end
          return checkCFunc(_G.UseToyByName)
        end,
        UseWorldMapActionButtonSpellOnQuest = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.UseWorldMapActionButtonSpellOnQuest)
          end
          return checkCFunc(_G.UseWorldMapActionButtonSpellOnQuest)
        end,
        VehicleAimDecrement = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimDecrement)
          end
          return checkCFunc(_G.VehicleAimDecrement)
        end,
        VehicleAimDownStart = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimDownStart)
          end
          return checkCFunc(_G.VehicleAimDownStart)
        end,
        VehicleAimDownStop = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimDownStop)
          end
          return checkCFunc(_G.VehicleAimDownStop)
        end,
        VehicleAimGetAngle = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimGetAngle)
          end
          return checkCFunc(_G.VehicleAimGetAngle)
        end,
        VehicleAimGetNormAngle = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimGetNormAngle)
          end
          return checkCFunc(_G.VehicleAimGetNormAngle)
        end,
        VehicleAimGetNormPower = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimGetNormPower)
          end
          return checkCFunc(_G.VehicleAimGetNormPower)
        end,
        VehicleAimIncrement = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimIncrement)
          end
          return checkCFunc(_G.VehicleAimIncrement)
        end,
        VehicleAimRequestAngle = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimRequestAngle)
          end
          return checkCFunc(_G.VehicleAimRequestAngle)
        end,
        VehicleAimRequestNormAngle = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimRequestNormAngle)
          end
          return checkCFunc(_G.VehicleAimRequestNormAngle)
        end,
        VehicleAimSetNormPower = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimSetNormPower)
          end
          return checkCFunc(_G.VehicleAimSetNormPower)
        end,
        VehicleAimUpStart = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimUpStart)
          end
          return checkCFunc(_G.VehicleAimUpStart)
        end,
        VehicleAimUpStop = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleAimUpStop)
          end
          return checkCFunc(_G.VehicleAimUpStop)
        end,
        VehicleExit = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleExit)
          end
          return checkCFunc(_G.VehicleExit)
        end,
        VehicleNextSeat = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehicleNextSeat)
          end
          return checkCFunc(_G.VehicleNextSeat)
        end,
        VehiclePrevSeat = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.VehiclePrevSeat)
          end
          return checkCFunc(_G.VehiclePrevSeat)
        end,
        ViewGuildRecipes = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            return checkNotCFunc(_G.ViewGuildRecipes)
          end
          return checkCFunc(_G.ViewGuildRecipes)
        end,
        WarGameRespond = function()
          return checkCFunc(_G.WarGameRespond)
        end,
        WithdrawGuildBankMoney = function()
          return checkCFunc(_G.WithdrawGuildBankMoney)
        end,
        abs = function()
          assertEquals(_G.abs, _G.math.abs)
        end,
        acos = function()
          return checkLuaFunc(_G.acos)
        end,
        addframetext = function()
          return checkCFunc(_G.addframetext)
        end,
        asin = function()
          return checkLuaFunc(_G.asin)
        end,
        assert = function()
          return checkCFunc(_G.assert)
        end,
        atan = function()
          return checkLuaFunc(_G.atan)
        end,
        atan2 = function()
          return checkLuaFunc(_G.atan2)
        end,
        ceil = function()
          assertEquals(_G.ceil, _G.math.ceil)
        end,
        collectgarbage = function()
          return checkCFunc(_G.collectgarbage)
        end,
        cos = function()
          return checkLuaFunc(_G.cos)
        end,
        date = function()
          return checkCFunc(_G.date)
        end,
        debuglocals = function()
          return checkCFunc(_G.debuglocals)
        end,
        debugprofilestart = function()
          return checkCFunc(_G.debugprofilestart)
        end,
        debugprofilestop = function()
          return checkCFunc(_G.debugprofilestop)
        end,
        debugstack = function()
          return checkCFunc(_G.debugstack)
        end,
        deg = function()
          assertEquals(_G.deg, _G.math.deg)
        end,
        difftime = function()
          return checkCFunc(_G.difftime)
        end,
        error = function()
          return checkCFunc(_G.error)
        end,
        exp = function()
          assertEquals(_G.exp, _G.math.exp)
        end,
        fastrandom = function()
          return checkCFunc(_G.fastrandom)
        end,
        floor = function()
          assertEquals(_G.floor, _G.math.floor)
        end,
        forceinsecure = function()
          return checkCFunc(_G.forceinsecure)
        end,
        format = function()
          assertEquals(_G.format, _G.string.format)
        end,
        frexp = function()
          assertEquals(_G.frexp, _G.math.frexp)
        end,
        gcinfo = function()
          return checkCFunc(_G.gcinfo)
        end,
        geterrorhandler = function()
          return checkCFunc(_G.geterrorhandler)
        end,
        getfenv = function()
          return checkCFunc(_G.getfenv)
        end,
        getmetatable = function()
          return checkCFunc(_G.getmetatable)
        end,
        getn = function()
          assertEquals(_G.getn, _G.table.getn)
        end,
        gmatch = function()
          assertEquals(_G.gmatch, _G.string.gmatch)
        end,
        gsub = function()
          assertEquals(_G.gsub, _G.string.gsub)
        end,
        hooksecurefunc = function()
          return checkCFunc(_G.hooksecurefunc)
        end,
        ipairs = function()
          return checkCFunc(_G.ipairs)
        end,
        issecure = function()
          return checkCFunc(_G.issecure)
        end,
        issecurevariable = function()
          return checkCFunc(_G.issecurevariable)
        end,
        ldexp = function()
          assertEquals(_G.ldexp, _G.math.ldexp)
        end,
        loadstring = function()
          return checkCFunc(_G.loadstring)
        end,
        loadstring_untainted = function()
          assertEquals(_G.SecureCapsuleGet == nil, _G.loadstring_untainted ~= nil) -- addon_spec hack
        end,
        log = function()
          assertEquals(_G.log, _G.math.log)
        end,
        log10 = function()
          assertEquals(_G.log10, _G.math.log10)
        end,
        max = function()
          assertEquals(_G.max, _G.math.max)
        end,
        min = function()
          assertEquals(_G.min, _G.math.min)
        end,
        mod = function()
          assertEquals(_G.mod, _G.math.fmod)
        end,
        newproxy = function()
          return checkCFunc(_G.newproxy)
        end,
        next = function()
          return checkCFunc(_G.next)
        end,
        pairs = function()
          return checkCFunc(_G.pairs)
        end,
        pcall = function()
          return checkCFunc(_G.pcall)
        end,
        rad = function()
          assertEquals(_G.rad, _G.math.rad)
        end,
        random = function()
          assertEquals(_G.random, _G.math.random)
        end,
        rawequal = function()
          return checkCFunc(_G.rawequal)
        end,
        rawget = function()
          return checkCFunc(_G.rawget)
        end,
        rawset = function()
          return checkCFunc(_G.rawset)
        end,
        scrub = function()
          return checkCFunc(_G.scrub)
        end,
        securecall = function()
          return checkCFunc(_G.securecall)
        end,
        securecallfunction = function()
          return checkCFunc(_G.securecallfunction)
        end,
        secureexecuterange = function()
          return checkCFunc(_G.secureexecuterange)
        end,
        select = function()
          return checkCFunc(_G.select)
        end,
        seterrorhandler = function()
          return checkCFunc(_G.seterrorhandler)
        end,
        setfenv = function()
          return checkCFunc(_G.setfenv)
        end,
        setmetatable = function()
          return checkCFunc(_G.setmetatable)
        end,
        sin = function()
          return checkLuaFunc(_G.sin)
        end,
        sort = function()
          assertEquals(_G.sort, _G.table.sort)
        end,
        sqrt = function()
          assertEquals(_G.sqrt, _G.math.sqrt)
        end,
        strbyte = function()
          assertEquals(_G.strbyte, _G.string.byte)
        end,
        strcmputf8i = function()
          return checkCFunc(_G.strcmputf8i)
        end,
        strconcat = function()
          return checkCFunc(_G.strconcat)
        end,
        strfind = function()
          assertEquals(_G.strfind, _G.string.find)
        end,
        strjoin = function()
          assertEquals(_G.strjoin, _G.string.join)
        end,
        strlen = function()
          assertEquals(_G.strlen, _G.string.len)
        end,
        strlenutf8 = function()
          return checkCFunc(_G.strlenutf8)
        end,
        strlower = function()
          assertEquals(_G.strlower, _G.string.lower)
        end,
        strmatch = function()
          assertEquals(_G.strmatch, _G.string.match)
        end,
        strrep = function()
          assertEquals(_G.strrep, _G.string.rep)
        end,
        strsplit = function()
          assertEquals(_G.strsplit, _G.string.split)
        end,
        strsplittable = function()
          return checkCFunc(_G.strsplittable)
        end,
        strsub = function()
          assertEquals(_G.strsub, _G.string.sub)
        end,
        strtrim = function()
          assertEquals(_G.strtrim, _G.string.trim)
        end,
        strupper = function()
          assertEquals(_G.strupper, _G.string.upper)
        end,
        tan = function()
          return checkLuaFunc(_G.tan)
        end,
        time = function()
          return checkCFunc(_G.time)
        end,
        tinsert = function()
          assertEquals(_G.tinsert, _G.table.insert)
        end,
        tonumber = function()
          return checkCFunc(_G.tonumber)
        end,
        tostring = function()
          return checkCFunc(_G.tostring)
        end,
        tremove = function()
          assertEquals(_G.tremove, _G.table.remove)
        end,
        type = function()
          return checkCFunc(_G.type)
        end,
        unpack = function()
          return checkCFunc(_G.unpack)
        end,
        wipe = function()
          assertEquals(_G.wipe, _G.table.wipe)
        end,
        xpcall = function()
          return checkCFunc(_G.xpcall)
        end,
      }
      for k, v in pairs(_G) do
        if type(v) == 'function' and not tests[k] then
          tests['~' .. k] = function()
            if not cfuncs[v] then
              return checkLuaFunc(v)
            end
          end
        end
      end
      return tests
    end,
    uiobjects = function()
      local function assertCreateFrame(ty)
        local function process(...)
          assertEquals(1, select('#', ...))
          local frame = ...
          assert(type(frame) == 'table')
          return frame
        end
        return process(CreateFrame(ty))
      end
      local function assertCreateFrameFails(ty)
        local success, err = pcall(function()
          CreateFrame(ty)
        end)
        assert(not success)
        local expectedErr = 'CreateFrame: Unknown frame type \'' .. ty .. '\''
        assertEquals(expectedErr, err:sub(err:len() - expectedErr:len() + 1))
      end
      local GetObjectType = CreateFrame('Frame').GetObjectType
      local indexes = {}
      return {
        Actor = function()
          assertCreateFrameFails('Actor')
        end,
        Alpha = function()
          assertCreateFrameFails('Alpha')
        end,
        Animation = function()
          assertCreateFrameFails('Animation')
        end,
        AnimationGroup = function()
          assertCreateFrameFails('AnimationGroup')
        end,
        Browser = function()
          local frame = assertCreateFrame('Browser')
          local frame2 = assertCreateFrame('Browser')
          assertEquals('Browser', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                NavigateHome = function()
                  return checkCFunc(__index.NavigateHome)
                end,
              }
            end,
          }
        end,
        Button = function()
          local frame = assertCreateFrame('Button')
          local frame2 = assertCreateFrame('Button')
          assertEquals('Button', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                Click = function()
                  return checkCFunc(__index.Click)
                end,
                Disable = function()
                  return checkCFunc(__index.Disable)
                end,
                Enable = function()
                  return checkCFunc(__index.Enable)
                end,
                GetButtonState = function()
                  return checkCFunc(__index.GetButtonState)
                end,
                GetDisabledFontObject = function()
                  return checkCFunc(__index.GetDisabledFontObject)
                end,
                GetDisabledTexture = function()
                  return checkCFunc(__index.GetDisabledTexture)
                end,
                GetFontString = function()
                  return checkCFunc(__index.GetFontString)
                end,
                GetHighlightFontObject = function()
                  return checkCFunc(__index.GetHighlightFontObject)
                end,
                GetHighlightTexture = function()
                  return checkCFunc(__index.GetHighlightTexture)
                end,
                GetMotionScriptsWhileDisabled = function()
                  return checkCFunc(__index.GetMotionScriptsWhileDisabled)
                end,
                GetNormalFontObject = function()
                  return checkCFunc(__index.GetNormalFontObject)
                end,
                GetNormalTexture = function()
                  return checkCFunc(__index.GetNormalTexture)
                end,
                GetPushedTextOffset = function()
                  return checkCFunc(__index.GetPushedTextOffset)
                end,
                GetPushedTexture = function()
                  return checkCFunc(__index.GetPushedTexture)
                end,
                GetText = function()
                  return checkCFunc(__index.GetText)
                end,
                GetTextHeight = function()
                  return checkCFunc(__index.GetTextHeight)
                end,
                GetTextWidth = function()
                  return checkCFunc(__index.GetTextWidth)
                end,
                IsEnabled = function()
                  return checkCFunc(__index.IsEnabled)
                end,
                LockHighlight = function()
                  return checkCFunc(__index.LockHighlight)
                end,
                RegisterForClicks = function()
                  return checkCFunc(__index.RegisterForClicks)
                end,
                RegisterForMouse = function()
                  return checkCFunc(__index.RegisterForMouse)
                end,
                SetButtonState = function()
                  return checkCFunc(__index.SetButtonState)
                end,
                SetDisabledAtlas = function()
                  return checkCFunc(__index.SetDisabledAtlas)
                end,
                SetDisabledFontObject = function()
                  return checkCFunc(__index.SetDisabledFontObject)
                end,
                SetDisabledTexture = function()
                  return checkCFunc(__index.SetDisabledTexture)
                end,
                SetEnabled = function()
                  return checkCFunc(__index.SetEnabled)
                end,
                SetFontString = function()
                  return checkCFunc(__index.SetFontString)
                end,
                SetFormattedText = function()
                  return checkCFunc(__index.SetFormattedText)
                end,
                SetHighlightAtlas = function()
                  return checkCFunc(__index.SetHighlightAtlas)
                end,
                SetHighlightFontObject = function()
                  return checkCFunc(__index.SetHighlightFontObject)
                end,
                SetHighlightTexture = function()
                  return checkCFunc(__index.SetHighlightTexture)
                end,
                SetMotionScriptsWhileDisabled = function()
                  return checkCFunc(__index.SetMotionScriptsWhileDisabled)
                end,
                SetNormalAtlas = function()
                  return checkCFunc(__index.SetNormalAtlas)
                end,
                SetNormalFontObject = function()
                  return checkCFunc(__index.SetNormalFontObject)
                end,
                SetNormalTexture = function()
                  return checkCFunc(__index.SetNormalTexture)
                end,
                SetPushedAtlas = function()
                  return checkCFunc(__index.SetPushedAtlas)
                end,
                SetPushedTextOffset = function()
                  return checkCFunc(__index.SetPushedTextOffset)
                end,
                SetPushedTexture = function()
                  return checkCFunc(__index.SetPushedTexture)
                end,
                SetText = function()
                  return checkCFunc(__index.SetText)
                end,
                UnlockHighlight = function()
                  return checkCFunc(__index.UnlockHighlight)
                end,
              }
            end,
          }
        end,
        CheckButton = function()
          local frame = assertCreateFrame('CheckButton')
          local frame2 = assertCreateFrame('CheckButton')
          assertEquals('CheckButton', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                GetChecked = function()
                  return checkCFunc(__index.GetChecked)
                end,
                GetCheckedTexture = function()
                  return checkCFunc(__index.GetCheckedTexture)
                end,
                GetDisabledCheckedTexture = function()
                  return checkCFunc(__index.GetDisabledCheckedTexture)
                end,
                SetChecked = function()
                  return checkCFunc(__index.SetChecked)
                end,
                SetCheckedTexture = function()
                  return checkCFunc(__index.SetCheckedTexture)
                end,
                SetDisabledCheckedTexture = function()
                  return checkCFunc(__index.SetDisabledCheckedTexture)
                end,
              }
            end,
          }
        end,
        Checkout = function()
          local frame = assertCreateFrame('Checkout')
          local frame2 = assertCreateFrame('Checkout')
          assertEquals('BlizzardCheckout', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
          }
        end,
        CinematicModel = function()
          local frame = assertCreateFrame('CinematicModel')
          local frame2 = assertCreateFrame('CinematicModel')
          assertEquals('CinematicModel', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                InitializeCamera = function()
                  return checkCFunc(__index.InitializeCamera)
                end,
                SetFacingLeft = function()
                  return checkCFunc(__index.SetFacingLeft)
                end,
                SetHeightFactor = function()
                  return checkCFunc(__index.SetHeightFactor)
                end,
                SetTargetDistance = function()
                  return checkCFunc(__index.SetTargetDistance)
                end,
              }
            end,
          }
        end,
        ColorSelect = function()
          local frame = assertCreateFrame('ColorSelect')
          local frame2 = assertCreateFrame('ColorSelect')
          assertEquals('ColorSelect', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                GetColorHSV = function()
                  return checkCFunc(__index.GetColorHSV)
                end,
                GetColorRGB = function()
                  return checkCFunc(__index.GetColorRGB)
                end,
                GetColorValueTexture = function()
                  return checkCFunc(__index.GetColorValueTexture)
                end,
                GetColorValueThumbTexture = function()
                  return checkCFunc(__index.GetColorValueThumbTexture)
                end,
                GetColorWheelTexture = function()
                  return checkCFunc(__index.GetColorWheelTexture)
                end,
                GetColorWheelThumbTexture = function()
                  return checkCFunc(__index.GetColorWheelThumbTexture)
                end,
                SetColorHSV = function()
                  return checkCFunc(__index.SetColorHSV)
                end,
                SetColorRGB = function()
                  return checkCFunc(__index.SetColorRGB)
                end,
                SetColorValueTexture = function()
                  return checkCFunc(__index.SetColorValueTexture)
                end,
                SetColorValueThumbTexture = function()
                  return checkCFunc(__index.SetColorValueThumbTexture)
                end,
                SetColorWheelTexture = function()
                  return checkCFunc(__index.SetColorWheelTexture)
                end,
                SetColorWheelThumbTexture = function()
                  return checkCFunc(__index.SetColorWheelThumbTexture)
                end,
              }
            end,
          }
        end,
        ControlPoint = function()
          assertCreateFrameFails('ControlPoint')
        end,
        Cooldown = function()
          local frame = assertCreateFrame('Cooldown')
          local frame2 = assertCreateFrame('Cooldown')
          assertEquals('Cooldown', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                Clear = function()
                  return checkCFunc(__index.Clear)
                end,
                GetCooldownDisplayDuration = function()
                  return checkCFunc(__index.GetCooldownDisplayDuration)
                end,
                GetCooldownDuration = function()
                  return checkCFunc(__index.GetCooldownDuration)
                end,
                GetCooldownTimes = function()
                  return checkCFunc(__index.GetCooldownTimes)
                end,
                GetDrawBling = function()
                  return checkCFunc(__index.GetDrawBling)
                end,
                GetDrawEdge = function()
                  return checkCFunc(__index.GetDrawEdge)
                end,
                GetDrawSwipe = function()
                  return checkCFunc(__index.GetDrawSwipe)
                end,
                GetEdgeScale = function()
                  return checkCFunc(__index.GetEdgeScale)
                end,
                GetReverse = function()
                  return checkCFunc(__index.GetReverse)
                end,
                GetRotation = function()
                  return checkCFunc(__index.GetRotation)
                end,
                IsPaused = function()
                  return checkCFunc(__index.IsPaused)
                end,
                Pause = function()
                  return checkCFunc(__index.Pause)
                end,
                Resume = function()
                  return checkCFunc(__index.Resume)
                end,
                SetBlingTexture = function()
                  return checkCFunc(__index.SetBlingTexture)
                end,
                SetCooldown = function()
                  return checkCFunc(__index.SetCooldown)
                end,
                SetCooldownDuration = function()
                  return checkCFunc(__index.SetCooldownDuration)
                end,
                SetCooldownUNIX = function()
                  return checkCFunc(__index.SetCooldownUNIX)
                end,
                SetCountdownAbbrevThreshold = function()
                  return checkCFunc(__index.SetCountdownAbbrevThreshold)
                end,
                SetCountdownFont = function()
                  return checkCFunc(__index.SetCountdownFont)
                end,
                SetDrawBling = function()
                  return checkCFunc(__index.SetDrawBling)
                end,
                SetDrawEdge = function()
                  return checkCFunc(__index.SetDrawEdge)
                end,
                SetDrawSwipe = function()
                  return checkCFunc(__index.SetDrawSwipe)
                end,
                SetEdgeScale = function()
                  return checkCFunc(__index.SetEdgeScale)
                end,
                SetEdgeTexture = function()
                  return checkCFunc(__index.SetEdgeTexture)
                end,
                SetHideCountdownNumbers = function()
                  return checkCFunc(__index.SetHideCountdownNumbers)
                end,
                SetReverse = function()
                  return checkCFunc(__index.SetReverse)
                end,
                SetRotation = function()
                  return checkCFunc(__index.SetRotation)
                end,
                SetSwipeColor = function()
                  return checkCFunc(__index.SetSwipeColor)
                end,
                SetSwipeTexture = function()
                  return checkCFunc(__index.SetSwipeTexture)
                end,
                SetUseCircularEdge = function()
                  return checkCFunc(__index.SetUseCircularEdge)
                end,
              }
            end,
          }
        end,
        DressUpModel = function()
          local frame = assertCreateFrame('DressUpModel')
          local frame2 = assertCreateFrame('DressUpModel')
          assertEquals('DressUpModel', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                SetAutoDress = function()
                  return checkCFunc(__index.SetAutoDress)
                end,
              }
            end,
          }
        end,
        EditBox = function()
          local frame = assertCreateFrame('EditBox')
          local frame2 = assertCreateFrame('EditBox')
          frame:Hide() -- captures input focus otherwise
          frame2:Hide() -- captures input focus otherwise
          assertEquals('EditBox', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                AddHistoryLine = function()
                  return checkCFunc(__index.AddHistoryLine)
                end,
                ClearFocus = function()
                  return checkCFunc(__index.ClearFocus)
                end,
                ClearHistory = function()
                  return checkCFunc(__index.ClearHistory)
                end,
                Disable = function()
                  return checkCFunc(__index.Disable)
                end,
                Enable = function()
                  return checkCFunc(__index.Enable)
                end,
                GetHistoryLines = function()
                  return checkCFunc(__index.GetHistoryLines)
                end,
                GetInputLanguage = function()
                  return checkCFunc(__index.GetInputLanguage)
                end,
                GetMaxBytes = function()
                  return checkCFunc(__index.GetMaxBytes)
                end,
                GetMaxLetters = function()
                  return checkCFunc(__index.GetMaxLetters)
                end,
                GetNumber = function()
                  return checkCFunc(__index.GetNumber)
                end,
                GetText = function()
                  return checkCFunc(__index.GetText)
                end,
                HasFocus = function()
                  return checkCFunc(__index.HasFocus)
                end,
                HighlightText = function()
                  return checkCFunc(__index.HighlightText)
                end,
                Insert = function()
                  return checkCFunc(__index.Insert)
                end,
                IsAutoFocus = function()
                  return checkCFunc(__index.IsAutoFocus)
                end,
                IsCountInvisibleLetters = function()
                  return checkCFunc(__index.IsCountInvisibleLetters)
                end,
                IsEnabled = function()
                  return checkCFunc(__index.IsEnabled)
                end,
                IsMultiLine = function()
                  return checkCFunc(__index.IsMultiLine)
                end,
                IsSecureText = function()
                  return checkCFunc(__index.IsSecureText)
                end,
                SetAltArrowKeyMode = function()
                  return checkCFunc(__index.SetAltArrowKeyMode)
                end,
                SetAutoFocus = function()
                  return checkCFunc(__index.SetAutoFocus)
                end,
                SetCountInvisibleLetters = function()
                  return checkCFunc(__index.SetCountInvisibleLetters)
                end,
                SetCursorPosition = function()
                  return checkCFunc(__index.SetCursorPosition)
                end,
                SetEnabled = function()
                  return checkCFunc(__index.SetEnabled)
                end,
                SetFocus = function()
                  return checkCFunc(__index.SetFocus)
                end,
                SetHighlightColor = function()
                  return checkCFunc(__index.SetHighlightColor)
                end,
                SetHistoryLines = function()
                  return checkCFunc(__index.SetHistoryLines)
                end,
                SetMaxBytes = function()
                  return checkCFunc(__index.SetMaxBytes)
                end,
                SetMaxLetters = function()
                  return checkCFunc(__index.SetMaxLetters)
                end,
                SetMultiLine = function()
                  return checkCFunc(__index.SetMultiLine)
                end,
                SetNumber = function()
                  return checkCFunc(__index.SetNumber)
                end,
                SetNumeric = function()
                  return checkCFunc(__index.SetNumeric)
                end,
                SetSecureText = function()
                  return checkCFunc(__index.SetSecureText)
                end,
                SetSecurityDisablePaste = function()
                  return checkCFunc(__index.SetSecurityDisablePaste)
                end,
                SetSecurityDisableSetText = function()
                  return checkCFunc(__index.SetSecurityDisableSetText)
                end,
                SetText = function()
                  return checkCFunc(__index.SetText)
                end,
                SetTextInsets = function()
                  return checkCFunc(__index.SetTextInsets)
                end,
              }
            end,
          }
        end,
        FogOfWarFrame = function()
          local frame = assertCreateFrame('FogOfWarFrame')
          local frame2 = assertCreateFrame('FogOfWarFrame')
          assertEquals('FogOfWarFrame', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
        end,
        Font = function()
          assertCreateFrameFails('Font')
        end,
        FontInstance = function()
          assertCreateFrameFails('FontInstance')
        end,
        FontString = function()
          assertCreateFrameFails('FontString')
        end,
        Frame = function()
          local frame = assertCreateFrame('Frame')
          local frame2 = assertCreateFrame('Frame')
          assertEquals('Frame', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                CreateFontString = function()
                  return checkCFunc(__index.CreateFontString)
                end,
                CreateLine = function()
                  return checkCFunc(__index.CreateLine)
                end,
                CreateMaskTexture = function()
                  return checkCFunc(__index.CreateMaskTexture)
                end,
                CreateTexture = function()
                  return checkCFunc(__index.CreateTexture)
                end,
                DesaturateHierarchy = function()
                  return checkCFunc(__index.DesaturateHierarchy)
                end,
                DisableDrawLayer = function()
                  return checkCFunc(__index.DisableDrawLayer)
                end,
                EnableKeyboard = function()
                  return checkCFunc(__index.EnableKeyboard)
                end,
                EnableMouse = function()
                  return checkCFunc(__index.EnableMouse)
                end,
                EnableMouseWheel = function()
                  return checkCFunc(__index.EnableMouseWheel)
                end,
                GetAttribute = function()
                  return checkCFunc(__index.GetAttribute)
                end,
                GetChildren = function()
                  return checkCFunc(__index.GetChildren)
                end,
                GetFrameLevel = function()
                  return checkCFunc(__index.GetFrameLevel)
                end,
                GetFrameStrata = function()
                  return checkCFunc(__index.GetFrameStrata)
                end,
                GetHyperlinksEnabled = function()
                  return checkCFunc(__index.GetHyperlinksEnabled)
                end,
                GetID = function()
                  return checkCFunc(__index.GetID)
                end,
                GetMaxResize = function()
                  return checkCFunc(__index.GetMaxResize)
                end,
                GetMinResize = function()
                  return checkCFunc(__index.GetMinResize)
                end,
                GetNumChildren = function()
                  return checkCFunc(__index.GetNumChildren)
                end,
                GetNumRegions = function()
                  return checkCFunc(__index.GetNumRegions)
                end,
                GetPropagateKeyboardInput = function()
                  return checkCFunc(__index.GetPropagateKeyboardInput)
                end,
                GetRegions = function()
                  return checkCFunc(__index.GetRegions)
                end,
                IgnoreDepth = function()
                  return checkCFunc(__index.IgnoreDepth)
                end,
                IsClampedToScreen = function()
                  return checkCFunc(__index.IsClampedToScreen)
                end,
                IsEventRegistered = function()
                  return checkCFunc(__index.IsEventRegistered)
                end,
                IsMouseClickEnabled = function()
                  return checkCFunc(__index.IsMouseClickEnabled)
                end,
                IsMouseEnabled = function()
                  return checkCFunc(__index.IsMouseEnabled)
                end,
                IsMouseMotionEnabled = function()
                  return checkCFunc(__index.IsMouseMotionEnabled)
                end,
                IsMouseWheelEnabled = function()
                  return checkCFunc(__index.IsMouseWheelEnabled)
                end,
                IsMovable = function()
                  return checkCFunc(__index.IsMovable)
                end,
                IsResizable = function()
                  return checkCFunc(__index.IsResizable)
                end,
                IsToplevel = function()
                  return checkCFunc(__index.IsToplevel)
                end,
                IsUserPlaced = function()
                  return checkCFunc(__index.IsUserPlaced)
                end,
                Raise = function()
                  return checkCFunc(__index.Raise)
                end,
                RegisterAllEvents = function()
                  return checkCFunc(__index.RegisterAllEvents)
                end,
                RegisterEvent = function()
                  return checkCFunc(__index.RegisterEvent)
                end,
                RegisterForDrag = function()
                  return checkCFunc(__index.RegisterForDrag)
                end,
                RegisterUnitEvent = function()
                  return checkCFunc(__index.RegisterUnitEvent)
                end,
                SetAttribute = function()
                  return checkCFunc(__index.SetAttribute)
                end,
                SetAttributeNoHandler = function()
                  return checkCFunc(__index.SetAttributeNoHandler)
                end,
                SetClampRectInsets = function()
                  return checkCFunc(__index.SetClampRectInsets)
                end,
                SetClampedToScreen = function()
                  return checkCFunc(__index.SetClampedToScreen)
                end,
                SetClipsChildren = function()
                  return checkCFunc(__index.SetClipsChildren)
                end,
                SetDepth = function()
                  return checkCFunc(__index.SetDepth)
                end,
                SetDontSavePosition = function()
                  return checkCFunc(__index.SetDontSavePosition)
                end,
                SetFixedFrameLevel = function()
                  return checkCFunc(__index.SetFixedFrameLevel)
                end,
                SetFixedFrameStrata = function()
                  return checkCFunc(__index.SetFixedFrameStrata)
                end,
                SetFrameLevel = function()
                  return checkCFunc(__index.SetFrameLevel)
                end,
                SetFrameStrata = function()
                  return checkCFunc(__index.SetFrameStrata)
                end,
                SetHitRectInsets = function()
                  return checkCFunc(__index.SetHitRectInsets)
                end,
                SetHyperlinksEnabled = function()
                  return checkCFunc(__index.SetHyperlinksEnabled)
                end,
                SetID = function()
                  return checkCFunc(__index.SetID)
                end,
                SetMaxResize = function()
                  return checkCFunc(__index.SetMaxResize)
                end,
                SetMinResize = function()
                  return checkCFunc(__index.SetMinResize)
                end,
                SetMouseClickEnabled = function()
                  return checkCFunc(__index.SetMouseClickEnabled)
                end,
                SetMouseMotionEnabled = function()
                  return checkCFunc(__index.SetMouseMotionEnabled)
                end,
                SetMovable = function()
                  return checkCFunc(__index.SetMovable)
                end,
                SetPropagateKeyboardInput = function()
                  return checkCFunc(__index.SetPropagateKeyboardInput)
                end,
                SetResizable = function()
                  return checkCFunc(__index.SetResizable)
                end,
                SetToplevel = function()
                  return checkCFunc(__index.SetToplevel)
                end,
                SetUserPlaced = function()
                  return checkCFunc(__index.SetUserPlaced)
                end,
                StartMoving = function()
                  return checkCFunc(__index.StartMoving)
                end,
                StopMovingOrSizing = function()
                  return checkCFunc(__index.StopMovingOrSizing)
                end,
                UnregisterAllEvents = function()
                  return checkCFunc(__index.UnregisterAllEvents)
                end,
                UnregisterEvent = function()
                  return checkCFunc(__index.UnregisterEvent)
                end,
              }
            end,
          }
        end,
        GameTooltip = function()
          local frame = assertCreateFrame('GameTooltip')
          local frame2 = assertCreateFrame('GameTooltip')
          assertEquals('GameTooltip', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                AddAtlas = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.AddAtlas))
                    return
                  end
                  return checkCFunc(__index.AddAtlas)
                end,
                AddDoubleLine = function()
                  return checkCFunc(__index.AddDoubleLine)
                end,
                AddFontStrings = function()
                  return checkCFunc(__index.AddFontStrings)
                end,
                AddLine = function()
                  return checkCFunc(__index.AddLine)
                end,
                AddSpellByID = function()
                  return checkCFunc(__index.AddSpellByID)
                end,
                AddTexture = function()
                  return checkCFunc(__index.AddTexture)
                end,
                AdvanceSecondaryCompareItem = function()
                  return checkCFunc(__index.AdvanceSecondaryCompareItem)
                end,
                AppendText = function()
                  return checkCFunc(__index.AppendText)
                end,
                ClearLines = function()
                  return checkCFunc(__index.ClearLines)
                end,
                CopyTooltip = function()
                  return checkCFunc(__index.CopyTooltip)
                end,
                FadeOut = function()
                  return checkCFunc(__index.FadeOut)
                end,
                GetAnchorType = function()
                  return checkCFunc(__index.GetAnchorType)
                end,
                GetAzeritePowerID = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.GetAzeritePowerID))
                    return
                  end
                  return checkCFunc(__index.GetAzeritePowerID)
                end,
                GetCustomLineSpacing = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.GetCustomLineSpacing))
                    return
                  end
                  return checkCFunc(__index.GetCustomLineSpacing)
                end,
                GetItem = function()
                  return checkCFunc(__index.GetItem)
                end,
                GetMinimumWidth = function()
                  return checkCFunc(__index.GetMinimumWidth)
                end,
                GetOwner = function()
                  return checkCFunc(__index.GetOwner)
                end,
                GetPadding = function()
                  return checkCFunc(__index.GetPadding)
                end,
                GetSpell = function()
                  return checkCFunc(__index.GetSpell)
                end,
                GetUnit = function()
                  return checkCFunc(__index.GetUnit)
                end,
                IsEquippedItem = function()
                  return checkCFunc(__index.IsEquippedItem)
                end,
                IsOwned = function()
                  return checkCFunc(__index.IsOwned)
                end,
                IsUnit = function()
                  return checkCFunc(__index.IsUnit)
                end,
                NumLines = function()
                  return checkCFunc(__index.NumLines)
                end,
                ResetSecondaryCompareItem = function()
                  return checkCFunc(__index.ResetSecondaryCompareItem)
                end,
                SetAchievementByID = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetAchievementByID))
                    return
                  end
                  return checkCFunc(__index.SetAchievementByID)
                end,
                SetAction = function()
                  return checkCFunc(__index.SetAction)
                end,
                SetAllowShowWithNoLines = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetAllowShowWithNoLines))
                    return
                  end
                  return checkCFunc(__index.SetAllowShowWithNoLines)
                end,
                SetAnchorType = function()
                  return checkCFunc(__index.SetAnchorType)
                end,
                SetArtifactItem = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetArtifactItem))
                    return
                  end
                  return checkCFunc(__index.SetArtifactItem)
                end,
                SetArtifactPowerByID = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetArtifactPowerByID))
                    return
                  end
                  return checkCFunc(__index.SetArtifactPowerByID)
                end,
                SetAuctionItem = function()
                  if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetAuctionItem))
                    return
                  end
                  return checkCFunc(__index.SetAuctionItem)
                end,
                SetAuctionSellItem = function()
                  if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetAuctionSellItem))
                    return
                  end
                  return checkCFunc(__index.SetAuctionSellItem)
                end,
                SetAzeriteEssence = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetAzeriteEssence))
                    return
                  end
                  return checkCFunc(__index.SetAzeriteEssence)
                end,
                SetAzeriteEssenceSlot = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetAzeriteEssenceSlot))
                    return
                  end
                  return checkCFunc(__index.SetAzeriteEssenceSlot)
                end,
                SetAzeritePower = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetAzeritePower))
                    return
                  end
                  return checkCFunc(__index.SetAzeritePower)
                end,
                SetBackpackToken = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetBackpackToken))
                    return
                  end
                  return checkCFunc(__index.SetBackpackToken)
                end,
                SetBagItem = function()
                  return checkCFunc(__index.SetBagItem)
                end,
                SetBagItemChild = function()
                  return checkCFunc(__index.SetBagItemChild)
                end,
                SetBuybackItem = function()
                  return checkCFunc(__index.SetBuybackItem)
                end,
                SetCompanionPet = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetCompanionPet))
                    return
                  end
                  return checkCFunc(__index.SetCompanionPet)
                end,
                SetCompareAzeritePower = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetCompareAzeritePower))
                    return
                  end
                  return checkCFunc(__index.SetCompareAzeritePower)
                end,
                SetCompareItem = function()
                  return checkCFunc(__index.SetCompareItem)
                end,
                SetConduit = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetConduit))
                    return
                  end
                  return checkCFunc(__index.SetConduit)
                end,
                SetCraftItem = function()
                  if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetCraftItem))
                    return
                  end
                  return checkCFunc(__index.SetCraftItem)
                end,
                SetCraftSpell = function()
                  if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetCraftSpell))
                    return
                  end
                  return checkCFunc(__index.SetCraftSpell)
                end,
                SetCurrencyByID = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetCurrencyByID))
                    return
                  end
                  return checkCFunc(__index.SetCurrencyByID)
                end,
                SetCurrencyToken = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetCurrencyToken))
                    return
                  end
                  return checkCFunc(__index.SetCurrencyToken)
                end,
                SetCurrencyTokenByID = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetCurrencyTokenByID))
                    return
                  end
                  return checkCFunc(__index.SetCurrencyTokenByID)
                end,
                SetCustomLineSpacing = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetCustomLineSpacing))
                    return
                  end
                  return checkCFunc(__index.SetCustomLineSpacing)
                end,
                SetEnhancedConduit = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetEnhancedConduit))
                    return
                  end
                  return checkCFunc(__index.SetEnhancedConduit)
                end,
                SetEquipmentSet = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetEquipmentSet))
                    return
                  end
                  return checkCFunc(__index.SetEquipmentSet)
                end,
                SetExistingSocketGem = function()
                  return checkCFunc(__index.SetExistingSocketGem)
                end,
                SetFrameStack = function()
                  return checkCFunc(__index.SetFrameStack)
                end,
                SetGuildBankItem = function()
                  return checkCFunc(__index.SetGuildBankItem)
                end,
                SetHeirloomByItemID = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetHeirloomByItemID))
                    return
                  end
                  return checkCFunc(__index.SetHeirloomByItemID)
                end,
                SetHyperlink = function()
                  return checkCFunc(__index.SetHyperlink)
                end,
                SetInboxItem = function()
                  return checkCFunc(__index.SetInboxItem)
                end,
                SetInstanceLockEncountersComplete = function()
                  return checkCFunc(__index.SetInstanceLockEncountersComplete)
                end,
                SetInventoryItem = function()
                  return checkCFunc(__index.SetInventoryItem)
                end,
                SetInventoryItemByID = function()
                  return checkCFunc(__index.SetInventoryItemByID)
                end,
                SetItemByID = function()
                  return checkCFunc(__index.SetItemByID)
                end,
                SetItemKey = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetItemKey))
                    return
                  end
                  return checkCFunc(__index.SetItemKey)
                end,
                SetLFGDungeonReward = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetLFGDungeonReward))
                    return
                  end
                  return checkCFunc(__index.SetLFGDungeonReward)
                end,
                SetLFGDungeonShortageReward = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetLFGDungeonShortageReward))
                    return
                  end
                  return checkCFunc(__index.SetLFGDungeonShortageReward)
                end,
                SetLootCurrency = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetLootCurrency))
                    return
                  end
                  return checkCFunc(__index.SetLootCurrency)
                end,
                SetLootItem = function()
                  return checkCFunc(__index.SetLootItem)
                end,
                SetLootRollItem = function()
                  return checkCFunc(__index.SetLootRollItem)
                end,
                SetMerchantCostItem = function()
                  return checkCFunc(__index.SetMerchantCostItem)
                end,
                SetMerchantItem = function()
                  return checkCFunc(__index.SetMerchantItem)
                end,
                SetMinimumWidth = function()
                  return checkCFunc(__index.SetMinimumWidth)
                end,
                SetMountBySpellID = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetMountBySpellID))
                    return
                  end
                  return checkCFunc(__index.SetMountBySpellID)
                end,
                SetOwnedItemByID = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetOwnedItemByID))
                    return
                  end
                  return checkCFunc(__index.SetOwnedItemByID)
                end,
                SetOwner = function()
                  return checkCFunc(__index.SetOwner)
                end,
                SetPadding = function()
                  return checkCFunc(__index.SetPadding)
                end,
                SetPetAction = function()
                  return checkCFunc(__index.SetPetAction)
                end,
                SetPossession = function()
                  return checkCFunc(__index.SetPossession)
                end,
                SetPvpBrawl = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetPvpBrawl))
                    return
                  end
                  return checkCFunc(__index.SetPvpBrawl)
                end,
                SetPvpTalent = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetPvpTalent))
                    return
                  end
                  return checkCFunc(__index.SetPvpTalent)
                end,
                SetQuestCurrency = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetQuestCurrency))
                    return
                  end
                  return checkCFunc(__index.SetQuestCurrency)
                end,
                SetQuestItem = function()
                  return checkCFunc(__index.SetQuestItem)
                end,
                SetQuestLogCurrency = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetQuestLogCurrency))
                    return
                  end
                  return checkCFunc(__index.SetQuestLogCurrency)
                end,
                SetQuestLogItem = function()
                  return checkCFunc(__index.SetQuestLogItem)
                end,
                SetQuestLogRewardSpell = function()
                  return checkCFunc(__index.SetQuestLogRewardSpell)
                end,
                SetQuestLogSpecialItem = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetQuestLogSpecialItem))
                    return
                  end
                  return checkCFunc(__index.SetQuestLogSpecialItem)
                end,
                SetQuestPartyProgress = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetQuestPartyProgress))
                    return
                  end
                  return checkCFunc(__index.SetQuestPartyProgress)
                end,
                SetQuestRewardSpell = function()
                  return checkCFunc(__index.SetQuestRewardSpell)
                end,
                SetRecipeRankInfo = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetRecipeRankInfo))
                    return
                  end
                  return checkCFunc(__index.SetRecipeRankInfo)
                end,
                SetRecipeReagentItem = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetRecipeReagentItem))
                    return
                  end
                  return checkCFunc(__index.SetRecipeReagentItem)
                end,
                SetRecipeResultItem = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetRecipeResultItem))
                    return
                  end
                  return checkCFunc(__index.SetRecipeResultItem)
                end,
                SetRuneforgeResultItem = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetRuneforgeResultItem))
                    return
                  end
                  return checkCFunc(__index.SetRuneforgeResultItem)
                end,
                SetSendMailItem = function()
                  return checkCFunc(__index.SetSendMailItem)
                end,
                SetShapeshift = function()
                  return checkCFunc(__index.SetShapeshift)
                end,
                SetShrinkToFitWrapped = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetShrinkToFitWrapped))
                    return
                  end
                  return checkCFunc(__index.SetShrinkToFitWrapped)
                end,
                SetSocketGem = function()
                  return checkCFunc(__index.SetSocketGem)
                end,
                SetSocketedItem = function()
                  return checkCFunc(__index.SetSocketedItem)
                end,
                SetSocketedRelic = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetSocketedRelic))
                    return
                  end
                  return checkCFunc(__index.SetSocketedRelic)
                end,
                SetSpellBookItem = function()
                  return checkCFunc(__index.SetSpellBookItem)
                end,
                SetSpellByID = function()
                  return checkCFunc(__index.SetSpellByID)
                end,
                SetTalent = function()
                  return checkCFunc(__index.SetTalent)
                end,
                SetText = function()
                  return checkCFunc(__index.SetText)
                end,
                SetTotem = function()
                  return checkCFunc(__index.SetTotem)
                end,
                SetToyByItemID = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetToyByItemID))
                    return
                  end
                  return checkCFunc(__index.SetToyByItemID)
                end,
                SetTrackingSpell = function()
                  if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetTrackingSpell))
                    return
                  end
                  return checkCFunc(__index.SetTrackingSpell)
                end,
                SetTradePlayerItem = function()
                  return checkCFunc(__index.SetTradePlayerItem)
                end,
                SetTradeSkillItem = function()
                  if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetTradeSkillItem))
                    return
                  end
                  return checkCFunc(__index.SetTradeSkillItem)
                end,
                SetTradeTargetItem = function()
                  return checkCFunc(__index.SetTradeTargetItem)
                end,
                SetTrainerService = function()
                  return checkCFunc(__index.SetTrainerService)
                end,
                SetTransmogrifyItem = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetTransmogrifyItem))
                    return
                  end
                  return checkCFunc(__index.SetTransmogrifyItem)
                end,
                SetUnit = function()
                  return checkCFunc(__index.SetUnit)
                end,
                SetUnitAura = function()
                  return checkCFunc(__index.SetUnitAura)
                end,
                SetUnitBuff = function()
                  return checkCFunc(__index.SetUnitBuff)
                end,
                SetUnitDebuff = function()
                  return checkCFunc(__index.SetUnitDebuff)
                end,
                SetUpgradeItem = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetUpgradeItem))
                    return
                  end
                  return checkCFunc(__index.SetUpgradeItem)
                end,
                SetVoidDepositItem = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetVoidDepositItem))
                    return
                  end
                  return checkCFunc(__index.SetVoidDepositItem)
                end,
                SetVoidItem = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetVoidItem))
                    return
                  end
                  return checkCFunc(__index.SetVoidItem)
                end,
                SetVoidWithdrawalItem = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetVoidWithdrawalItem))
                    return
                  end
                  return checkCFunc(__index.SetVoidWithdrawalItem)
                end,
                SetWeeklyReward = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetWeeklyReward))
                    return
                  end
                  return checkCFunc(__index.SetWeeklyReward)
                end,
              }
            end,
          }
        end,
        LayeredRegion = function()
          assertCreateFrameFails('LayeredRegion')
        end,
        Line = function()
          assertCreateFrameFails('Line')
        end,
        MaskTexture = function()
          assertCreateFrameFails('MaskTexture')
        end,
        MessageFrame = function()
          local frame = assertCreateFrame('MessageFrame')
          local frame2 = assertCreateFrame('MessageFrame')
          assertEquals('MessageFrame', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                AddMessage = function()
                  return checkCFunc(__index.AddMessage)
                end,
                Clear = function()
                  return checkCFunc(__index.Clear)
                end,
              }
            end,
          }
        end,
        Model = function()
          local frame = assertCreateFrame('Model')
          local frame2 = assertCreateFrame('Model')
          assertEquals('Model', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                ClearModel = function()
                  return checkCFunc(__index.ClearModel)
                end,
                GetModelScale = function()
                  return checkCFunc(__index.GetModelScale)
                end,
                SetFacing = function()
                  return checkCFunc(__index.SetFacing)
                end,
                SetLight = function()
                  return checkCFunc(__index.SetLight)
                end,
                SetModel = function()
                  return checkCFunc(__index.SetModel)
                end,
                SetModelScale = function()
                  return checkCFunc(__index.SetModelScale)
                end,
                SetPosition = function()
                  return checkCFunc(__index.SetPosition)
                end,
                TransformCameraSpaceToModelSpace = function()
                  return checkCFunc(__index.TransformCameraSpaceToModelSpace)
                end,
              }
            end,
          }
        end,
        ModelScene = function()
          local frame = assertCreateFrame('ModelScene')
          local frame2 = assertCreateFrame('ModelScene')
          assertEquals('ModelScene', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                ClearFog = function()
                  return checkCFunc(__index.ClearFog)
                end,
                CreateActor = function()
                  return checkCFunc(__index.CreateActor)
                end,
                GetActorAtIndex = function()
                  return checkCFunc(__index.GetActorAtIndex)
                end,
                GetCameraFarClip = function()
                  return checkCFunc(__index.GetCameraFarClip)
                end,
                GetCameraFieldOfView = function()
                  return checkCFunc(__index.GetCameraFieldOfView)
                end,
                GetCameraForward = function()
                  return checkCFunc(__index.GetCameraForward)
                end,
                GetCameraNearClip = function()
                  return checkCFunc(__index.GetCameraNearClip)
                end,
                GetCameraPosition = function()
                  return checkCFunc(__index.GetCameraPosition)
                end,
                GetCameraRight = function()
                  return checkCFunc(__index.GetCameraRight)
                end,
                GetCameraUp = function()
                  return checkCFunc(__index.GetCameraUp)
                end,
                GetDrawLayer = function()
                  return checkCFunc(__index.GetDrawLayer)
                end,
                GetFogColor = function()
                  return checkCFunc(__index.GetFogColor)
                end,
                GetFogFar = function()
                  return checkCFunc(__index.GetFogFar)
                end,
                GetFogNear = function()
                  return checkCFunc(__index.GetFogNear)
                end,
                GetLightAmbientColor = function()
                  return checkCFunc(__index.GetLightAmbientColor)
                end,
                GetLightDiffuseColor = function()
                  return checkCFunc(__index.GetLightDiffuseColor)
                end,
                GetLightDirection = function()
                  return checkCFunc(__index.GetLightDirection)
                end,
                GetLightPosition = function()
                  return checkCFunc(__index.GetLightPosition)
                end,
                GetLightType = function()
                  return checkCFunc(__index.GetLightType)
                end,
                GetNumActors = function()
                  return checkCFunc(__index.GetNumActors)
                end,
                GetViewInsets = function()
                  return checkCFunc(__index.GetViewInsets)
                end,
                GetViewTranslation = function()
                  return checkCFunc(__index.GetViewTranslation)
                end,
                IsLightVisible = function()
                  return checkCFunc(__index.IsLightVisible)
                end,
                Project3DPointTo2D = function()
                  return checkCFunc(__index.Project3DPointTo2D)
                end,
                SetCameraFarClip = function()
                  return checkCFunc(__index.SetCameraFarClip)
                end,
                SetCameraFieldOfView = function()
                  return checkCFunc(__index.SetCameraFieldOfView)
                end,
                SetCameraNearClip = function()
                  return checkCFunc(__index.SetCameraNearClip)
                end,
                SetCameraOrientationByAxisVectors = function()
                  return checkCFunc(__index.SetCameraOrientationByAxisVectors)
                end,
                SetCameraOrientationByYawPitchRoll = function()
                  return checkCFunc(__index.SetCameraOrientationByYawPitchRoll)
                end,
                SetCameraPosition = function()
                  return checkCFunc(__index.SetCameraPosition)
                end,
                SetDesaturation = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetDesaturation))
                    return
                  end
                  return checkCFunc(__index.SetDesaturation)
                end,
                SetDrawLayer = function()
                  return checkCFunc(__index.SetDrawLayer)
                end,
                SetFogColor = function()
                  return checkCFunc(__index.SetFogColor)
                end,
                SetFogFar = function()
                  return checkCFunc(__index.SetFogFar)
                end,
                SetFogNear = function()
                  return checkCFunc(__index.SetFogNear)
                end,
                SetLightAmbientColor = function()
                  return checkCFunc(__index.SetLightAmbientColor)
                end,
                SetLightDiffuseColor = function()
                  return checkCFunc(__index.SetLightDiffuseColor)
                end,
                SetLightDirection = function()
                  return checkCFunc(__index.SetLightDirection)
                end,
                SetLightPosition = function()
                  return checkCFunc(__index.SetLightPosition)
                end,
                SetLightType = function()
                  return checkCFunc(__index.SetLightType)
                end,
                SetLightVisible = function()
                  return checkCFunc(__index.SetLightVisible)
                end,
                SetPaused = function()
                  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
                    assertEquals('nil', type(__index.SetPaused))
                    return
                  end
                  return checkCFunc(__index.SetPaused)
                end,
                SetViewInsets = function()
                  return checkCFunc(__index.SetViewInsets)
                end,
                SetViewTranslation = function()
                  return checkCFunc(__index.SetViewTranslation)
                end,
                TakeActor = function()
                  return checkCFunc(__index.TakeActor)
                end,
              }
            end,
          }
        end,
        MovieFrame = function()
          local frame = assertCreateFrame('MovieFrame')
          local frame2 = assertCreateFrame('MovieFrame')
          assertEquals('MovieFrame', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                EnableSubtitles = function()
                  return checkCFunc(__index.EnableSubtitles)
                end,
                StartMovie = function()
                  return checkCFunc(__index.StartMovie)
                end,
                StopMovie = function()
                  return checkCFunc(__index.StopMovie)
                end,
              }
            end,
          }
        end,
        OffScreenFrame = function()
          local frame = assertCreateFrame('OffScreenFrame')
          local frame2 = assertCreateFrame('OffScreenFrame')
          assertEquals('OffScreenFrame', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
          }
        end,
        POIFrame = function()
          assertCreateFrameFails('POIFrame')
        end,
        ParentedObject = function()
          assertCreateFrameFails('ParentedObject')
        end,
        Path = function()
          assertCreateFrameFails('Path')
        end,
        PlayerModel = function()
          local frame = assertCreateFrame('PlayerModel')
          local frame2 = assertCreateFrame('PlayerModel')
          assertEquals('PlayerModel', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                FreezeAnimation = function()
                  return checkCFunc(__index.FreezeAnimation)
                end,
                GetDisplayInfo = function()
                  return checkCFunc(__index.GetDisplayInfo)
                end,
                RefreshCamera = function()
                  return checkCFunc(__index.RefreshCamera)
                end,
                RefreshUnit = function()
                  return checkCFunc(__index.RefreshUnit)
                end,
                SetAnimation = function()
                  return checkCFunc(__index.SetAnimation)
                end,
                SetCamDistanceScale = function()
                  return checkCFunc(__index.SetCamDistanceScale)
                end,
                SetDisplayInfo = function()
                  return checkCFunc(__index.SetDisplayInfo)
                end,
                SetDoBlend = function()
                  return checkCFunc(__index.SetDoBlend)
                end,
                SetKeepModelOnHide = function()
                  return checkCFunc(__index.SetKeepModelOnHide)
                end,
                SetPortraitZoom = function()
                  return checkCFunc(__index.SetPortraitZoom)
                end,
                SetRotation = function()
                  return checkCFunc(__index.SetRotation)
                end,
                SetUnit = function()
                  return checkCFunc(__index.SetUnit)
                end,
              }
            end,
          }
        end,
        QuestPOIFrame = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertCreateFrameFails('QuestPOIFrame')
            return
          end
          local frame = assertCreateFrame('QuestPOIFrame')
          local frame2 = assertCreateFrame('QuestPOIFrame')
          assertEquals('QuestPOIFrame', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
          }
        end,
        Region = function()
          assertCreateFrameFails('Region')
        end,
        Rotation = function()
          assertCreateFrameFails('Rotation')
        end,
        Scale = function()
          assertCreateFrameFails('Scale')
        end,
        ScenarioPOIFrame = function()
          if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
            assertCreateFrameFails('ScenarioPOIFrame')
            return
          end
          local frame = assertCreateFrame('ScenarioPOIFrame')
          local frame2 = assertCreateFrame('ScenarioPOIFrame')
          assertEquals('ScenarioPOIFrame', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
          }
        end,
        ScriptObject = function()
          assertCreateFrameFails('ScriptObject')
        end,
        ScrollFrame = function()
          local frame = assertCreateFrame('ScrollFrame')
          local frame2 = assertCreateFrame('ScrollFrame')
          assertEquals('ScrollFrame', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                GetHorizontalScroll = function()
                  return checkCFunc(__index.GetHorizontalScroll)
                end,
                GetHorizontalScrollRange = function()
                  return checkCFunc(__index.GetHorizontalScrollRange)
                end,
                GetScrollChild = function()
                  return checkCFunc(__index.GetScrollChild)
                end,
                GetVerticalScroll = function()
                  return checkCFunc(__index.GetVerticalScroll)
                end,
                GetVerticalScrollRange = function()
                  return checkCFunc(__index.GetVerticalScrollRange)
                end,
                SetHorizontalScroll = function()
                  return checkCFunc(__index.SetHorizontalScroll)
                end,
                SetScrollChild = function()
                  return checkCFunc(__index.SetScrollChild)
                end,
                SetVerticalScroll = function()
                  return checkCFunc(__index.SetVerticalScroll)
                end,
                UpdateScrollChildRect = function()
                  return checkCFunc(__index.UpdateScrollChildRect)
                end,
              }
            end,
          }
        end,
        SimpleHTML = function()
          local frame = assertCreateFrame('SimpleHTML')
          local frame2 = assertCreateFrame('SimpleHTML')
          assertEquals('SimpleHTML', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                GetContentHeight = function()
                  return checkCFunc(__index.GetContentHeight)
                end,
                SetText = function()
                  return checkCFunc(__index.SetText)
                end,
              }
            end,
          }
        end,
        Slider = function()
          local frame = assertCreateFrame('Slider')
          local frame2 = assertCreateFrame('Slider')
          assertEquals('Slider', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                Disable = function()
                  return checkCFunc(__index.Disable)
                end,
                Enable = function()
                  return checkCFunc(__index.Enable)
                end,
                GetMinMaxValues = function()
                  return checkCFunc(__index.GetMinMaxValues)
                end,
                GetObeyStepOnDrag = function()
                  return checkCFunc(__index.GetObeyStepOnDrag)
                end,
                GetOrientation = function()
                  return checkCFunc(__index.GetOrientation)
                end,
                GetStepsPerPage = function()
                  return checkCFunc(__index.GetStepsPerPage)
                end,
                GetThumbTexture = function()
                  return checkCFunc(__index.GetThumbTexture)
                end,
                GetValue = function()
                  return checkCFunc(__index.GetValue)
                end,
                GetValueStep = function()
                  return checkCFunc(__index.GetValueStep)
                end,
                IsDraggingThumb = function()
                  return checkCFunc(__index.IsDraggingThumb)
                end,
                IsEnabled = function()
                  return checkCFunc(__index.IsEnabled)
                end,
                SetEnabled = function()
                  return checkCFunc(__index.SetEnabled)
                end,
                SetMinMaxValues = function()
                  return checkCFunc(__index.SetMinMaxValues)
                end,
                SetObeyStepOnDrag = function()
                  return checkCFunc(__index.SetObeyStepOnDrag)
                end,
                SetOrientation = function()
                  return checkCFunc(__index.SetOrientation)
                end,
                SetStepsPerPage = function()
                  return checkCFunc(__index.SetStepsPerPage)
                end,
                SetThumbTexture = function()
                  return checkCFunc(__index.SetThumbTexture)
                end,
                SetValue = function()
                  return checkCFunc(__index.SetValue)
                end,
                SetValueStep = function()
                  return checkCFunc(__index.SetValueStep)
                end,
              }
            end,
          }
        end,
        StatusBar = function()
          local frame = assertCreateFrame('StatusBar')
          local frame2 = assertCreateFrame('StatusBar')
          assertEquals('StatusBar', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                GetFillStyle = function()
                  return checkCFunc(__index.GetFillStyle)
                end,
                GetMinMaxValues = function()
                  return checkCFunc(__index.GetMinMaxValues)
                end,
                GetOrientation = function()
                  return checkCFunc(__index.GetOrientation)
                end,
                GetReverseFill = function()
                  return checkCFunc(__index.GetReverseFill)
                end,
                GetRotatesTexture = function()
                  return checkCFunc(__index.GetRotatesTexture)
                end,
                GetStatusBarAtlas = function()
                  return checkCFunc(__index.GetStatusBarAtlas)
                end,
                GetStatusBarColor = function()
                  return checkCFunc(__index.GetStatusBarColor)
                end,
                GetStatusBarTexture = function()
                  return checkCFunc(__index.GetStatusBarTexture)
                end,
                GetValue = function()
                  return checkCFunc(__index.GetValue)
                end,
                SetFillStyle = function()
                  return checkCFunc(__index.SetFillStyle)
                end,
                SetMinMaxValues = function()
                  return checkCFunc(__index.SetMinMaxValues)
                end,
                SetOrientation = function()
                  return checkCFunc(__index.SetOrientation)
                end,
                SetReverseFill = function()
                  return checkCFunc(__index.SetReverseFill)
                end,
                SetRotatesTexture = function()
                  return checkCFunc(__index.SetRotatesTexture)
                end,
                SetStatusBarAtlas = function()
                  return checkCFunc(__index.SetStatusBarAtlas)
                end,
                SetStatusBarColor = function()
                  return checkCFunc(__index.SetStatusBarColor)
                end,
                SetStatusBarTexture = function()
                  return checkCFunc(__index.SetStatusBarTexture)
                end,
                SetValue = function()
                  return checkCFunc(__index.SetValue)
                end,
              }
            end,
          }
        end,
        TabardModel = function()
          local frame = assertCreateFrame('TabardModel')
          local frame2 = assertCreateFrame('TabardModel')
          assertEquals('TabardModel', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                GetLowerEmblemTexture = function()
                  return checkCFunc(__index.GetLowerEmblemTexture)
                end,
                GetUpperEmblemTexture = function()
                  return checkCFunc(__index.GetUpperEmblemTexture)
                end,
                InitializeTabardColors = function()
                  return checkCFunc(__index.InitializeTabardColors)
                end,
              }
            end,
          }
        end,
        Texture = function()
          assertCreateFrameFails('Texture')
        end,
        TextureCoordTranslation = function()
          assertCreateFrameFails('TextureCoordTranslation')
        end,
        Translation = function()
          assertCreateFrameFails('Translation')
        end,
        UIObject = function()
          assertCreateFrameFails('UIObject')
        end,
        UnitPositionFrame = function()
          local frame = assertCreateFrame('UnitPositionFrame')
          local frame2 = assertCreateFrame('UnitPositionFrame')
          assertEquals('UnitPositionFrame', GetObjectType(frame))
          local mt = getmetatable(frame)
          assert(mt == getmetatable(frame2))
          assert(mt ~= nil)
          assert(getmetatable(mt) == nil)
          local mtk, __index = next(mt)
          assertEquals('__index', mtk)
          assertEquals('table', type(__index))
          assertEquals(nil, next(mt, mtk))
          assertEquals(nil, getmetatable(__index))
          assertEquals(nil, indexes[__index])
          indexes[__index] = true
          return {
            contents = function()
              local udk, udv = next(frame)
              assertEquals(udk, 0)
              assertEquals('userdata', type(udv))
              assert(getmetatable(udv) == nil)
              assert(next(frame, udk) == nil)
            end,
            methods = function()
              return {
                AddUnit = function()
                  return checkCFunc(__index.AddUnit)
                end,
                ClearUnits = function()
                  return checkCFunc(__index.ClearUnits)
                end,
                FinalizeUnits = function()
                  return checkCFunc(__index.FinalizeUnits)
                end,
                GetMouseOverUnits = function()
                  return checkCFunc(__index.GetMouseOverUnits)
                end,
                SetPlayerPingScale = function()
                  return checkCFunc(__index.SetPlayerPingScale)
                end,
                SetPlayerPingTexture = function()
                  return checkCFunc(__index.SetPlayerPingTexture)
                end,
                SetUiMapID = function()
                  return checkCFunc(__index.SetUiMapID)
                end,
                StartPlayerPing = function()
                  return checkCFunc(__index.StartPlayerPing)
                end,
                StopPlayerPing = function()
                  return checkCFunc(__index.StopPlayerPing)
                end,
              }
            end,
          }
        end,
      }
    end,
  }
end
