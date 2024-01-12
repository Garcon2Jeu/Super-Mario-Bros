PlayerIdleState = Class { __includes = BaseState }
PlayerIdleState:setStateName("idle")

function PlayerIdleState:init(avatar, quad)
    self.avatar = avatar
    self.avatar:setQuad(quad)
end

function PlayerIdleState:update(dt)
    if App:keyPressed("space") then
        self.avatar:changeState("jump")
        return
    end

    if self.avatar:isRunning() then
        self.avatar:changeState("run")
        return
    end
end
