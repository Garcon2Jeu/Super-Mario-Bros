GravityBundle = Class()

local gravity_force = GRAVITY

function GravityBundle:init()
    self.dy = 0
end

function GravityBundle:moveY(dt, speed)
    self.y = self.y + speed * dt
end

function GravityBundle:applyGravity(gravity)
    self.dy = self.dy + gravity
end

function GravityBundle:applyDY(dt)
    self.y = self.y + self.dy * dt
end

function GravityBundle:applyJumpForce(jumpforce)
    self.dy = jumpforce
end
