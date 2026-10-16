-- Synthetic SavedVariables: previous addon version with the current database schema; fill defaults and remove obsolete options.
-- No real player data. Version "test" is the version supplied by the test harness.
-- Includes the current character's SavedVariablesPerCharacter table.

Commodum_Options_v3 = {
	["account"] = {
		["general"] = {
			["debug-mode"] = "obsolete-type",
			["minimap-button"] = {
				["hide"] = false,
				["minimapPos"] = 90,
				["obsolete"] = true,
			},
		},
		["obsolete-section"] = {
			["enabled"] = true,
		},
		["quality-of-life"] = {
			["auto-repair"] = false,
			["auto-sell"] = true,
			["auto-sell-marking-modifier"] = "CTRL",
			["military-time"] = false,
			["obsolete-option"] = 1,
		},
	},
	["global"] = {
		["obsolete"] = true,
		["version"] = "fixture-previous",
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
				["debug-mode"] = "obsolete-type",
				["minimap-button"] = {
					["hide"] = true,
					["minimapPos"] = 0,
					["obsolete"] = true,
				},
			},
			["obsolete-section"] = {
				["enabled"] = true,
			},
			["quality-of-life"] = {
				["auto-repair"] = false,
				["auto-sell"] = true,
				["auto-sell-marking-modifier"] = "CTRL",
				["military-time"] = false,
				["obsolete-option"] = 1,
			},
		},
		["Player-TEST-OFFLINE"] = {
			["general"] = {
				["debug-mode"] = "obsolete-type",
				["minimap-button"] = {
					["hide"] = false,
					["minimapPos"] = 270,
					["obsolete"] = true,
				},
			},
			["obsolete-section"] = {
				["enabled"] = true,
			},
			["quality-of-life"] = {
				["auto-repair"] = false,
				["auto-sell"] = true,
				["auto-sell-marking-modifier"] = "CTRL",
				["military-time"] = false,
				["obsolete-option"] = 1,
			},
		},
	},
}

Commodum_DataAutoSell = {
	[2589] = true,
	[2592] = true,
	[6948] = false,
}
