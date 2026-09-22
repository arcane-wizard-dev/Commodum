local addonName, COM = ...

local version = C_AddOns.GetAddOnMetadata(addonName, "Version") or ""
local buildDate = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate") or ""

COM.CHANGELOG = {
	{
		version = version,
		date = buildDate ~= "" and buildDate or nil,
		entries = {
			"Adapted to the latest version of Arcane Wizard: Library to ensure full compatibility",
			"Minor code adjustments"
		}
	},
	{
		version = "v1.25",
		date = "2026-09-20",
		entries = {
			"Changed: Automatic reputation tracking no longer reselects the faction that is already being watched"
		}
	},
	{
		version = "v1.24",
		date = "2026-09-18",
		entries = {
			"Added: TOC version for patch 1.60.1 [forever]",
			"Changed: Character profiles now use GUIDs",
			"Changed: Addon initialization stops if the player identity is unavailable"
		}
	},
	{
		version = "v1.23",
		date = "2026-09-13",
		entries = {
			"Updated: GitHub links following the organization rename to 'arcane-wizard-dev'"
		}
	},
	{
		version = "v1.22",
		date = "2026-09-06",
		entries = {
			"Added: TOC version for patch 12.1.5 [retail]",
			"Changed: Quality-of-life options are now grouped into User Interface and Merchant Actions, with loot notifications under User Interface and poor-quality item sales before marked item sales"
		}
	},
	{
		version = "v1.21",
		date = "2026-08-30",
		entries = {
			"Minor code adjustments"
		}
	},
	{
		version = "v1.20",
		date = "2026-08-21",
		entries = {
			"Changed: General loot notifications can now be hidden separately for items, money, and personal currencies",
			"Changed: Quality-of-life options are now organized into expandable sections",
			"Changed: Option names were shortened"
		}
	},
	{
		version = "v1.19",
		date = "2026-08-18",
		entries = {
			"Added: Changelog window available from the options menu",
			"Added: Changelog window available through the 'changelog' slash command",
			"Removed: Version notice chat messages",
			"Adapted to the latest version of Arcane Wizard: Library to ensure full compatibility"
		}
	},
	{
		version = "v1.18",
		date = "2026-08-14",
		entries = {
			"Removed: TOC version for patch 12.0.7 [retail]"
		}
	},
	{
		version = "v1.17",
		date = "2026-08-04",
		entries = {
			"Minor code adjustments"
		}
	}
}
