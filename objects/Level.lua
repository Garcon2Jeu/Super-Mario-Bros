Level = Class { __includes = { TileMap, BlockMap } }

local tilesSheet = Assets.graphics["tiles"]()
local tilesQuads = Quads:getSetsOfQuads(tilesSheet, TILESIZE, TILESIZE, 6, 10)

local toppersSheet = Assets.graphics["tile_tops"]()
local toppersQuads = Quads:getSetsOfQuads(toppersSheet, TILESIZE, TILESIZE, 6, 18)

local blockSheet = Assets.graphics["jump_blocks"]()
local blockQuads = Quads:getSetsOfQuads(blockSheet, TILESIZE, TILESIZE)


function Level:init()
    local baseMap = self.generateEmptyMap(20, MAP_HEIGHT)

    self.tileMap = TileMapGenerator.factory(App:deepCopy(baseMap))
    self.blockMap = BlockMapGenerator:factory(App:deepCopy(baseMap), blockSheet, blockQuads[1])
end

function Level:draw()
    self:drawTileMap(
        tilesSheet, tilesQuads[21][3],
        toppersSheet, toppersQuads[3][1]
    )

    self:drawBlockMap()
end

function Level.generateEmptyMap(mapWidth, mapHeight)
    local map = {}

    for column = 1, mapWidth do
        local tileColumn = {}
        local x = (column - 1) * TILESIZE
        for row = 1, mapHeight do
            table.insert(tileColumn, {
                x = x,
                y = (row - 1) * TILESIZE,
            })
        end

        table.insert(map, tileColumn)
    end

    return map
end

function Level:pointToTile(map, x, y)
    if x < 0 or y < 0 or x > VIRTUAL_WIDTH or y > VIRTUAL_HEIGHT then
        return nil
    end

    local column = math.floor(x / TILESIZE) + 1
    local row = math.floor(y / TILESIZE) + 1

    return map[column][row]
end

function Level:getTilesFromHitPoints(map, object, edgeDirection)
    local x1, y1, x2, y2 = object:getHitboxOffset(edgeDirection)
    local p1, p2 = object:getHitboxEdge(edgeDirection, x1, y1, x2, y2)

    return self:pointToTile(map, p1.x, p1.y), self:pointToTile(map, p2.x, p2.y)
end
