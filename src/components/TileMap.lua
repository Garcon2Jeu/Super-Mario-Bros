TileMap = Class()

function TileMap:init()
    self.tileMap = self:factory()
end

function TileMap:factory()
    local map = TileMapGenerator.generateEmpty()
    TileMapGenerator.addGround(map)

    return map
end

function TileMap:drawTileMap(tilesSheet, tileQuad, topperSheet, topperQuad)
    for key, column in pairs(self.tileMap) do
        for key, tile in pairs(column) do
            if tile.ground then
                love.graphics.draw(tilesSheet, tileQuad, tile.x, tile.y)
            end

            if tile.topper then
                love.graphics.draw(topperSheet, topperQuad, tile.x, tile.y)
            end
        end
    end
end

function TileMap:pointToTile(x, y)
    if x < 0 or y < 0 or x > VIRTUAL_WIDTH or y > VIRTUAL_HEIGHT then
        return
    end

    local column = math.floor(x / TILESIZE) + 1
    local row = math.floor(y / TILESIZE) + 1

    return self.tileMap[column][row]
end

function TileMap:hitboxPointsToTiles(object, edgeDirection)
    local x1, y1, x2, y2 = object:getHitboxOffset(edgeDirection)
    local p1, p2 = object:getHitboxEdge(edgeDirection, x1, y1, x2, y2)

    return self:pointToTile(p1.x, p1.y), self:pointToTile(p2.x, p2.y)
end
