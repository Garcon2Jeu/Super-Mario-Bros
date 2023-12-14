PlayerCharacter = Class { __includes = {
    GameObject,
    GravityBundle,
    MoveBundle
} }

local pinkAtlas = Assets.graphics["pink_alien"]()
local pinkQuads = Quads:getSetsOfQuads(pinkAtlas, CHARACTER_WIDTH, CHARACTER_HEIGHT)


function PlayerCharacter:init()
    local stateMachine = StateMachine {
        ["idle"] = function() return PlayerIdleState(self, pinkQuads[1]) end,
        ["run"]  = function() return PlayerRunState(self, .1, { pinkQuads[10], pinkQuads[11] }) end,
        ["jump"] = function() return PlayerJumpState(self, pinkQuads[3]) end,
        ["fall"] = function() return PlayerFallState(self, pinkQuads[8]) end,
    }

    GameObject.init(self, {
        x            = CENTER_WIDTH - CHARACTER_WIDTH / 2,
        y            = -150,
        width        = CHARACTER_WIDTH,
        height       = CHARACTER_HEIGHT,
        texture      = pinkAtlas,
        stateMachine = stateMachine
    })

    GravityBundle.init(self)

    self:changeState("fall")
end

function PlayerCharacter:update(dt)
    self:run(dt)
    self.stateMachine:update(dt)
end

function PlayerCharacter:jump()
    if App:keyPressed("space") then
        self:applyJumpForce(JUMPFORCE)
    end
end

function PlayerCharacter:stand()
    self.y = 6 * TILESIZE
    self:stopDY()
end

function PlayerCharacter:isGrounded()
    return self.y >= 5 * TILESIZE - CHARACTER_HEIGHT
end

function PlayerCharacter:run(dt)
    if love.keyboard.isDown("right") then
        self:moveX(dt, CHARACTER_SPEED)
        self:setRunning(true)
        self:setFacingRight(true)
    elseif love.keyboard.isDown("left") then
        self:moveX(dt, -CHARACTER_SPEED)
        self:setRunning(true)
        self:setFacingRight(false)
    else
        self:setRunning(false)
    end
end
