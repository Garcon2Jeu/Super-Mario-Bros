StartState = Class { __includes = BaseState }
StartState:setStateName("start")

function StartState:init()
    self.level = Level()
    self.player = Player(self.level)

    Modules:plug(self, "Camera")
end

function StartState:update(dt)
    self.player.avatar:update(dt, self.level)
    self.level:update(dt, self.player.avatar, self.cameraScroll)
    self:updateCamera(self.player.avatar.x, self.level.tileMapWidth)
end

function StartState:draw()
    self.level.background:draw()
    self.player:drawUI()
    self:scrollCamera()
    self.level:draw()
    self.player.avatar:draw()

    love.graphics.print(tostring(self.level.tileMap[#self.level.tileMap][1].x), 50, 30)
    love.graphics.rectangle("fill", self.cameraScroll + VIRTUAL_WIDTH, VIRTUAL_HEIGHT / 2, 5, 5)

    for index, column in ipairs(self.level.tileMap) do
        love.graphics.print(tostring(index), column[1].x, column[1].y)
    end
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
function StartState:drawHitboxToTiles()
    self.player.avatar:drawPoints()

    -- local t1, t2 = self.player.avatar:getTilesFromHitPoints(self.level.tileMap, self.player.avatar, "right")
    -- local t3, t4 = self.player.avatar:getTilesFromHitPoints(self.level.tileMap, self.player.avatar, "left")
    -- local t5, t6 = self.player.avatar:getTilesFromHitPoints(self.level.tileMap, self.player.avatar, "bottom")
    -- local t7, t8 = self.player.avatar:getTilesFromHitPoints(self.level.tileMap, self.player.avatar, "top")

    local b1, b2 = self.player.avatar:getTilesFromHitPoints(self.level.blockMap, self.player.avatar, "bottom")


    -- if not t1 and not t2
    --     or not t3 and not t4
    --     or not t5 and not t6
    --     or not t7 and not t8
    if not b1 and not b2 then
        return
    end

    -- love.graphics.rectangle("line", t1.x, t1.y, TILESIZE, TILESIZE)
    -- love.graphics.rectangle("line", t2.x, t2.y, TILESIZE, TILESIZE)
    -- love.graphics.rectangle("line", t3.x, t3.y, TILESIZE, TILESIZE)
    -- love.graphics.rectangle("line", t4.x, t4.y, TILESIZE, TILESIZE)
    -- love.graphics.rectangle("line", t5.x, t5.y, TILESIZE, TILESIZE)
    -- love.graphics.rectangle("line", t6.x, t6.y, TILESIZE, TILESIZE)
    -- love.graphics.rectangle("line", t7.x, t7.y, TILESIZE, TILESIZE)
    -- love.graphics.rectangle("line", t8.x, t8.y, TILESIZE, TILESIZE)

    love.graphics.rectangle("line", b1.x, b1.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", b2.x, b2.y, TILESIZE, TILESIZE)
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
