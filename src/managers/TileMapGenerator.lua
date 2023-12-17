TileMapGenerator = Class()


local pillarHeightMax = 4


function TileMapGenerator.factory(map)
    TileMapGenerator.addGround(map)
    TileMapGenerator.addPillars(map)
    TileMapGenerator.addToppers(map)

    return map
end

function TileMapGenerator.addGround(tileMap)
    for key, column in pairs(tileMap) do
        for index, tile in ipairs(column) do
            if index >= GROUND_ROW then
                Collidable.init(tile)
            end
        end
    end
end

-- NOT FINISHED --
function TileMapGenerator.addPillars(tileMap)
    for row = pillarHeightMax, GROUND_ROW - 1 do
        Collidable.init(tileMap[15][row])
        Collidable.init(tileMap[14][row])
        Collidable.init(tileMap[13][row])
    end
end

-- NOT FINISHED --

function TileMapGenerator.addToppers(tileMap)
    for key, column in pairs(tileMap) do
        for key, tile in pairs(column) do
            if tile.collidable then
                tile.topper = true
                goto continue
            end
        end
        ::continue::
    end
end
