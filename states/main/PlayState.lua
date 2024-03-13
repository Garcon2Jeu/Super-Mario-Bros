PlayState = Class { __includes = BaseState }
PlayState:setStateName("start")

function PlayState:init()
    Modules:plug(self, "Camera")
end

function PlayState:enter(def)
    self.level = Level(def)
    self.avatar = Avatar(self.level)
end

function PlayState:update(dt)
    self.avatar:update(dt, self.level)
    self.level:update(dt, self.avatar, self.cameraScroll)
    self:updateCamera(self.avatar.x, self.level.tileMapWidth)

    if self.avatar:hasLost() then
        Assets.audio["death"]:play()
        State:change("over", {
            level = self.level,
            cameraScroll = self.cameraScroll
        })
        return
    end
end

function PlayState:draw()
    self.level.background:draw()
    self.avatar:drawUI()
    self:scrollCamera()
    self.level:draw()
    self.avatar:draw()
end
