PlayerJumpState = Class { __includes = BaseState }
PlayerJumpState:setStateName("jump")

function PlayerJumpState:init(avatar, level, quad)
    self.avatar = avatar
    self.level = level
    self.avatar:setQuad(quad)
    self.avatar:applyJumpForce(JUMPFORCE)
end

function PlayerJumpState:update(dt)
    -- if App:keyPressed("space") then
    --     self.avatar:applyJumpForce(JUMPFORCE)
    -- end
    local b1, b2 = self.avatar:getTilesFromHitPoints(
        self.level.blockMap, self.avatar, "top")

    if self.avatar:isTileCollidable(b1) then
        b1:onCollide(self.avatar, TILESIZE)
        self.avatar:changeState("fall")
    elseif self.avatar:isTileCollidable(b2) then
        b2:onCollide(self.avatar, TILESIZE)
        self.avatar:changeState("fall")
    end


    self.avatar:applyGravity(GRAVITY)
    self.avatar:applyDY(dt)

    if self.avatar:isFalling() then
        self.avatar:changeState("fall")
    end
end
