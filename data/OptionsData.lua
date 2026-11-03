local _, COM = ...

if COM.State and COM.State.libraryIncompatible then return end

COM.LOOT_TOAST_OPTIONS = {
	{variableName = "hide-loot-toasts-item", localizationKey = "options.quality-of-life.hide-loot-toasts.item"},
	{variableName = "hide-loot-toasts-money", localizationKey = "options.quality-of-life.hide-loot-toasts.money"},
	{variableName = "hide-loot-toasts-currency", localizationKey = "options.quality-of-life.hide-loot-toasts.currency"}
}

COM.OPTIONS_DEFAULTS = {
	["general"] = {
		["minimap-button"] = {
			["hide"] = false,
			["minimapPos"] = 225,
			["lock"] = false,
			["showInCompartment"] = false
		},
		["debug-mode"] = false,
		["debug-level"] = "basic",
	},
	["quality-of-life"] = {
		["military-time"] = true,
		["watched-faction"] = true,
		["hide-loot-toasts"] = false,
		["hide-loot-toasts-item"] = false,
		["hide-loot-toasts-money"] = false,
		["hide-loot-toasts-currency"] = false,
		["auto-repair"] = false,
		["auto-sell-poor"] = false,
		["auto-sell"] = false,
		["auto-sell-marking-modifier"] = "ALT",
	},
}
