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
	mode = common.modes[1].mode,
	caseScenarioNecroMode = true
}

local currentConfig

this.resetDefaults = function(config)
	local resetConfig = {}
	for k, v in pairs(config) do
		-- ensure types are consistent, or reset to default
		if type(v) == type(this.defaultConfig[k]) then
			resetConfig[k] = config[k]
		else
			resetConfig[k] = this.defaultConfig[k]
		end
	end
	return resetConfig
end

this.getConfig = function()
	currentConfig = currentConfig or mwse.loadConfig(common.configString, this.defaultConfig)
	return currentConfig
end

return this
