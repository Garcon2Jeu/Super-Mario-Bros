StartState = Class { __includes = BaseState }

function StartState:init()
    self.player = PlayerCharacter()
    self.level = Level()
end

function StartState:update(dt)
    self.player:update(dt)
end

function StartState:draw()
    self.player:draw()
    self.player.hitbox:drawPoints()
    self.level:draw()



    ------------------------------------------------------DEBUG-------------------------------------------------------------------


    local tile1, tile2 = self.level:hitboxPointsToTiles(self.player.hitbox:getEdgePoints("bottom"))
    love.graphics.rectangle("line", tile1.x, tile1.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", tile2.x, tile2.y, TILESIZE, TILESIZE)

    ------------------------------------------------------DEBUG-------------------------------------------------------------------
end
