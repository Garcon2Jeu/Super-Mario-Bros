MoveBundle = Class()

function MoveBundle:init()
    self.dx = 0
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
