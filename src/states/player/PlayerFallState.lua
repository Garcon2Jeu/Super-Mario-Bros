PlayerFallState = Class { __includes = BaseState }

function PlayerFallState:init(level, player, quad)
    self.level = level
    self.player = player
    self.player:setQuad(quad)
end

function PlayerFallState:update(dt)
    self.player:applyGravity(GRAVITY)
    self.player:applyDY(dt)
    self:checkForGround()
end

function PlayerFallState:checkForGround()
    local t1, t2 = self.level:getTilesFromHitPoints(
        self.level.tileMap, self.player, "bottom")

    local b1, b2 = self.level:getTilesFromHitPoints(
        self.level.blockMap, self.player, "bottom")

    for key, object in pairs { t1, t2, b1, b2 } do
        if self.level:isCollidable(object) then
            object:onCollide(self.player, -CHARACTER_HEIGHT)
            self.player:changeState("idle")
            return
        end
    end
end
