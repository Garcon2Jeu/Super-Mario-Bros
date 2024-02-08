PlayState = Class { __includes = BaseState }
PlayState:setStateName("start")

function PlayState:init()
    self.level = Level()
    self.avatar = Avatar(self.level)

    Modules:plug(self, "Camera")
end

function PlayState:update(dt)
    self.avatar:update(dt, self.level)
    self.level:update(dt, self.avatar, self.cameraScroll)
    self:updateCamera(self.avatar.x, self.level.tileMapWidth)

    if self.avatar:hasLost() then
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



    love.graphics.printf("test", self.cameraScroll, 50, VIRTUAL_WIDTH, "center")
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
function PlayState:drawHitboxToTiles()
    for key, ennemi in pairs(self.level.ennemis) do
        ennemi:drawPoints()

        local t1, t2 = ennemi:getTilesFromHitPoints(State.current.level.tileMap, "left")

        if t1 and t2 then
            love.graphics.rectangle("line", t1.x, t1.y, TILESIZE, TILESIZE)
            -- love.graphics.rectangle("line", t2.x, t2.y, TILESIZE, TILESIZE)
        end
    end
end

function PlayState:drawViewPort()
    love.graphics.rectangle("line", self.viewPort.x, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
