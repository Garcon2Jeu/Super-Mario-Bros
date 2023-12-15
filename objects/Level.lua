Level = Class { __includes = TileMap }

local tilesSheet = Assets.graphics["tiles"]()
local tilesQuads = Quads:getSetsOfQuads(tilesSheet, TILESIZE, TILESIZE, 6, 10)

local toppersSheet = Assets.graphics["tile_tops"]()
local toppersQuads = Quads:getSetsOfQuads(toppersSheet, TILESIZE, TILESIZE, 6, 18)

function Level:init()
    self.tileMap = TileMapGenerator.factory(20, MAP_HEIGHT)
end

function Level:draw()
    self:drawTileMap(
        tilesSheet, tilesQuads[21][3],
        toppersSheet, toppersQuads[3][1]
    )
end
