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

    if (t1 and t2) and (t1.ground or t2.ground) or
        (b1 and b2) and (b1.collidable or b2.collidable) then
        self.player:stand(t1.y - CHARACTER_HEIGHT)
        self.player:changeState("idle")
    end
end
