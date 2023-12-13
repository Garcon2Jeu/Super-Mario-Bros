PlayerRunState = Class { __includes = BaseState }

function PlayerRunState:init(player, quad)
    self.player = player
    self.player.quad = quad
end

function PlayerRunState:update(dt)
    if App:keyPressed("space") then
        self.player:changeState("jump")
    end

    if not self.player.isRunning then
        self.player:changeState("idle")
    end
end
