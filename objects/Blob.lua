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
        ["StateMachineModule"] = self:getStates(level),
    })

    self:changeState("fall")
    self.xOffset     = CHARACTER_WIDTH / 2 or 0
    self.facingRight = true
end

function Blob:getStates(level)
    return {
        ["idle"]  = function() return BlobIdleState(self, creaturesQuads[10]) end,
        ["fall"]  = function() return ObjectFallState(level, self, creaturesQuads[9]) end,
        ["chase"] = function() return BlobChaseState(level, self, 1.5, { creaturesQuads[9], creaturesQuads[10] }) end,
    }
end

function Blob:update(dt)
    self:updateHitbox()
    self.stateMachine:update(dt)
end

function Blob:draw()
    love.graphics.draw(
        self.spriteSheet, self.quad,
        math.floor(self.x + self.xOffset),
        math.floor(self.y),
        0,
        self.facingRight and -1 or 1, 1,
        self.xOffset
    )
end

function Blob:getHitboxOffset()
end
