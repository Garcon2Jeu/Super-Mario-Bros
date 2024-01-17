PlayerRunState = Class { __includes = BaseState }
PlayerRunState:setStateName("run")

function PlayerRunState:init(avatar, level, interval, frames)
    self.avatar = avatar
    self.level = level

    Modules:plug(self, "Animation",
        { interval = interval, frames = frames })
end

function PlayerRunState:update(dt)
    self.avatar:setQuad(self:getCurrentFrame())

    if App:keyPressed("space") then
        self.avatar:changeState("jump")
        return
    end

    if not self.avatar:checkForGround() then
        self.avatar:changeState("fall")
    end

    if not self.avatar:isRunning() then
        self.avatar:changeState("idle")
        return
    end
end

function PlayerRunState:exit()
    self:removeTimer(self)
end
