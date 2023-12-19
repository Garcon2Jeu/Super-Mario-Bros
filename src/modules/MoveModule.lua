MoveModule = Class()

function MoveModule:init()
    self.dx = 0
    self.running = false
end

function MoveModule:moveX(dt, speed)
    self.x = self.x + speed * dt
end

function MoveModule:applyPush(push)
    self.dy = self.dy + push
end

function MoveModule:applyDx(dt)
    self.x = self.x + self.dx * dt
end

function MoveModule:isRunning()
    return self.running
end

function MoveModule:setRunning(bool)
    self.running = bool
end
