TileMapGenerator = Class()

local pillarHeightMax = 4


function TileMapGenerator.factory(mapWidth, mapHeight)
    local map = TileMapGenerator.generateEmpty(mapWidth, mapHeight)
    TileMapGenerator.addGround(map)
    TileMapGenerator.addPillars(map)
    TileMapGenerator.addToppers(map)

    return map
end

function TileMapGenerator.generateEmpty(mapWidth, mapHeight)
    local tileMap = {}

    for column = 1, mapWidth do
        local tileColumn = {}
        local x = (column - 1) * TILESIZE
        for row = 1, mapHeight do
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
            if index >= GROUND_ROW then
                tile.ground = true
            end
        end
    end
end

-- NOT FINISHED --
function TileMapGenerator.addPillars(tileMap)
    for row = pillarHeightMax, GROUND_ROW - 1 do
        tileMap[15][row].ground = true
    end
end

-- NOT FINISHED --

function TileMapGenerator.addToppers(tileMap)
    for key, column in pairs(tileMap) do
        for index, tile in ipairs(column) do
            if tile.ground then
                tile.topper = true
                goto continue
            end
        end
        ::continue::
    end
end
