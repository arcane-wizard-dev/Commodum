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
			"Refactoring of the addon structure and source code"
		}
	},
	{
		version = "v1.40",
		date = "2026-11-06",
		entries = {
			"Changed: The Basic debug level now shows important messages, while Advanced also includes technical details",
			"Updated: deDE, enUS, ruRU localizations",
			"Removed obsolete code for better maintainability"
		}
	},
	{
		version = "v1.39",
		date = "2026-11-05",
		entries = {
			"Changed: Debug messages are now converted and formatted only when debug mode is enabled",
			"Requires Arcane Wizard: Library revision 4 or later"
		}
	},
	{
		version = "v1.38",
		date = "2026-11-03",
		entries = {
			"Changed: The debug mode option now combines an enable checkbox with a Basic or Advanced level selector",
			"Updated: deDE, enUS, ruRU localizations",
			"Minor code adjustments"
		}
	},
	{
		version = "v1.37",
		date = "2026-11-01",
		entries = {
			"Changed: The TOC no longer restricts loading by game type"
		}
	},
	{
		version = "v1.36",
		date = "2026-11-01",
		entries = {
			"Changed: Grouped related settings in the options menu and clarified their tooltips",
			"Changed: Limited loading to Retail, Forever, and Talebound",
			"Updated: deDE, enUS, ruRU localizations",
			"Requires Arcane Wizard: Library revision 2 or later"
		}
	},
	{
		version = "v1.35",
		date = "2026-10-29",
		entries = {
			"Added: TOC version for patch 12.1.7 [retail]",
			"Updated: Addon description",
			"Removed: TOC version for patch 12.1.0 [retail]"
		}
	},
	{
		version = "v1.34",
		date = "2026-10-28",
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
	}
	-- END GENERATED CHANGELOG
}
