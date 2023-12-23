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
        ["Gravity"] = {},
        ["Hitbox"] = {},
        ["StateMachineModule"] = self:getStates(level)
    })

    self:changeState("fall")
end

function Blob:getStates(level)
    return {
        ["idle"] = function() return BlobIdleState(self, creaturesQuads[10]) end,
        ["fall"] = function() return ObjectFallState(level, self, creaturesQuads[9]) end
    }
end

function Blob:update(dt)
    self:updateHitbox()
    self.stateMachine:update(dt)
end

-- function Blob:draw()
--     TextureModule.draw(self)
--     self:drawPoints()
-- end

function Blob:getHitboxOffset()
end
