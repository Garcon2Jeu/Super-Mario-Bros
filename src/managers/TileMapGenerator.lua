TileMapGenerator = Class()

function TileMapGenerator.generateEmpty()
    local tileMap = {}

    for column = 1, 20 do
        local tileColumn = {}
        local x = (column - 1) * TILESIZE
        for row = 1, 10 do
            table.insert(tileColumn, {
                x = x,
                y = (row - 1) * TILESIZE,
            })
        end

        table.insert(tileMap, tileColumn)
    end

    return tileMap
end

function TileMapGenerator.addGround(tileMap)
    for key, column in pairs(tileMap) do
        for index, tile in ipairs(column) do
            if index == 7 then
                tile.topper = true
            end

            if index >= 7 then
                tile.ground = true
            end
        end
    end
end
