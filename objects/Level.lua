Level = Class { __includes = { TileMap, BlockMap } }

local tilesSheet = Assets.graphics["tiles"]()
local tilesQuads = Quads:getSetsOfQuads(tilesSheet, TILESIZE, TILESIZE, 6, 10)

local toppersSheet = Assets.graphics["tile_tops"]()
local toppersQuads = Quads:getSetsOfQuads(toppersSheet, TILESIZE, TILESIZE, 6, 18)

local blockSheet = Assets.graphics["jump_blocks"]()
local blockQuads = Quads:getSetsOfQuads(blockSheet, TILESIZE, TILESIZE)


function Level:init()
    self.tileMap = TileMapGenerator.factory(20, MAP_HEIGHT)
    self.blockMap = BlockMapGenerator:factory(self.tileMap, blockSheet, blockQuads[1])
end

function Level:draw()
    self:drawTileMap(
        tilesSheet, tilesQuads[21][3],
        toppersSheet, toppersQuads[3][1]
    )

    self:drawBlockMap()
end
