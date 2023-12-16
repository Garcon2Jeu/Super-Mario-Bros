TileMapGenerator = Class()


local pillarHeightMax = 4


function TileMapGenerator.factory(map, mapWidth, mapHeight)
    TileMapGenerator.addGround(map)
    -- TileMapGenerator.addPillars(map)
    TileMapGenerator.addToppers(map)

    return map
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
        for key, tile in pairs(column) do
            if tile.ground then
                tile.topper = true
                goto continue
            end
        end
        ::continue::
    end
end
