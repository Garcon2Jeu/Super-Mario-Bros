Avatar = Class()

local pinkAtlas = Assets.graphics["pink_alien"]()
local pinkQuads = Quads:getSetsOfQuads(pinkAtlas, CHARACTER_WIDTH, CHARACTER_HEIGHT)

local hitboxOffsets = {
    ["bottom"] = { x1 = 2, y1 = 0, x2 = -2, y2 = 0 },
    ["right"]  = { x1 = -1, y1 = 1, x2 = -1, y2 = -5 },
    ["left"]   = { x1 = 1, y1 = 1, x2 = 1, y2 = -5 },
    ["top"]    = { x1 = 3, y1 = 0, x2 = -3, y2 = 0 }
}

function Avatar:init(level)
    Modules:plugInBulk(self, {
        ["Player"]             = {},
        ["Coordinates"]        = { x = level.tileMap[2][1].x, y = 0 },
        ["Dimensions"]         = { width = CHARACTER_WIDTH, height = CHARACTER_HEIGHT },
        ["Texture"]            = { spriteSheet = pinkAtlas, quad = pinkQuads[1] },
        ["StateMachineModule"] = self:getStates(level),
        ["Gravity"]            = {},
        ["Move"]               = {},
        ["Hitbox"]             = { offsets = hitboxOffsets },
        ["Asymmetric"]         = { xOffset = CHARACTER_WIDTH / 2, },
        ["MapPointer"]         = {}
    })

    self:changeState("fall")
    self:updateHitbox()
end

function Avatar:update(dt, level)
    self:updateHitbox()
    self:collideWithEnnemis(level.ennemis)
    self.stateMachine:update(dt)
    self:run(dt)
    self:clampToTileMap(level.tileMap)
    self:getCoins()
    self:attainGoal(level)
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

function Avatar:clampToTileMap(tileMap)
    if self.x <= tileMap[1][1].x then
        self.x = 0
    elseif self.x + CHARACTER_WIDTH >= tileMap[#tileMap][1].x + TILESIZE then
        self.x = tileMap[#tileMap][1].x
    end
end

function Avatar:blockRun(direction)
    local t1, t2 = self:getTilesFromHitPoints(State.current.level.tileMap, direction)
    local b1, b2 = self:getTilesFromHitPoints(State.current.level.blockMap, direction)

    for key, object in pairs { t1, t2, b1, b2 } do
        if Modules:find(object, "Collidable") then
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

function Avatar:getCoins()
    local t1, t2 = self:getTilesFromHitPoints(State.current.level.coinMap, "bottom")
    local t3, t4 = self:getTilesFromHitPoints(State.current.level.coinMap, "top")
    local t5, t6 = self:getTilesFromHitPoints(State.current.level.coinMap, "left")
    local t7, t8 = self:getTilesFromHitPoints(State.current.level.coinMap, "right")

    for key, object in pairs { t1, t2, t3, t4, t5, t6, t7, t8 } do
        if Modules:find(object, "Collidable") then
            object:onCollide()
            return
        end
    end
end

function Avatar:collideWithEnnemis(ennemis)
    if not ennemis then
        return
    end

    for index, ennemi in ipairs(ennemis) do
        if ennemi:getCurrentStateName("dead")
            and not self:getCurrentStateName("hurt")
            or not self:collides(ennemi) then
            goto continue
        end

        if self:getCurrentStateName("fall") then
            State.current.level:kill(index)
            self.y = ennemi.y - self.height
            self:changeState("jump")

            goto continue
        end

        self:changeState("hurt", ennemi)
        ::continue::
    end
end

function Avatar:attainGoal(level)
    if self.x + self.width >= level.goal.x
        and not level.goal.flag:getCurrentStateName("attainned") then
        level.goal.flag:changeState("attainned")
    end
end
