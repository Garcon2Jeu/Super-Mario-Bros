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

    self:drawHitboxToTiles()
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
function StartState:drawHitboxToTiles()
    self.player:drawPoints()

    local tile1, tile2 = self.level:getTilesFromHitPoints(self.level.tileMap, self.player, "bottom")

    if not tile1 or not tile2 then
        return
    end

    love.graphics.rectangle("line", tile1.x, tile1.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", tile2.x, tile2.y, TILESIZE, TILESIZE)
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
