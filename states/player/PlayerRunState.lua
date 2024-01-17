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

    self:checkForGround()

    if not self.avatar:isRunning() then
        self.avatar:changeState("idle")
        return
    end
end

function PlayerRunState:exit()
    self:removeTimer(self)
end

function PlayerRunState:checkForGround()
    local t1, t2 = self.avatar:getTilesFromHitPoints(
        self.level.tileMap, self.avatar, "bottom")
    local b1, b2 = self.avatar:getTilesFromHitPoints(
        self.level.blockMap, self.avatar, "bottom")

    for key, tile in pairs { t1, t2, b1, b2 } do
        if self.avatar:isTileCollidable(tile) then
            return
        end
    end

    self.avatar:changeState("fall")
end
