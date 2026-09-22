local _, COM = ...

COM.OPTIONS_DEFAULTS = {
	["general"] = {
		["minimap-button"] = {
			["hide"] = false,
			["minimapPos"] = 225,
			["lock"] = false,
			["showInCompartment"] = false
		},
		["debug-mode"] = false,
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
