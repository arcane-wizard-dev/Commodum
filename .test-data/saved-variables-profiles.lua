-- Synthetic SavedVariables: account, current and offline character profiles; preserve false and zero.
-- No real player data. Version "test" is the version supplied by the test harness.
-- Includes the current character's SavedVariablesPerCharacter table.

Commodum_Options_v3 = {
	["account"] = {
		["general"] = {
			["debug-mode"] = false,
			["minimap-button"] = {
				["hide"] = false,
				["lock"] = false,
				["minimapPos"] = 90,
				["showInCompartment"] = false,
			},
		},
		["quality-of-life"] = {
			["auto-repair"] = false,
			["auto-sell"] = true,
			["auto-sell-marking-modifier"] = "CTRL",
			["auto-sell-poor"] = false,
			["hide-loot-toasts"] = false,
			["hide-loot-toasts-currency"] = false,
			["hide-loot-toasts-item"] = false,
			["hide-loot-toasts-money"] = false,
			["military-time"] = false,
			["watched-faction"] = true,
		},
	},
	["global"] = {
		["version"] = "test",
	},
	["profileKeys"] = {
		["Player-TEST-CURRENT"] = {
			["open-settings"] = false,
			["use-account"] = false,
		},
		["Player-TEST-OFFLINE"] = {
			["open-settings"] = false,
			["use-account"] = true,
		},
	},
	["profiles"] = {
		["Player-TEST-CURRENT"] = {
			["general"] = {
				["debug-mode"] = false,
				["minimap-button"] = {
					["hide"] = true,
					["lock"] = false,
					["minimapPos"] = 0,
					["showInCompartment"] = false,
				},
			},
			["quality-of-life"] = {
				["auto-repair"] = false,
				["auto-sell"] = true,
				["auto-sell-marking-modifier"] = "CTRL",
				["auto-sell-poor"] = false,
				["hide-loot-toasts"] = false,
				["hide-loot-toasts-currency"] = false,
				["hide-loot-toasts-item"] = false,
				["hide-loot-toasts-money"] = false,
				["military-time"] = false,
				["watched-faction"] = true,
			},
		},
		["Player-TEST-OFFLINE"] = {
			["general"] = {
				["debug-mode"] = false,
				["minimap-button"] = {
					["hide"] = false,
					["lock"] = false,
					["minimapPos"] = 270,
					["showInCompartment"] = false,
				},
			},
			["quality-of-life"] = {
				["auto-repair"] = false,
				["auto-sell"] = true,
				["auto-sell-marking-modifier"] = "CTRL",
				["auto-sell-poor"] = false,
				["hide-loot-toasts"] = false,
				["hide-loot-toasts-currency"] = false,
				["hide-loot-toasts-item"] = false,
				["hide-loot-toasts-money"] = false,
				["military-time"] = false,
				["watched-faction"] = true,
			},
		},
	},
}

Commodum_DataAutoSell = {
	[2589] = true,
	[2592] = true,
	[6948] = false,
}
