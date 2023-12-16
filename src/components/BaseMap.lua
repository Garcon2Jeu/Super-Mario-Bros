BaseMap = Class()

function BaseMap:init(mapWidth, mapHeight)
    self.width = mapWidth * TILESIZE
    self.height = mapHeight * TILESIZE

    return self.generateEmptyMap(mapWidth, mapHeight)
end

function BaseMap.generateEmptyMap(mapWidth, mapHeight)
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

function BaseMap:drawTileMap(tilesSheet, tileQuad, topperSheet, topperQuad)
    for key, column in pairs(self.tileMap) do
        for key, tile in pairs(column) do
            if tile.collidable then
                love.graphics.draw(tilesSheet, tileQuad, tile.x, tile.y)
            end

            if tile.topper then
                love.graphics.draw(topperSheet, topperQuad, tile.x, tile.y)
            end
        end
    end
end

function BaseMap:drawBlockMap()
    self.blockMap[10][6]:draw()
end
