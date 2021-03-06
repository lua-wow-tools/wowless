-- TODO: nil when UI is not open; use appropariate row based on open UI
local uiiteminteractionByID = ...
local row = uiiteminteractionByID(1)
return {
  buttonText = row.ButtonText_lang,
  buttonTooltip = row.Field_9_1_5_40196_004_lang,
  closeSoundKitID = row.CloseSoundKitID,
  confirmationDescription = row.ConfirmationQuestion_lang,
  cost = row.Cost,
  currencyTypeId = row.CurrencyTypeID,
  description = row.Description_lang,
  dropInSlotSoundKitId = row.DropInSlotSoundKitID,
  flags = row.Field_8_3_0_32414_012,
  interactionType = row.ItemInteractionFrameType,
  openSoundKitID = row.OpenSoundKitID,
  textureKit = row.UiTextureKitID,
  titleText = row.TitleText_lang,
  tutorialText = row.TutorialText_lang,
}
