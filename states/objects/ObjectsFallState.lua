ObjectFallState = Class { __includes = BaseState }
ObjectFallState:setStateName("fall")

function ObjectFallState:init(level, object, quad)
    self.level = level
    self.object = object
    self.object:setQuad(quad)
end

function ObjectFallState:update(dt)
    self.object:applyGravity(GRAVITY)
    self.object:applyDY(dt)
    self:checkForGround()
end

function ObjectFallState:checkForGround()
    local t1, t2 = self.level:getTilesFromHitPoints(
        self.level.tileMap, self.object, "bottom")

    local b1, b2 = self.level:getTilesFromHitPoints(
        self.level.blockMap, self.object, "bottom")

    for key, object in pairs { t1, t2, b1, b2 } do
        if self.level:isCollidable(object) then
            object:onCollide(self.object, -self.object.height)
            self.object:changeState("idle")
            return
        end
    end
end
