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
