Blob = Class()

local creaturesSheet = Assets.graphics["creatures"]()
local creaturesQuads = Quads:getSetsOfQuads(creaturesSheet, TILESIZE, TILESIZE)

local hitboxOffsets = {
    ["bottom"] = { x1 = 2, y1 = 0, x2 = -2, y2 = 0 },
    ["right"]  = { x1 = -1, y1 = 1, x2 = -1, y2 = -5 },
    ["left"]   = { x1 = 1, y1 = 1, x2 = 1, y2 = -5 },
    ["top"]    = { x1 = 3, y1 = 0, x2 = -3, y2 = 0 }
}

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
        ["Hitbox"]             = { offsets = hitboxOffsets },
        ["Move"]               = {},
        ["Asymmetric"]         = { xOffset = TILESIZE / 2, reverse = true },
        ["StateMachineModule"] = self:getStates(params.level),
        ["MapPointer"]         = {}
    })

    self:changeState("fall")
    self:updateHitbox()
end

function Blob:update(dt, player)
    self:updateHitbox()
    self:facePlayer(player)
    self.stateMachine:update(dt)
    self:blockRun()
end

function Blob:getStates(level)
    return {
        ["idle"]  = function() return BlobIdleState(self, creaturesQuads[10]) end,
        ["fall"]  = function() return ObjectFallState(level, self, creaturesQuads[9]) end,
        ["chase"] = function() return BlobChaseState(level, self, 1.5, { creaturesQuads[9], creaturesQuads[10] }) end,
        ["dead"]  = function() return BlobDeadState(self, creaturesQuads[11]) end
    }
end

function Blob:getHitboxOffset(direction)
    return hitboxOffsets[direction]
end

function Blob:facePlayer(player)
    self:setFacingRight(player.x + (player.width / 2) > self.x + (self.width / 2))
end

function Blob:die()
    self:changeState("dead")
end

function Blob:blockRun()
    local collidableTile = self:checkforWall()

    if collidableTile then
        self.dx = 0
        self.x = self.facingRight
            and collidableTile.x - CHARACTER_WIDTH - 1
            or collidableTile.x + TILESIZE + 1
        return
    end

    if self:checkForChasm() then
        self.facingRight = not self.facingRight
    end
end
