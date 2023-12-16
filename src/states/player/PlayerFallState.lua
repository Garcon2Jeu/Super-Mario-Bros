PlayerFallState = Class { __includes = BaseState }

function PlayerFallState:init(level, player, quad)
    self.level = level
    self.player = player
    self.player:setQuad(quad)
end

function PlayerFallState:update(dt)
    self.player:applyGravity(GRAVITY)
    self.player:applyDY(dt)

    local t1, t2 = self.level:getTilesFromHitPoints(
        self.level.tileMap, self.player, "bottom")

    local b1, b2 = self.level:getTilesFromHitPoints(
        self.level.blockMap, self.player, "bottom")

    if self.level:isCollidable(t1)
        or self.level:isCollidable(t2) then
        self.player:blockY((t1 and t1.y or t2.y) - CHARACTER_HEIGHT)
        self.player:changeState("idle")
        return
    end

    if self.level:isCollidable(b1) then
        b1:onCollide(self.player, -CHARACTER_HEIGHT)
        self.player:changeState("idle")
    elseif self.level:isCollidable(b2) then
        b2:onCollide(self.player, -CHARACTER_HEIGHT)
        self.player:changeState("idle")
    end

    -- if self.level:isCollidable(t1) then
    --     t1:onCollide(self.player, CHARACTER_HEIGHT)
    --     self.player:changeState("idle")
    -- elseif self.level:isCollidable(t2) then
    --     t2:onCollide(self.player, CHARACTER_HEIGHT)
    --     self.player:changeState("idle")
    -- elseif self.level:isCollidable(b1) then
    --     b1:onCollide(self.player, CHARACTER_HEIGHT)
    --     self.player:changeState("idle")
    -- elseif self.level:isCollidable(b2) then
    --     b2:onCollide(self.player, CHARACTER_HEIGHT)
    --     self.player:changeState("idle")
    --     return
    -- end
end
