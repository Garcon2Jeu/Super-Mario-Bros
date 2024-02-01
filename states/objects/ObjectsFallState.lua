ObjectFallState = Class { __includes = BaseState }
ObjectFallState:setStateName("fall")

function ObjectFallState:init(level, object, quad)
    self.object = object
    self.level = level

    self.object:setQuad(quad)
end

function ObjectFallState:update(dt)
    self.object:applyGravity(GRAVITY)
    self.object:applyDY(dt)
    self:checkForGround()
end

function ObjectFallState:checkForGround()
    -- local t1, t2 = self:getTilesFromHitPoints(
    --     self.level.tileMap, self.object, "bottom")

    -- local b1, b2 = self:getTilesFromHitPoints(
    --     self.level.blockMap, self.object, "bottom")
    local t1, t2 = self.object:getTilesFromHitPoints(
        self.level.tileMap, "bottom")

    local b1, b2 = self.object:getTilesFromHitPoints(
        self.level.blockMap, "bottom")

    for key, tile in pairs { t1, t2, b1, b2 } do
        if Modules:find(tile, "Collidable") then
            tile:onCollide(self.object, -self.object.height)
            self.object:changeState("idle")
            return
        end
    end
end
