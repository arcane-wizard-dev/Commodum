local addonName, COM = ...

if COM.State and COM.State.libraryIncompatible then return end

local version = C_AddOns.GetAddOnMetadata(addonName, "Version") or ""
local buildDate = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate") or ""

COM.CHANGELOG = {
	notices = {},
	-- BEGIN GENERATED CHANGELOG
	{
		version = version,
		date = buildDate ~= "" and buildDate or nil,
		entries = {
			"Added: Startup check for the minimum required Library revision",
			"Updated: deDE, enUS, ruRU localizations",
			"Updated: Addon description",
			"Minor code adjustments"
		}
	},
	{
		version = "v1.33",
		date = "2026-10-16",
		entries = {
			"Adapted to the latest version of Arcane Wizard: Library to ensure full compatibility"
		}
	},
	{
		version = "v1.32",
		date = "2026-10-14",
		entries = {
			"Fixed: Repeated error messages for missing translations"
		}
	},
	{
		version = "v1.31",
		date = "2026-10-12",
		entries = {
			"Refactoring of the addon structure and source code"
		}
	},
	{
		version = "v1.30",
		date = "2026-10-09",
		entries = {
			"Added: ruRU localization",
			"Minor code adjustments"
		}
	},
	{
		version = "v1.29",
		date = "2026-10-03",
		entries = {
			"Updated: Logo"
		}
	},
	{
		version = "v1.28",
		date = "2026-09-27",
		entries = {
			"Minor code adjustments"
		}
	},
	{
		version = "v1.27",
		date = "2026-09-24",
		entries = {
			"Updated: Compatibility with the beta client [forever]"
		}
	},
	{
		version = "v1.26",
		date = "2026-09-22",
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
	}
	-- END GENERATED CHANGELOG
}
