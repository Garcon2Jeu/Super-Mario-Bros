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
    self.level:draw()
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
function StartState:drawHitboxToTiles()
    self.player:drawPoints()

    local tile1, tile2 = self.level:hitboxPointsToTiles(self.player, "bottom")

    if not tile1 or not tile2 then
        return
    end

    love.graphics.rectangle("line", tile1.x, tile1.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", tile2.x, tile2.y, TILESIZE, TILESIZE)
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
