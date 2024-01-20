MoveModule = Class()


MoveModule.fieldNames = {
    "dx",
    "running"
}


function MoveModule:init()
    self.dx = 0
    self.running = false
end

function MoveModule:setDX(dx)
    self.dx = dx
end

function MoveModule:moveX(dt, speed)
    self.x = self.x + speed * dt
end

function MoveModule:applyPush(push)
    self.dx = self.dx + push
end

function MoveModule:applyDX()
    self.x = self.x + self.dx
end

function MoveModule:isRunning()
    return self.running
end

function MoveModule:setRunning(bool)
    self.running = bool
end

function MoveModule:applyFriction(dt, friction)
    self.dx = self.dx + friction * dt
end

function MoveModule:isPushedLeft()
    return self.dx < 0
end

function MoveModule:isPushedRight()
    return self.dx > 0
end
