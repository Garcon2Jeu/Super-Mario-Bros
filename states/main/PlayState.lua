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
    -- self:drawHitboxToTiles()
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
function PlayState:drawHitboxToTiles()
    for key, ennemi in pairs(self.level.ennemis) do
        ennemi:drawPoints()

        local tl1, tl2 = ennemi:getTilesFromHitPoints(State.current.level.tileMap, "left")
        local tr1, tr2 = ennemi:getTilesFromHitPoints(State.current.level.tileMap, "right")

        if tl1 and tl2 and tr1 and tr2 then
            love.graphics.rectangle("line", tl1.x, tl1.y, TILESIZE, TILESIZE)
            love.graphics.rectangle("line", tr1.x, tr1.y, TILESIZE, TILESIZE)
        end
    end
end

function PlayState:drawViewPort()
    love.graphics.rectangle("line", self.viewPort.x, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
