MoveBundle = Class()

function MoveBundle:init()
    self.dx = 0
    self.running = false
end

function MoveBundle:moveX(dt, speed)
    self.x = self.x + speed * dt
end

function MoveBundle:applyPush(push)
    self.dy = self.dy + push
end

function MoveBundle:applyDx(dt)
    self.x = self.x + self.dx * dt
end

function MoveBundle:isRunning()
    return self.running
end

function MoveBundle:setRunning(bool)
    self.running = bool
end
