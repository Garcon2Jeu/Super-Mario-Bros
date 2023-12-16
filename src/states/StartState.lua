StartState = Class { __includes = {
    BaseState,
    Camera
} }

function StartState:init()
    self.level = Level()
    self.player = PlayerCharacter(self.level)

    Camera.init(self)
end

function StartState:update(dt)
    self.player:update(dt)
    self:updateCamera(self.player.x)
end

function StartState:draw()
    self:scrollCamera()
    self.player:draw()
    self.level:draw()

    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    love.graphics.print(tostring(self.player.stateMachine.debug), 50, 50)
    ------------------------------------------------------DEBUG-------------------------------------------------------------------

    -- self:drawHitboxToTiles()
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
function StartState:drawHitboxToTiles()
    self.player:drawPoints()

    local t1, t2 = self.level:getTilesFromHitPoints(self.level.tileMap, self.player, "bottom")

    if not t1 and not t2 or not t1.collidable and not t2.collidable then
        return
    end

    love.graphics.rectangle("line", t1.x, t1.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", t2.x, t2.y, TILESIZE, TILESIZE)
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
