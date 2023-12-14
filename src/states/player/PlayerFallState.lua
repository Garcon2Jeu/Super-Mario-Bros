PlayerFallState = Class { __includes = BaseState }

function PlayerFallState:init(player, quad)
    self.player = player
    self.player:setQuad(quad)
end

function PlayerFallState:update(dt)
    self.player:applyGravity(GRAVITY)
    self.player:applyDY(dt)

    if not self.player:isFalling()
        or not self.player:isGrounded() then
        return
    end

    if self.player:isRunning() then
        self.player:changeState("run")
    else
        self.player:changeState("idle")
    end
end
