local common = require("celediel.ASinkingFeeling.common")

local defaultConfig = {
	enabled = true,
	debug = false,
	playerOnly = false,
	multipliers = {
		equippedArmour = 100,
		allEquipment = 100,
		encumbrancePercentage = 100
	},
	mode = common.modes.equippedArmour.value
}

local config = mwse.loadConfig(common.configString, defaultConfig)

return config
