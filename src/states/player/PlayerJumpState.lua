PlayerJumpState = Class { __includes = BaseState }

function PlayerJumpState:init(player, quad)
    self.player = player
    self.player.quad = quad
    self.player:applyJumpForce(JUMPFORCE)
end

function PlayerJumpState:update(dt)
    self.player:applyGravity(GRAVITY)
    self.player:applyDY(dt)

    if self.player:isFalling() then
        self.player:changeState("fall")
    end
end
