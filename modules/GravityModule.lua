GravityModule = Class()

local gravity_force = GRAVITY

function GravityModule:init()
    self.dy = 0
end

function GravityModule:moveY(dt, speed)
    self.y = self.y + speed * dt
end

function GravityModule:applyGravity(gravity)
    self.dy = self.dy + gravity
end

function GravityModule:applyDY(dt)
    self.y = self.y + self.dy * dt
end

function GravityModule:applyJumpForce(jumpforce)
    self.dy = jumpforce
end

function GravityModule:isFalling()
    return self.dy > 0
end

function GravityModule:stopDY()
    self.dy = 0
end

function GravityModule:blockY(y)
    self:setY(y)
    self:stopDY()
end
