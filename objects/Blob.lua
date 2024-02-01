Blob = Class()

local creaturesSheet = Assets.graphics["creatures"]()
local creaturesQuads = Quads:getSetsOfQuads(creaturesSheet, TILESIZE, TILESIZE)

local def = {
    x           = CENTER_WIDTH - CHARACTER_WIDTH / 2,
    y           = 50,
    width       = TILESIZE,
    height      = TILESIZE,
    spriteSheet = creaturesSheet,
}

function Blob:init(params)
    def.x = params.x or def.x
    def.y = params.y or def.y

    BaseObject.init(self, def)

    Modules:plugInBulk(self, {
        ["Gravity"]            = {},
        ["Hitbox"]             = {},
        ["Move"]               = {},
        ["Asymmetric"]         = { xOffset = TILESIZE / 2, reverse = true },
        ["StateMachineModule"] = self:getStates(params.level),
        ["MapPointer"]         = {}
    })

    self:changeState("fall")
    self:updateHitbox()
end

function Blob:update(dt, player)
    if self:getCurrentStateName("dead") then
        return
    end

    self:updateHitbox()
    self:facePlayer(player)
    self.stateMachine:update(dt)
end

function Blob:getStates(level)
    return {
        ["idle"]  = function() return BlobIdleState(self, creaturesQuads[10]) end,
        ["fall"]  = function() return ObjectFallState(level, self, creaturesQuads[9]) end,
        ["chase"] = function() return BlobChaseState(level, self, 1.5, { creaturesQuads[9], creaturesQuads[10] }) end,
        ["dead"]  = function() return BlobDeadState(self, creaturesQuads[11]) end
    }
end

function Blob:getHitboxOffset()
end

function Blob:facePlayer(player)
    self:setFacingRight(player.x + (player.width / 2) > self.x + (self.width / 2))
end

function Blob:die()
    self:changeState("dead")
end

function Blob:blockRun(direction)
    local t1, t2 = self:getTilesFromHitPoints(State.current.level.tileMap, direction)
    local b1, b2 = self:getTilesFromHitPoints(State.current.level.blockMap, direction)

    for key, object in pairs { t1, t2, b1, b2 } do
        if Modules:find(object, "Collidable") then
            self.x = direction == "right" and
                object.x - CHARACTER_WIDTH + 1 or object.x + TILESIZE - 2
        end
    end
end
