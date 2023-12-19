StartState = Class { __includes = {
    BaseState,
    Camera
} }

function StartState:init()
    self.level = Level()
    -- self.player = PlayerCharacter(self.level)

    -- Camera.init(self)

    self.test = Test()
end

function StartState:update(dt)
    -- self.player:update(dt)
    -- self:updateCamera(self.player.x)
end

function StartState:draw()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    love.graphics.print(tostring(self.test.init), 10, 10)

    self.test:draw()
    -- love.graphics.print(tostring(self.level.tileMap[1][1]:draw()), 10, 10)
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    -- self:scrollCamera()
    self.level:draw()
    -- self.player:draw()

    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    -- self:drawHitboxToTiles()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
function StartState:drawHitboxToTiles()
    self.player:drawPoints()

    local t1, t2 = self.level:getTilesFromHitPoints(self.level.tileMap, self.player, "right")
    local t3, t4 = self.level:getTilesFromHitPoints(self.level.tileMap, self.player, "left")
    local t5, t6 = self.level:getTilesFromHitPoints(self.level.tileMap, self.player, "bottom")
    local t7, t8 = self.level:getTilesFromHitPoints(self.level.tileMap, self.player, "top")

    if not t1 and not t2
        or not t3 and not t4
        or not t5 and not t6
        or not t7 and not t8 then
        return
    end

    love.graphics.rectangle("line", t1.x, t1.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", t2.x, t2.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", t3.x, t3.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", t4.x, t4.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", t5.x, t5.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", t6.x, t6.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", t7.x, t7.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", t8.x, t8.y, TILESIZE, TILESIZE)
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
