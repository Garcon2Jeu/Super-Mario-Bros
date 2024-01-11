Blob = Class()

local creaturesSheet = Assets.graphics["creatures"]()
local creaturesQuads = Quads:getSetsOfQuads(creaturesSheet, TILESIZE, TILESIZE)

function Blob:init(level)
    local def = {
        x = 50,
        y = 50,
        width = TILESIZE,
        height = TILESIZE,
        spriteSheet = creaturesSheet,
        quad = creaturesQuads[9]
    }

    BaseObject.init(self, def)

    Modules:plugInBulk(self, {
        ["Gravity"]            = {},
        ["Hitbox"]             = {},
        ["Move"]               = {},
        ["Asymmetric"]         = { xOffset = TILESIZE / 2, reverse = true },
        ["StateMachineModule"] = self:getStates(level),
    })

    self:changeState("fall")
    self:updateHitbox()
end

function Blob:getStates(level)
    return {
        ["idle"]  = function() return BlobIdleState(self, creaturesQuads[10]) end,
        ["fall"]  = function() return ObjectFallState(level, self, creaturesQuads[9]) end,
        ["chase"] = function() return BlobChaseState(level, self, 1.5, { creaturesQuads[9], creaturesQuads[10] }) end,
    }
end

function Blob:update(dt, player)
    self:updateHitbox()
    self:facePlayer(player)
    self.stateMachine:update(dt)
end

function Blob:getHitboxOffset()
end

function Blob:facePlayer(player)
    self:setFacingRight(player.x + (player.width / 2) > self.x + (self.width / 2))
end
