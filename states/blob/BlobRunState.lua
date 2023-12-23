-- PlayerRunState = Class { __includes = {
--     BaseState,
-- } }

-- function PlayerRunState:init(level, player, interval, frames)
--     self.level = level
--     self.player = player

--     Modules:plug(self, "Animation",
--         { interval = interval, frames = frames })
-- end

-- function PlayerRunState:update(dt)
--     self.player:setQuad(self:getCurrentFrame())

--     if App:keyPressed("space") then
--         self.player:changeState("jump")
--         return
--     end

--     local t1, t2 = self.level:getTilesFromHitPoints(self.level.tileMap, self.player, "bottom")
--     local b1, b2 = self.level:getTilesFromHitPoints(self.level.blockMap, self.player, "bottom")

--     -- TOFIX!!!!!! ----------------------------------------------------------------------------------------------------------------------

--     -- for key, objectPairs in pairs { { t1, t2 }, { b1, b2 } } do
--     --     if not self.level:isCollidable(objectPairs[1])
--     --         and not self.level:isCollidable(objectPairs[2]) then
--     --         self.player:changeState("fall")
--     --         return
--     --     end
--     -- end

--     -- if not self.level:isCollidable(t1) and not self.level:isCollidable(t2)
--     --     or not self.level:isCollidable(b1) and not self.level:isCollidable(b2) then
--     --     self.player:changeState("fall")
--     --     return
--     -- end

--     if not self.level:isCollidable(t1) and not self.level:isCollidable(t2) then
--         self.player:changeState("fall")
--         return
--     end

--     -- if not self.level:isCollidable(b1) and not self.level:isCollidable(b2) then
--     --     self.player:changeState("fall")
--     --     return
--     -- end

--     ------------------------------------------------------------------------------------------------------------------------------------

--     if not self.player:isRunning() then
--         self.player:changeState("idle")
--         return
--     end
-- end

-- function PlayerRunState:exit()
--     self:removeTimer(self)
-- end
