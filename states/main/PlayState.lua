PlayState = Class { __includes = BaseState }
PlayState:setStateName("start")

function PlayState:init()
    self.level = Level()
    self.player = Player(self.level)

    Modules:plug(self, "Camera")
end

function PlayState:update(dt)
    self.player.avatar:update(dt, self.level)
    self.level:update(dt, self.player.avatar, self.cameraScroll)
    self:updateCamera(self.player.avatar.x, self.level.tileMapWidth)
end

function PlayState:draw()
    self.level.background:draw()
    self.player:drawUI()
    self:scrollCamera()
    self.level:draw()
    self.player.avatar:draw()

    self:drawHitboxToTiles()
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

------------------------------------------------------DEBUG-------------------------------------------------------------------
