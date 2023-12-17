TileMapGenerator = Class()


local pillarHeightMax = 4


function TileMapGenerator:factory(baseMap)
    local tileMap = self.getEmptyTileMap(baseMap)

    self.addGround(tileMap)
    self.addPillars(tileMap)
    self.addToppers(tileMap)

    return tileMap
end

function TileMapGenerator.getEmptyTileMap(baseMap)
    local tileMap = {}

    for columnIndex, baseColumn in ipairs(baseMap) do
        tileMap[columnIndex] = {}
        for key, baseTile in pairs(baseColumn) do
            table.insert(tileMap[columnIndex],
                Tile { x = baseTile.x, y = baseTile.y }
            )
        end
    end

    return tileMap
end

function TileMapGenerator.addGround(tileMap)
    for key, column in pairs(tileMap) do
        for index, tile in ipairs(column) do
            if index >= GROUND_ROW then
                tile:addCollidable()
            end
        end
    end
end

-- NOT FINISHED --
function TileMapGenerator.addPillars(tileMap)
    for row = pillarHeightMax, GROUND_ROW - 1 do
        tileMap[15][row]:addCollidable()
        tileMap[14][row]:addCollidable()
        tileMap[13][row]:addCollidable()
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
