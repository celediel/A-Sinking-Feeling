local common = require("celediel.ASinkingFeeling.common")

local this = {}

this.defaultConfig = {
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

local currentConfig

this.getConfig = function()
	currentConfig = currentConfig or mwse.loadConfig(common.configString, this.defaultConfig)
	return currentConfig
end

return this
