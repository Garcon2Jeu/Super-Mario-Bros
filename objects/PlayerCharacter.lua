PlayerCharacter = Class { __includes = {
    GameObject,
    GravityBundle,
    MoveBundle,
    Hitbox
} }

local pinkAtlas = Assets.graphics["pink_alien"]()
local pinkQuads = Quads:getSetsOfQuads(pinkAtlas, CHARACTER_WIDTH, CHARACTER_HEIGHT)

local hitboxOffsets = {
    ["bottom"] = { 2, 0, -2, 0 },
    ["right"]  = { -1, 1, -1, -1 },
    ["left"]   = { 1, 1, 1, -1 },
    ["top"]    = { 3, 0, -3, 0 }
}

function PlayerCharacter:init()
    local stateMachine = StateMachine {
        ["idle"] = function() return PlayerIdleState(self, pinkQuads[1]) end,
        ["run"]  = function() return PlayerRunState(self, .1, { pinkQuads[10], pinkQuads[11] }) end,
        ["jump"] = function() return PlayerJumpState(self, pinkQuads[3]) end,
        ["fall"] = function() return PlayerFallState(self, pinkQuads[8]) end,
    }

    GameObject.init(self, {
        x            = CENTER_WIDTH - CHARACTER_WIDTH / 2,
        y            = 0,
        width        = CHARACTER_WIDTH,
        height       = CHARACTER_HEIGHT,
        texture      = pinkAtlas,
        stateMachine = stateMachine
    })

    GravityBundle.init(self)

    self:changeState("fall")
end

function PlayerCharacter:update(dt)
    self:updateHitbox()
    self:run(dt)
    self.stateMachine:update(dt)
end

function PlayerCharacter:jump()
    if App:keyPressed("space") then
        self:applyJumpForce(JUMPFORCE)
    end
end

function PlayerCharacter:stand(y)
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
    local t1, t2 = State.current.level:getTilesFromHitPoints(State.current.level.tileMap, self, direction)

    if (t1 and t2) and (t1.ground or t2.ground) then
        self.x = direction == "right" and t1.x - CHARACTER_WIDTH + 1 or t2.x + TILESIZE - 2
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
