Avatar = Class()

local pinkAtlas = Assets.graphics["pink_alien"]()
local pinkQuads = Quads:getSetsOfQuads(pinkAtlas, CHARACTER_WIDTH, CHARACTER_HEIGHT)

local hitboxOffsets = {
    ["bottom"] = { 2, 0, -2, 0 },
    ["right"]  = { -1, 1, -1, -5 },
    ["left"]   = { 1, 1, 1, -5 },
    ["top"]    = { 3, 0, -3, 0 }
}

function Avatar:init(level)
    Modules:plugInBulk(self, {
        ["Coordinates"]        = { x = 50, y = 0 },
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

function Avatar:update(dt, blob)
    self:updateHitbox()
    self:getHurtBy(blob)
    self.stateMachine:update(dt)
    self:run(dt)
    self:getCoins()
end

function Avatar:getStates(level)
    return {
        ["idle"] = function() return PlayerIdleState(self, pinkQuads[1]) end,
        ["run"]  = function() return PlayerRunState(self, level, .1, { pinkQuads[10], pinkQuads[11] }) end,
        ["jump"] = function() return PlayerJumpState(self, level, pinkQuads[3]) end,
        ["fall"] = function() return ObjectFallState(level, self, pinkQuads[8]) end,
        -- ["fall"] = function() return ObjectFallState(self, level, pinkQuads[8]) end, -- tf
        ["hurt"] = function() return PlayerHurtState(self, pinkQuads[5]) end,
    }
end

function Avatar:jump()
    if App:keyPressed("space") then
        self:applyJumpForce(JUMPFORCE)
    end
end

function Avatar:run(dt)
    if App.canInput and love.keyboard.isDown("right") then
        self:moveX(dt, CHARACTER_SPEED)
        self:setRunning(true)
        self:setFacingRight(true)
        self:blockRun("right")
    elseif App.canInput and love.keyboard.isDown("left") then
        self:moveX(dt, -CHARACTER_SPEED)
        self:setRunning(true)
        self:setFacingRight(false)
        self:blockRun("left")
    else
        self:setRunning(false)
    end
end

function Avatar:blockRun(direction)
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

function Avatar:float(dt)
    if love.keyboard.isDown("down") then
        self:moveY(dt, CHARACTER_SPEED)
    elseif love.keyboard.isDown("up") then
        self:moveY(dt, -CHARACTER_SPEED)
    end
end

function Avatar:getHitboxOffset(direction)
    return hitboxOffsets[direction][1], hitboxOffsets[direction][2],
        hitboxOffsets[direction][3], hitboxOffsets[direction][4]
end

-- Looks like shit, pls fix that
function Avatar:getCoins()
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

function Avatar:getHurtBy(blob)
    if not self:collides(blob) then
        return
    end

    if self:getCurrentStateName() == "fall" then
        self.y = blob.y - self.height
        self:changeState("jump")
        return
    end

    self:setQuad(pinkQuads[5])
    self:changeState("hurt", blob)
end
