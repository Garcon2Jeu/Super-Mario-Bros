PlayerFallState = Class { __includes = BaseState }

function PlayerFallState:init(player, quad)
    self.player = player
    self.player:setQuad(quad)
end

function PlayerFallState:update(dt)
    self.player:applyGravity(GRAVITY)
    self.player:applyDY(dt)

    local t1, t2 = State.current.level:getTilesFromHitPoints(State.current.level.tileMap, self.player, "bottom")

    if (t1 and t2) and (t1.ground or t2.ground) then
        self.player:stand(t1.y - CHARACTER_HEIGHT)
        self.player:changeState("idle")
    end
end
