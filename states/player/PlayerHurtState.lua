PlayerHurtState = Class { __includes = BaseState }
PlayerHurtState:setStateName("hurt")

local pushBack = 4
local friction = 30

function PlayerHurtState:init(avatar)
    App:enableInput(false)
    State.current.player:removeHeart()
    self.avatar = avatar
end

function PlayerHurtState:enter(blob)
    self.rightSideCollision = self.avatar.x < blob.x
    self.friction = self.rightSideCollision and friction or -friction

    self.avatar.x = self.rightSideCollision
        and blob.x - self.avatar.width - 1
        or blob.x + blob.width + 1

    self.avatar:setDX(self.rightSideCollision and -pushBack or pushBack)
end

function PlayerHurtState:update(dt)
    self.avatar:applyDX(dt)
    self.avatar:applyFriction(dt, self.friction)

    if self.rightSideCollision and self.avatar:isPushedRight()
        or not self.rightSideCollision and self.avatar:isPushedLeft() then
        self.avatar.dx = 0
        Timer.after(.2, function() self.avatar:changeState("idle") end)
    end
end

function PlayerHurtState:exit()
    App:enableInput(true)
end
