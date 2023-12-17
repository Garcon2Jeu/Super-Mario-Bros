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
            table.insert(tileColumn, Tile {
                x = x,
                y = (row - 1) * TILESIZE,
            })
        end

        table.insert(map, tileColumn)
    end

    return map
end
