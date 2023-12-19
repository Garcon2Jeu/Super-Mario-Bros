PlayerCharacter = Class { __includes = {

    MoveBundle,
    Hitbox,

} }

local pinkAtlas = Assets.graphics["pink_alien"]()
local pinkQuads = Quads:getSetsOfQuads(pinkAtlas, CHARACTER_WIDTH, CHARACTER_HEIGHT)

local hitboxOffsets = {
    ["bottom"] = { 2, 0, -2, 0 },
    ["right"]  = { -1, 1, -1, -5 },
    ["left"]   = { 1, 1, 1, -5 },
    ["top"]    = { 3, 0, -3, 0 }
}

-- function PlayerCharacter:init(level)
--     GameObject.init(self, {
--         x       = CENTER_WIDTH - CHARACTER_WIDTH / 2,
--         y       = 0,
--         width   = CHARACTER_WIDTH,
--         height  = CHARACTER_HEIGHT,
--         texture = pinkAtlas,
--     })

--     GravityBundle.init(self)
--     ObjectStateMachine.init(self, self:getStates(level))
--     self:changeState("fall")

--     self.width       = CHARACTER_WIDTH
--     self.height      = CHARACTER_HEIGHT
--     self.xOffset     = CHARACTER_WIDTH / 2 or 0
--     self.facingRight = true
-- end

function PlayerCharacter:init(level)
    BaseObject.init(self, {
        x           = CENTER_WIDTH - CHARACTER_WIDTH / 2,
        y           = 0,
        width       = CHARACTER_WIDTH,
        height      = CHARACTER_HEIGHT,
        spriteSheet = pinkAtlas,
        quad        = pinkQuads[1]
    })

    ModuleManager:plugInBulk(self, {
        ["Gravity"] = {},
        ["StateMachineModule"] = self:getStates(level)
    })

    -- ObjectStateMachine.init(self, self:getStates(level))
    self:changeState("fall")

    self.xOffset     = CHARACTER_WIDTH / 2 or 0
    self.facingRight = true
end

function PlayerCharacter:update(dt)
    self:updateHitbox()
    self.stateMachine:update(dt)
    self:run(dt)
end

function PlayerCharacter:draw()
    love.graphics.draw(
        self.spriteSheet, self.quad,
        math.floor(self.x + self.xOffset),
        math.floor(self.y),
        0,
        self.facingRight and 1 or -1, 1,
        self.xOffset
    )
end

function PlayerCharacter:getStates(level)
    return {
        ["idle"] = function() return PlayerIdleState(self, pinkQuads[1]) end,
        ["run"]  = function() return PlayerRunState(level, self, .1, { pinkQuads[10], pinkQuads[11] }) end,
        ["jump"] = function() return PlayerJumpState(level, self, pinkQuads[3]) end,
        ["fall"] = function() return PlayerFallState(level, self, pinkQuads[8]) end,
    }
end

function PlayerCharacter:jump()
    if App:keyPressed("space") then
        self:applyJumpForce(JUMPFORCE)
    end
end

function PlayerCharacter:blockY(y)
    self:setY(y)
    self:stopDY()
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

function PlayerCharacter:isFacingRight()
    return self.facingRight
end

function PlayerCharacter:setFacingRight(bool)
    self.facingRight = bool
end
