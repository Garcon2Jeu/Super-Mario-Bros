PlayerCharacter = Class()

local pinkAtlas = Assets.graphics["pink_alien"]()
local pinkQuads = Quads:getSetsOfQuads(pinkAtlas, CHARACTER_WIDTH, CHARACTER_HEIGHT)

local hitboxOffsets = {
    ["bottom"] = { 2, 0, -2, 0 },
    ["right"]  = { -1, 1, -1, -5 },
    ["left"]   = { 1, 1, 1, -5 },
    ["top"]    = { 3, 0, -3, 0 }
}

function PlayerCharacter:init(level)
    Modules:plugInBulk(self, {
        ["Coordinates"]        = { x = CENTER_WIDTH - CHARACTER_WIDTH / 2, y = 0 },
        ["Dimensions"]         = { width = CHARACTER_WIDTH, height = CHARACTER_HEIGHT },
        ["Texture"]            = { spriteSheet = pinkAtlas, quad = pinkQuads[1] },
        ["StateMachineModule"] = self:getStates(level),
        ["Gravity"]            = {},
        ["Move"]               = {},
        ["Hitbox"]             = {},
        ["Asymmetric"]         = { xOffset = CHARACTER_WIDTH / 2, },
    })

    self:changeState("fall")
    self:updateHitbox()
end

function PlayerCharacter:update(dt, blob)
    self:updateHitbox()
    self.stateMachine:update(dt)
    self:run(dt)
    self:getCoins()
    self:getHurtBy(blob)
end

function PlayerCharacter:getStates(level)
    return {
        ["idle"] = function() return PlayerIdleState(self, pinkQuads[1]) end,
        ["run"]  = function() return PlayerRunState(level, self, .1, { pinkQuads[10], pinkQuads[11] }) end,
        ["jump"] = function() return PlayerJumpState(level, self, pinkQuads[3]) end,
        ["fall"] = function() return ObjectFallState(level, self, pinkQuads[8]) end,
    }
end

function PlayerCharacter:jump()
    if App:keyPressed("space") then
        self:applyJumpForce(JUMPFORCE)
    end
end

function PlayerCharacter:run(dt)
    if love.keyboard.isDown("right") then
        self:moveX(dt, CHARACTER_SPEED)
        self:setRunning(true)
        self:setFacingRight(true)
        self:blockRun("right")
    elseif love.keyboard.isDown("left") then
        self:moveX(dt, -CHARACTER_SPEED)
        self:setRunning(true)
        self:setFacingRight(false)
        self:blockRun("left")
    else
        self:setRunning(false)
    end
end

function PlayerCharacter:blockRun(direction)
    local t1, t2 = State.current.level:getTilesFromHitPoints(
        State.current.level.tileMap, self, direction)

    local b1, b2 = State.current.level:getTilesFromHitPoints(
        State.current.level.blockMap, self, direction)

    for key, object in pairs { t1, t2, b1, b2 } do
        if State.current.level:isCollidable(object) then
            self.x = direction == "right" and
                object.x - CHARACTER_WIDTH + 1 or object.x + TILESIZE - 2
        end
    end
end

function PlayerCharacter:float(dt)
    if love.keyboard.isDown("down") then
        self:moveY(dt, CHARACTER_SPEED)
    elseif love.keyboard.isDown("up") then
        self:moveY(dt, -CHARACTER_SPEED)
    end
end

function PlayerCharacter:getHitboxOffset(direction)
    return hitboxOffsets[direction][1], hitboxOffsets[direction][2],
        hitboxOffsets[direction][3], hitboxOffsets[direction][4]
end

-- Looks like shit, pls fix that
function PlayerCharacter:getCoins()
    local t1, t2 = State.current.level:getTilesFromHitPoints(
        State.current.level.coinMap, self, "bottom")
    local t3, t4 = State.current.level:getTilesFromHitPoints(
        State.current.level.coinMap, self, "top")
    local t5, t6 = State.current.level:getTilesFromHitPoints(
        State.current.level.coinMap, self, "left")
    local t7, t8 = State.current.level:getTilesFromHitPoints(
        State.current.level.coinMap, self, "right")

    for key, object in pairs { t1, t2, t3, t4, t5, t6, t7, t8 } do
        if State.current.level:isCollidable(object) then
            object:onCollide()
            return
        end
    end
end

function PlayerCharacter:getHurtBy(blob)
    if self:collides(blob) then
        self:setQuad(pinkQuads[5])
    end
end
