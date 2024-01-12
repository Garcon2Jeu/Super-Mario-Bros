PlayerJumpState = Class { __includes = BaseState }
PlayerJumpState:setStateName("jump")

function PlayerJumpState:init(level, avatar, quad)
    self.level = level
    self.avatar = avatar
    self.avatar:setQuad(quad)
    self.avatar:applyJumpForce(JUMPFORCE)
end

function PlayerJumpState:update(dt)
    local b1, b2 = self.level:getTilesFromHitPoints(
        self.level.blockMap, self.avatar, "top")

    if self.level:isCollidable(b1) then
        b1:onCollide(self.avatar, TILESIZE)
        self.avatar:changeState("fall")
    elseif self.level:isCollidable(b2) then
        b2:onCollide(self.avatar, TILESIZE)
        self.avatar:changeState("fall")
    end


    self.avatar:applyGravity(GRAVITY)
    self.avatar:applyDY(dt)

    if self.avatar:isFalling() then
        self.avatar:changeState("fall")
    end
end
