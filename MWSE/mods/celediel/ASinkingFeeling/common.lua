local this = {}

this.modName = "A Sinking Feeling"
this.author = "Celediel"
this.modInfo = "No longer can you swim in heavy plate, now your armour, equipment or carried items drag you down while swimming.\n" ..
	"Options exist for formulas based on equipped armour weight class, total equipment weight or encumbrance percentage."
this.version = "1.0.0"
this.configString = string.gsub(this.modName, "%s+", "")
this.modes = {equippedArmour = 0, allEquipment = 1, encumbrancePercentage = 2}
this.log = function(...) mwse.log("[%s] %s", "Armoured Sinking", string.format(...)) end

return this