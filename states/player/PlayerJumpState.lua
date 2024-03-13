PlayerJumpState = Class { __includes = BaseState }
PlayerJumpState:setStateName("jump")

function PlayerJumpState:init(avatar, level, quad)
    Assets.audio["jump"]:play()
    self.avatar = avatar
    self.level = level
    self.avatar:setQuad(quad)
    self.avatar:applyJumpForce(JUMPFORCE)
end

function PlayerJumpState:update(dt)
    local b1, b2 = self.avatar:getTilesFromHitPoints(
        self.level.blockMap, "top")

    if Modules:find(b1, "Collidable") then
        b1:onCollide(self.avatar, TILESIZE)
        self.avatar:changeState("fall")
    elseif Modules:find(b2, "Collidable") then
        b2:onCollide(self.avatar, TILESIZE)
        self.avatar:changeState("fall")
    end


    self.avatar:applyGravity(GRAVITY)
    self.avatar:applyDY(dt)

    if self.avatar:isFalling() then
        self.avatar:changeState("fall")
    end
end
