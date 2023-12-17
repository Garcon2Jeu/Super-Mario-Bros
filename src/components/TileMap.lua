TileMap = Class()

local tilesSheet = Assets.graphics["tiles"]()
local tilesQuads = Quads:getSetsOfQuads(tilesSheet, TILESIZE, TILESIZE, 6, 10)

local toppersSheet = Assets.graphics["tile_tops"]()
local toppersQuads = Quads:getSetsOfQuads(toppersSheet, TILESIZE, TILESIZE, 6, 18)

function TileMap:drawTileMap()
    for key, column in pairs(self.tileMap) do
        for key, tile in pairs(column) do
            if tile.collidable then
                love.graphics.draw(tilesSheet, tilesQuads[21][3], tile.x, tile.y)
            end

            if tile.topper then
                love.graphics.draw(toppersSheet, toppersQuads[3][1], tile.x, tile.y)
            end
        end
    end
end
