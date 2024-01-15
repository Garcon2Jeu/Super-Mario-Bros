PlayerRunState = Class { __includes = BaseState }
PlayerRunState:setStateName("run")

function PlayerRunState:init(avatar, level, interval, frames)
    self.avatar = avatar
    self.level = level

    Modules:plug(self, "Animation",
        { interval = interval, frames = frames })
end

function PlayerRunState:update(dt)
    self.avatar:setQuad(self:getCurrentFrame())

    if App:keyPressed("space") then
        self.avatar:changeState("jump")
        return
    end

    local t1, t2 = self.avatar:getTilesFromHitPoints(self.level.tileMap, self.avatar, "bottom")
    local b1, b2 = self.avatar:getTilesFromHitPoints(self.level.blockMap, self.avatar, "bottom")

    -- TOFIX!!!!!! ----------------------------------------------------------------------------------------------------------------------

    -- for key, object in pairs { t1, t2, b1, b2 } do
    --     if not self.level:isTileCollidable(object) then
    --         self.avatar:changeState("fall")
    --         return
    --     end
    -- end

    -- if not self.level:isTileCollidable(t1) and not self.level:isTileCollidable(t2)
    --     or not self.level:isTileCollidable(b1) and not self.level:isTileCollidable(b2) then
    --     self.avatar:changeState("fall")
    --     return
    -- end

    if not self.avatar:isTileCollidable(t1) and not self.avatar:isTileCollidable(t2) then
        self.avatar:changeState("fall")
        return
    end
    -- if not self.level:isTileCollidable(b1) and not self.level:isTileCollidable(b2) then
    --     self.avatar:changeState("fall")
    --     return
    -- end

    -- if not self.level:isTileCollidable(b1) and not self.level:isTileCollidable(b2) then
    --     self.avatar:changeState("fall")
    --     return
    -- end

    ------------------------------------------------------------------------------------------------------------------------------------

    if not self.avatar:isRunning() then
        self.avatar:changeState("idle")
        return
    end
end

function PlayerRunState:exit()
    self:removeTimer(self)
end
