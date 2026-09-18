local addonName, COM = ...

-- Library
local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

-- Localization
local L = COM.Localization

-- Current module
local Utils = COM.Modules.Utils

-----------------------
--- Local Functions ---
-----------------------

local function PrintChatMessage(color, prefix, msg)
	DEFAULT_CHAT_FRAME:AddMessage(color:WrapTextInColorCode(prefix .. ": ") .. tostring(msg))
end

------------------------
--- Module Functions ---
------------------------

function Utils:PrintMessage(msg)
	PrintChatMessage(NORMAL_FONT_COLOR, addonName, msg)
end

function Utils:PrintDebug(msg)
	if COM.Settings.general["debug-mode"] then
		PrintChatMessage(ORANGE_FONT_COLOR, addonName .. " (Debug)", msg)
	end
end

function Utils:OpenSettings()
	if not Addon:OpenCategory() then
		self:PrintDebug("In combat. The options menu cannot be opened.")
		return false
	end

	return true
end

function Utils:IsAccountProfile()
	local characterGUID = AWL.Utils:GetCharacterGUID()

	return Commodum_Options_v3.profileKeys[characterGUID]["use-account"]
end

function Utils:OpenSettingsOnLoading()
	local characterGUID = AWL.Utils:GetCharacterGUID()

	if Commodum_Options_v3.profileKeys[characterGUID]["open-settings"] then
		if not self:OpenSettings() then
			return
		end

		Commodum_Options_v3.profileKeys[characterGUID]["open-settings"] = false
	end
end

function Utils:ToggleProfileMode()
	local characterGUID = AWL.Utils:GetCharacterGUID()
	local useAccountProfile = self:IsAccountProfile()

	Commodum_Options_v3.profileKeys[characterGUID]["use-account"] = not useAccountProfile
	Commodum_Options_v3.profileKeys[characterGUID]["open-settings"] = true
end

function Utils:ResetAllCharacterProfiles()
	local characterGUID = AWL.Utils:GetCharacterGUID()

	Commodum_Options_v3.profiles = {}
	Commodum_Options_v3.profileKeys = {}

	Commodum_Options_v3.profileKeys[characterGUID] = {
		["use-account"] = true,
		["open-settings"] = true
	}
end

function Utils:InitializeDatabase()
	local characterGUID = AWL.Utils:GetCharacterGUID()

	if not characterGUID then
		return nil
	end

	local createdProfile = false
	local createdProfileKey = false

	local defaults = {
		["general"] = {
			["minimap-button"] = {
				["hide"] = false
			}
		},
		["quality-of-life"] = {}
	}

	if not Commodum_Options_v3 then
		Commodum_Options_v3 = {
			["account"] = AWL.Utils:CopyTable(defaults),
			["profiles"] = {},
			["profileKeys"] = {}
		}
	end

	if not Commodum_Options_v3.profiles[characterGUID] then
		Commodum_Options_v3.profiles[characterGUID] = AWL.Utils:CopyTable(defaults)
		createdProfile = true
	end

	if not Commodum_Options_v3.profileKeys[characterGUID] then
		Commodum_Options_v3.profileKeys[characterGUID] = {
			["use-account"] = true,
			["open-settings"] = false
		}
		createdProfileKey = true
	end

	local useAccountProfile = Commodum_Options_v3.profileKeys[characterGUID]["use-account"]

	if useAccountProfile then
		COM.Settings.general = Commodum_Options_v3.account["general"]
		COM.Settings.qualityOfLife = Commodum_Options_v3.account["quality-of-life"]
	else
		COM.Settings.general = Commodum_Options_v3.profiles[characterGUID]["general"]
		COM.Settings.qualityOfLife = Commodum_Options_v3.profiles[characterGUID]["quality-of-life"]
	end

	if not Commodum_DataAutoSell then
		Commodum_DataAutoSell = {}
	end

	COM.Data.autoSell = Commodum_DataAutoSell

	return {
		characterGUID = characterGUID,
		createdProfile = createdProfile,
		createdProfileKey = createdProfileKey,
		activeProfile = useAccountProfile and "account" or "character"
	}
end

function Utils:InitializeMinimapButton()
	self.minimapButton = Addon:RegisterMinimapButton({
		db = COM.Settings.general["minimap-button"],
		tooltip = L["minimap-button.tooltip"]
	})
end
