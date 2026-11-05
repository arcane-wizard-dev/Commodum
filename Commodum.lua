local addonName, COM = ...

if COM.State and COM.State.libraryIncompatible then return end

-- Library
local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

-- Module imports
local Options = COM.Modules.Options
local QualityOfLife = COM.Modules.QualityOfLife
local Utils = COM.Modules.Utils

-- Variables
local isInitialized = false

--------------
--- Frames ---
--------------

local CommodumFrame = CreateFrame("Frame", "Commodum")

-----------------------
--- Local Functions ---
-----------------------

local function SlashCommand(msg)
	if not isInitialized then return end

	local command = strtrim(msg or "")

	if command == "" then
		Utils:OpenSettings()
	elseif command == "changelog" then
		AWL.Frames:OpenChangelog(addonName, COM.CHANGELOG)
	else
		Utils:PrintDebug("No arguments will be accepted.")
	end
end

------------------------
--- Public Functions ---
------------------------

function CommodumFrame:OnEvent(event, ...)
	self[event](self, event, ...)
end

function CommodumFrame:ADDON_LOADED(_, addOnName)
	if addOnName ~= addonName or isInitialized then return end

	local dbInit = Utils:InitializeDatabase()

	if not dbInit then
		Addon:AbortInitialization(self)

		return
	end

	Utils:InitializeMinimapButton()
	Options:Initialize()
	QualityOfLife:InitializeAutoSell()

	if AWL.GAME_TYPE_RETAIL then
		QualityOfLife:ApplyLootToastSetting()
	end

	Addon:OpenSettingsOnLoading()

	isInitialized = true

	Utils:PrintDebug(
		"InitializeDatabase: key=%s, createdProfile=%s, createdProfileKey=%s, cleanedOptions=%s, activeProfile=%s",
		dbInit.characterGUID,
		dbInit.createdProfile,
		dbInit.createdProfileKey,
		dbInit.cleanedOptions,
		dbInit.activeProfile
	)
	Utils:PrintDebug("Addon fully loaded.")
end

function CommodumFrame:PLAYER_ENTERING_WORLD(_, isInitialLogin, isReloadingUi)
	Utils:PrintDebug(
		"Event 'PLAYER_ENTERING_WORLD' fired. Payload: isInitialLogin=%s, isReloadingUi=%s",
		isInitialLogin, isReloadingUi
	)

	QualityOfLife:ApplyMilitaryTimeSetting()
end

function CommodumFrame:FACTION_STANDING_CHANGED(_, factionID, updatedStanding)
	Utils:PrintDebug(
		"Event 'FACTION_STANDING_CHANGED' fired. Payload: factionID=%s, updatedStanding=%s",
		factionID, updatedStanding
	)

	QualityOfLife:WatchFaction(factionID)
end

function CommodumFrame:MERCHANT_SHOW()
	QualityOfLife:RepairItemsAutomatically()
	QualityOfLife:StartAutoSell()
end

function CommodumFrame:MERCHANT_CLOSED()
	QualityOfLife:StopAutoSell()
end

function CommodumFrame:LOOT_ITEM_ROLL_WON(_, itemLink, rollQuantity, rollType, roll, upgraded)
	Utils:PrintDebug(
		"Event 'LOOT_ITEM_ROLL_WON' fired. Payload: itemLink=%s, rollQuantity=%s, rollType=%s, roll=%s, upgraded=%s",
		itemLink, rollQuantity, rollType, roll, upgraded
	)
end

function CommodumFrame:SHOW_LOOT_TOAST(_, typeIdentifier, itemLink, quantity, specID, sex, personalLootToast, toastMethod, lessAwesome, upgraded, corrupted)
	Utils:PrintDebug(
		"Event 'SHOW_LOOT_TOAST' fired. Payload: typeIdentifier=%s, itemLink=%s, quantity=%s, specID=%s, sex=%s, personalLootToast=%s, toastMethod=%s, lessAwesome=%s, upgraded=%s, corrupted=%s",
		typeIdentifier,
		itemLink,
		quantity,
		specID,
		sex,
		personalLootToast,
		toastMethod,
		lessAwesome,
		upgraded,
		corrupted
	)

	QualityOfLife:HandleLootToast(typeIdentifier, itemLink, quantity, specID, sex, personalLootToast, toastMethod, lessAwesome, upgraded, corrupted)
end

function CommodumFrame:SHOW_LOOT_TOAST_UPGRADE(_, itemLink, quantity, specID, sex, baseQuality, personalLootToast, lessAwesome)
	Utils:PrintDebug(
		"Event 'SHOW_LOOT_TOAST_UPGRADE' fired. Payload: itemLink=%s, quantity=%s, specID=%s, sex=%s, baseQuality=%s, personalLootToast=%s, lessAwesome=%s",
		itemLink, quantity, specID, sex, baseQuality, personalLootToast, lessAwesome
	)
end

function CommodumFrame:SHOW_LOOT_TOAST_LEGENDARY_LOOTED(_, itemLink)
	Utils:PrintDebug(
		"Event 'SHOW_LOOT_TOAST_LEGENDARY_LOOTED' fired. Payload: itemLink=%s",
		itemLink
	)
end

function CommodumFrame:SHOW_PVP_FACTION_LOOT_TOAST(_, typeIdentifier, itemLink, quantity, specID, sex, personalLootToast, lessAwesome)
	Utils:PrintDebug(
		"Event 'SHOW_PVP_FACTION_LOOT_TOAST' fired. Payload: typeIdentifier=%s, itemLink=%s, quantity=%s, specID=%s, sex=%s, personalLootToast=%s, lessAwesome=%s",
		typeIdentifier, itemLink, quantity, specID, sex, personalLootToast, lessAwesome
	)
end

function CommodumFrame:SHOW_RATED_PVP_REWARD_TOAST(_, typeIdentifier, itemLink, quantity, specID, sex, personalLootToast, lessAwesome)
	Utils:PrintDebug(
		"Event 'SHOW_RATED_PVP_REWARD_TOAST' fired. Payload: typeIdentifier=%s, itemLink=%s, quantity=%s, specID=%s, sex=%s, personalLootToast=%s, lessAwesome=%s",
		typeIdentifier, itemLink, quantity, specID, sex, personalLootToast, lessAwesome
	)
end

if AWL.GAME_TYPE_RETAIL then
	CommodumFrame:RegisterEvent("LOOT_ITEM_ROLL_WON")
	CommodumFrame:RegisterEvent("SHOW_LOOT_TOAST")
	CommodumFrame:RegisterEvent("SHOW_LOOT_TOAST_UPGRADE")
	CommodumFrame:RegisterEvent("SHOW_LOOT_TOAST_LEGENDARY_LOOTED")
	CommodumFrame:RegisterEvent("SHOW_PVP_FACTION_LOOT_TOAST")
	CommodumFrame:RegisterEvent("SHOW_RATED_PVP_REWARD_TOAST")
end

CommodumFrame:RegisterEvent("ADDON_LOADED")
CommodumFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
CommodumFrame:RegisterEvent("FACTION_STANDING_CHANGED")
CommodumFrame:RegisterEvent("MERCHANT_SHOW")
CommodumFrame:RegisterEvent("MERCHANT_CLOSED")

CommodumFrame:SetScript("OnEvent", CommodumFrame.OnEvent)

SLASH_Commodum1, SLASH_Commodum2 = '/com', '/commodum'

SlashCmdList["Commodum"] = SlashCommand
