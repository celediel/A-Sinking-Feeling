local config = require("celediel.ASinkingFeeling.config")
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

-- Event functions
local function sinkInWater(e)
    -- don't even calculate anything if disabled
    if not config.enabled then return end

    -- shortcut refs
    local mobile = e.mobile
    local ref = e.reference
    local actor = ref.object

    -- no creatures
    if mobile.actorType == tes3.actorType.creature then return end

    -- if configured to be player only, bail if not player
    if config.playerOnly and mobile.actorType ~= tes3.actorType.player then return end

    local downPull = 0

    -- calculate the down-pull with the configured formula
    if config.mode == common.modes.equippedArmour then
        local armourClass = getTotalArmourClass(actor)
        downPull = (config.downPullMultiplier / 10) * armourClass
        if config.debug then
            common.log("Pulling %s down by %s using equipped armour mode (%s total armour class)",
                ref.id, downPull, armourClass)
        end

    elseif config.mode == common.modes.allEquipment then
        local totalWeight = getTotalEquipmentWeight(actor)
        -- doubling this keeps this formula somewhat uniform with armour class @ multiplier 100
        downPull = ((config.downPullMultiplier / 100) * totalWeight) * 2
        if config.debug then
            common.log("Pulling %s down by %s using equipment weight mode (%s total equipment weight)",
                ref.id, downPull, totalWeight)
        end

    elseif config.mode == common.modes.encumbrancePercentage then
        local encumbrance = mobile.encumbrance
        -- tripling this keeps this formula somewhat uniform with armour class @ multiplier 100
        downPull = (config.downPullMultiplier * encumbrance.normalized) * 3
        if config.debug then
            common.log("Pulling %s down by %s using encumbrance mode (%s/%s = %s encumbrance)",
                ref.id, downPull, encumbrance.current, encumbrance.base, encumbrance.normalized)
        end
    end

    -- finally add down-pull from configured formula to tes3.mobilePlayer.velocity.z to simulate being pulled down
    if downPull ~= 0 then mobile.velocity.z = -downPull end
end

local function onInitialized()
    event.register("calcSwimSpeed", sinkInWater)
    common.log("Successfully initialized!")
end

event.register("initialized", onInitialized)
event.register("modConfigReady", function() mwse.mcm.register(require("celediel.ASinkingFeeling.mcm")) end)