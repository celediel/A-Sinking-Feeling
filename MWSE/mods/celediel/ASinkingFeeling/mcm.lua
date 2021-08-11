local common = require("celediel.ASinkingFeeling.common")
local config = require("celediel.ASinkingFeeling.config")

local function createTableVar(id) return mwse.mcm.createTableVariable {id = id, table = config} end

local function createDescriptions()
    local description = "Formula used to calculate down-pull amount.\n\nOptions are: "
    local options = ""

    -- list all current modes
    for mode, _ in pairs(common.modes) do
        options = options .. common.camelCaseToWords(mode) .. ", "
    end

    -- strip off ending ", "
    options = options:sub(1, string.len(options) - 2)

    -- add modes to description
    description = description .. options

    -- add descriptions to description
    for mode, t in pairs(common.modes) do
        description = description .. "\n\n" .. common.camelCaseToWords(mode) .. ": " .. t.description
    end

    return description
end

local function createOptions()
    local options = {}

    for mode, t in pairs(common.modes) do
        options[#options+1] = {label = common.camelCaseToWords(mode), value = t.value}
    end

    return options
end

local template = mwse.mcm.createTemplate(common.modName)
template:saveOnClose(common.configString, config)

local page = template:createSideBarPage({
    label = "Sidebar Page???",
    description = string.format("%s v%s by %s\n\n%s", common.modName, common.version, common.author, common.modInfo)
})

local category = page:createCategory(common.modName)

category:createYesNoButton({
    label = "Enable the mod",
    description = "Does what it says!",
    variable = createTableVar("enabled")
})

category:createYesNoButton({
    label = "Player-only",
    description = "The mod only affects the player, not other actors.",
    variable = createTableVar("playerOnly")
})

category:createDropdown({
    label = "Down-pull formula",
    description = createDescriptions(),
    options = createOptions(),
    variable = createTableVar("mode")
})

category:createSlider({
    label = "Down-pull multiplier",
    description = "Multiplier used in the selected formula.\n\nDefault value of 100 acts similarly in all formulas.",
    variable = createTableVar("downPullMultiplier"),
    min = 0,
    max = 300,
    step = 1,
    jump = 10
})

category:createYesNoButton({
    label = "Debug logging",
    description = "Spam mwse.log with useless nonsense.",
    variable = createTableVar("debug")
})

return template
