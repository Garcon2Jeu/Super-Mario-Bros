StartState = Class { __includes = {
    BaseState,
    Camera
} }

function StartState:init()
    self.player = PlayerCharacter()
    self.level = Level()

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
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
function StartState:drawHitboxToTiles()
    self.player:drawPoints()

    local tile1, tile2 = self.level:hitboxPointsToTiles(self.player, "right")
    local tile3, tile4 = self.level:hitboxPointsToTiles(self.player, "left")

    if not tile1 or not tile2 or tile3 or not tile4 then
        return
    end

    love.graphics.rectangle("line", tile1.x, tile1.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", tile2.x, tile2.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", tile3.x, tile3.y, TILESIZE, TILESIZE)
    love.graphics.rectangle("line", tile4.x, tile4.y, TILESIZE, TILESIZE)
end

------------------------------------------------------DEBUG-------------------------------------------------------------------
