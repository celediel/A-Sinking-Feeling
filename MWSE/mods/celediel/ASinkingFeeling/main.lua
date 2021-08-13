local config = require("celediel.ASinkingFeeling.config").getConfig()
local common = require("celediel.ASinkingFeeling.common")

-- Helper Functions
local function getTotalArmourClass(actor)
    local armourClass = 0

    -- get armour level for each equipped piece of armour
    -- light = 0, medium = 1, heavy = 2, plus one so light armour is affected
    if actor and actor.equipment then
        for stack in tes3.iterate(actor.equipment) do
            local item = stack.object
            if item.objectType == tes3.objectType.armor then
                armourClass = armourClass + item.weightClass + 1
            end
        end
    end

    return armourClass
end

local function getTotalEquipmentWeight(actor)
    local weight = 0

    if actor and actor.equipment then
        for stack in tes3.iterate(actor.equipment) do
            local item = stack.object
            weight = weight + item.weight
        end
    end

    return weight
end

-- Formula functions
local formulas = {}

formulas.equippedArmour = function(actor, ref)
    local armourClass = getTotalArmourClass(actor)
    local downPull = (config.multipliers.equippedArmour / 10) * armourClass
    local debugStr = string.format("Pulling %s down by %s using equipped armour mode (%s total armour class)",
        ref.id, downPull, armourClass)
    return downPull, debugStr
end

formulas.allEquipment = function(actor, ref)
    local totalWeight = getTotalEquipmentWeight(actor)
    -- doubling this keeps this formula somewhat uniform with armour class @ multiplier 100
    local downPull = ((config.multipliers.allEquipment / 100) * totalWeight) * 2
    local debugStr = string.format("Pulling %s down by %s using equipment weight mode (%s total equipment weight)",
        ref.id, downPull, totalWeight)
    return downPull, debugStr
end

formulas.allEquipmentNecroEdit = function(actor, ref)
    local totalWeight = getTotalEquipmentWeight(actor)
    -- Thanks Necrolesian for this formula
    -- https://forums.nexusmods.com/index.php?/topic/10349253-a-sinking-feeling/page-2#entry97870268
    local term1 = ((config.multipliers.allEquipment / 100) * totalWeight) * 2
    local term2 = ((config.multipliers.allEquipment / 100) * (totalWeight - 135) * 0.2 + 270)
    local downPull = math.min(term1, term2)
    local debugStr = string.format("Pulling %s down by %s (instead of %s) using equipment weight mode (necro edit) (%s total equipment weight)",
        ref.id, downPull, math.max(term1, term2), totalWeight)
    return downPull, debugStr
end

formulas.encumbrancePercentage = function(mobile, ref)
    local encumbrance = mobile.encumbrance
    -- tripling this keeps this formula somewhat uniform with armour class @ multiplier 100
    local downPull = (config.multipliers.encumbrancePercentage * encumbrance.normalized) * 3
    local debugStr = string.format("Pulling %s down by %s using encumbrance mode (%s/%s = %s encumbrance)",
        ref.id, downPull, encumbrance.current, encumbrance.base, encumbrance.normalized)
    return downPull, debugStr
end

formulas.worstCaseScenario = function(actor, mobile, ref)
    local downPull = 0

    local results = {}
    -- todo: maybe loop over formulas to calculate each instead of this
    -- different formulas needing different actor/mobile might make it too unwieldy though
    results.equippedArmour = formulas.equippedArmour(actor, ref)
    results.allEquipment = formulas.allEquipment(actor, ref)
    if config.allEquipmentWorstCaseNecroMode then
        results.allEquipmentNecroEdit = formulas.allEquipmentNecroEdit(actor, ref)
    else
        results.encumbrancePercentage = formulas.encumbrancePercentage(mobile, ref)
    end

    local largest = common.keyOfLargestValue(results)
    downPull = results[largest]

    local debugStr = string.format("Pulling %s down by %s using worst mode:%s", ref.id, downPull, common.camelCaseToWords(largest))

    return downPull, debugStr
end

-- Event functions
local function sinkInWater(e)
    -- shortcut refs
    local mobile = e.mobile
    local ref = e.reference
    local actor = ref.object
    local waterLevel = mobile.cell.waterLevel
    local headHeight = mobile.position.z + mobile.height * 0.8

    -- no creatures
    if mobile.actorType == tes3.actorType.creature then return end

    -- if configured to be player only, bail if not player
    if config.playerOnly and mobile.actorType ~= tes3.actorType.player then return end

    local downPull = 0
    local debugStr = ""

    -- don't calculate if disabled
    if not config.enabled then
        downPull = 0
    -- calculate the down-pull with the configured formula
    elseif config.mode == common.modes.equippedArmour.value then
        downPull, debugStr = formulas.equippedArmour(actor, ref)
    elseif config.mode == common.modes.allEquipment.value then
        downPull, debugStr = formulas.allEquipment(actor, ref)
    elseif config.mode == common.modes.allEquipmentNecroEdit.value then
        downPull, debugStr = formulas.allEquipmentNecroEdit(actor, ref)
    elseif config.mode == common.modes.encumbrancePercentage.value then
        downPull, debugStr = formulas.encumbrancePercentage(mobile, ref)
    elseif config.mode == common.modes.worstCaseScenario.value then
        downPull, debugStr = formulas.worstCaseScenario(actor, mobile, ref)
    end

    -- reset if levitating
    if mobile.levitate > 0 then downPull = 0 end

    -- only if mostly underwater to stop pseudo-waterwalking when jumping into water
    if headHeight <= waterLevel then
        if downPull ~= 0 then
            -- finally add down-pull from configured formula to tes3.mobilePlayer.velocity.z to simulate being pulled down
            mobile.velocity.z = -downPull
            if config.debug then
                common.log(debugStr)
            end
        elseif mobile.velocity.z <= 0 then
            -- reset velocity removing of armour in water is accounted for
            mobile.velocity.z = 0
        end
    end
end

local function onInitialized()
    event.register("calcSwimSpeed", sinkInWater)
    common.log("Successfully initialized!")
end

event.register("initialized", onInitialized)
event.register("modConfigReady", function() mwse.mcm.register(require("celediel.ASinkingFeeling.mcm")) end)
