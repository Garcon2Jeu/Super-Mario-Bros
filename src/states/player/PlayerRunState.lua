PlayerRunState = Class { __includes = {
    BaseState,
    Animation,
} }

function PlayerRunState:init(player, interval, frames)
    self.player = player
    Animation.init(self, interval, frames)
end

function PlayerRunState:update(dt)
    self.player.quad = self:getCurrentFrame()

    if App:keyPressed("space") then
        self.player:changeState("jump")
    end

    if not self.player.isRunning then
        self.player:changeState("idle")
    end
end

function PlayerRunState:exit()
    self:removeTimer(self)
end
