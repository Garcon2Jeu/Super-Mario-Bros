PlayerRunState = Class { __includes = {
    BaseState,
    Animation,
} }

function PlayerRunState:init(level, player, interval, frames)
    self.level = level
    self.player = player

    Animation.init(self, interval, frames)
end

function PlayerRunState:update(dt)
    self.player:setQuad(self:getCurrentFrame())

    if App:keyPressed("space") then
        self.player:changeState("jump")
        return
    end

    local t1, t2 = self.level:getTilesFromHitPoints(self.level.tileMap, self.player, "bottom")

    if not self.level:isCollidable(t1) or not self.level:isCollidable(t2) then
        self.player:changeState("fall")
        return
    end

    if not self.player:isRunning() then
        self.player:changeState("idle")
        return
    end
end

function PlayerRunState:exit()
    self:removeTimer(self)
end
