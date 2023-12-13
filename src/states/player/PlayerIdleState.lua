PlayerIdleState = Class { __includes = BaseState }

function PlayerIdleState:init(player, quad)
    self.player = player
    self.player.quad = quad
end

function PlayerIdleState:update(dt)
    if App:keyPressed("space") then
        self.player:changeState("jump")
    end

    if self.player.isRunning then
        self.player:changeState("run")
    end

    -- self.player:applyGravity(GRAVITY)
    -- self.player:applyDY(dt)
    -- self.player:stand()
end
