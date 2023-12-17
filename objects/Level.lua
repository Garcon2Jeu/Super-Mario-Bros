Level = Class { __includes = {
    BaseMap,
    TileMap,
    BlockMap
} }

local tilesSheet = Assets.graphics["tiles"]()
local tilesQuads = Quads:getSetsOfQuads(tilesSheet, TILESIZE, TILESIZE, 6, 10)

local toppersSheet = Assets.graphics["tile_tops"]()
local toppersQuads = Quads:getSetsOfQuads(toppersSheet, TILESIZE, TILESIZE, 6, 18)


function Level:init()
    local baseMap = BaseMap.init(self, 20, MAP_HEIGHT)

    self.tileMap = TileMapGenerator.factory(App:deepCopy(baseMap))
    self.blockMap = BlockMapGenerator:factory(App:deepCopy(baseMap))
end

function Level:draw()
    self:drawTileMap(
        tilesSheet, tilesQuads[21][3],
        toppersSheet, toppersQuads[3][1]
    )

    self:drawBlockMap()
end

function Level:pointToTile(map, x, y)
    if x < 0 or y < 0 or x > self.width or y > self.height then
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

function Level:isCollidable(tile)
    if not tile then
        return false
    end

    return tile.collidable
end

-- Debug --

function Level.drawBaseMap(map)
    Assets.colors.setYellow(.5)

    for key, column in pairs(map) do
        for key, tile in pairs(column) do
            love.graphics.rectangle("line", tile.x, tile.y, TILESIZE, TILESIZE)
        end
    end

    Assets.colors.reset()
end
