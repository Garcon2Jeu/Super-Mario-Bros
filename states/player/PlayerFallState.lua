PlayerFallState = Class { __includes = BaseState }
PlayerFallState:setStateName("fall")

function PlayerFallState:init(level, avatar, quad)
    self.level = level
    self.avatar = avatar
    self.avatar:setQuad(quad)
end

function PlayerFallState:update(dt)
    self.avatar:applyGravity(GRAVITY)
    self.avatar:applyDY(dt)
    self:checkForGround()
end

function PlayerFallState:checkForGround()
    local t1, t2 = self.level:getTilesFromHitPoints(
        self.level.tileMap, self.avatar, "bottom")

    local b1, b2 = self.level:getTilesFromHitPoints(
        self.level.blockMap, self.avatar, "bottom")

    for key, object in pairs { t1, t2, b1, b2 } do
        if self.level:isCollidable(object) then
            object:onCollide(self.avatar, -CHARACTER_HEIGHT)
            self.avatar:changeState("idle")
            return
        end
    end
end
