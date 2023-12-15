PlayerIdleState = Class { __includes = BaseState }

function PlayerIdleState:init(player, quad)
    self.player = player
    self.player:setQuad(quad)
end

function PlayerIdleState:update(dt)
    if App:keyPressed("space") then
        self.player:changeState("jump")
        return
    end

    if self.player:isRunning() then
        self.player:changeState("run")
        return
    end
end
