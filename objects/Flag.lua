Flag = Class()

local goalAtlas = Assets.graphics["flags"]()

local flagsSet = {
    x = 96,
    y = 0,
    width = 16,
    height = 10,
    gap = 8,
    amount = 6,
    interval = .13,
    lastFlagWidth = 6,
    lastFlagHeight = 15
}

local flagsQuads = {}

for i = 1, 3 do
    table.insert(flagsQuads, love.graphics.newQuad(
        flagsSet.x + (i - 1) * flagsSet.width,
        flagsSet.y,
        i < 3 and flagsSet.width or flagsSet.lastFlagWidth,
        i < 3 and flagsSet.height or flagsSet.lastFlagHeight,
        goalAtlas:getDimensions())
    )
end

function Flag:init(goal)
    Modules:plugInBulk(self, {
        ["Coordinates"]        = { x = goal.x + 6, y = goal.y + 33 },
        ["Texture"]            = { spriteSheet = goalAtlas, quad = flagsQuads[3] },
        ["StateMachineModule"] = self:getStates(goal),
        ["Animation"]          = { frames = { flagsQuads[1], flagsQuads[2] }, interval = flagsSet.interval },
    })

    self:changeState("locked")
end

function Flag:getStates(goal)
    return {
        ["locked"]    = function() return FlagLockedState() end,
        ["unlocked"]  = function() return FlagUnlockedState(self, flagsQuads[3]) end,
        ["attainned"] = function() return FlagAttainnedState(self, goal) end
    }
end
