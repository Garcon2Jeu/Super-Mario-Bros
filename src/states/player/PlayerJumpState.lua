PlayerJumpState = Class { __includes = BaseState }

function PlayerJumpState:init(level, player, quad)
    self.level = level
    self.player = player
    self.player:setQuad(quad)
    self.player:applyJumpForce(JUMPFORCE)
end

function PlayerJumpState:update(dt)
    local t1, t2 = self.level:getTilesFromHitPoints(
        self.level.blockMap, self.player, "top")

    if (t1 and t2) and (t1.collidable or t2.collidable) then
        self.player.dy = 0
        self.player.y = t1.y + TILESIZE
        self.player:changeState("fall")
    end


    self.player:applyGravity(GRAVITY)
    self.player:applyDY(dt)

    if self.player:isFalling() then
        self.player:changeState("fall")
    end
end
