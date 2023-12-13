PlayerCharacter = Class { __includes = {
    GameObject,
    GravityBundle,
    MoveBundle
} }

local pinkAtlas = Assets.graphics["pink_alien"]()
local pinkQuads = Quads:getSetsOfQuads(pinkAtlas, CHARACTER_WIDTH, CHARACTER_HEIGHT)

function PlayerCharacter:init()
    GameObject.init(self, {
        x       = 50,
        y       = 50,
        width   = CHARACTER_WIDTH,
        height  = CHARACTER_HEIGHT,
        texture = pinkAtlas,
        quad    = pinkQuads[1]
    })

    GravityBundle.init(self)
end

function PlayerCharacter:update(dt)
    self:run(dt)
    self:jump()
    self:applyGravity(GRAVITY)
    self:applyDY(dt)
    self:stand()
end

function PlayerCharacter:run(dt)
    if love.keyboard.isDown("right") then
        self:moveX(dt, CHARACTER_SPEED)
    elseif love.keyboard.isDown("left") then
        self:moveX(dt, -CHARACTER_SPEED)
    end
end

function PlayerCharacter:jump()
    if App:keyPressed("space") then
        self:applyJumpForce(JUMPFORCE)
    end
end

function PlayerCharacter:stand()
    if self.dy > 0 and self.y >= 6 * TILESIZE then
        self.y = 6 * TILESIZE
        self.dy = 0
    end
end
