PlayerRunState = Class { __includes = BaseState }
PlayerRunState:setStateName("run")

function PlayerRunState:init(level, avatar, interval, frames)
    self.level = level
    self.avatar = avatar

    Modules:plug(self, "Animation",
        { interval = interval, frames = frames })
end

function PlayerRunState:update(dt)
    self.avatar:setQuad(self:getCurrentFrame())

    if App:keyPressed("space") then
        self.avatar:changeState("jump")
        return
    end

    local t1, t2 = self.level:getTilesFromHitPoints(self.level.tileMap, self.avatar, "bottom")
    local b1, b2 = self.level:getTilesFromHitPoints(self.level.blockMap, self.avatar, "bottom")

    -- TOFIX!!!!!! ----------------------------------------------------------------------------------------------------------------------

    -- for key, object in pairs { t1, t2, b1, b2 } do
    --     if not self.level:isCollidable(object) then
    --         self.avatar:changeState("fall")
    --         return
    --     end
    -- end

    -- if not self.level:isCollidable(t1) and not self.level:isCollidable(t2)
    --     or not self.level:isCollidable(b1) and not self.level:isCollidable(b2) then
    --     self.avatar:changeState("fall")
    --     return
    -- end

    if not self.level:isCollidable(t1) and not self.level:isCollidable(t2) then
        self.avatar:changeState("fall")
        return
    end
    -- if not self.level:isCollidable(b1) and not self.level:isCollidable(b2) then
    --     self.avatar:changeState("fall")
    --     return
    -- end

    -- if not self.level:isCollidable(b1) and not self.level:isCollidable(b2) then
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
