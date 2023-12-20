PlayerJumpState = Class { __includes = BaseState }

function PlayerJumpState:init(level, player, quad)
    self.level = level
    self.player = player
    self.player:setQuad(quad)
    self.player:applyJumpForce(JUMPFORCE)
end

function PlayerJumpState:update(dt)
    local b1, b2 = self.level:getTilesFromHitPoints(
        self.level.blockMap, self.player, "top")

    if self.level:isCollidable(b1) then
        b1:onCollide(self.player, TILESIZE)
        self.player:changeState("fall")
    elseif self.level:isCollidable(b2) then
        b2:onCollide(self.player, TILESIZE)
        self.player:changeState("fall")
    end


    self.player:applyGravity(GRAVITY)
    self.player:applyDY(dt)

    if self.player:isFalling() then
        self.player:changeState("fall")
    end
end
