TileMapGenerator = Class()


local levelEnd = 5


local pillarData = {
    countSpacer   = 10,
    chance        = 7,
    heightDefault = 4,
    widthMin      = 3,
    widthMax      = 7,
    heightMin     = 6,
    heightMax     = 4,
}

pillarData.method =
    function(tileMap, columnIndex)
        TileMapGenerator.addPillar(
            tileMap,
            columnIndex,
            math.random(pillarData.heightMax, pillarData.heightMin)
        )
    end


local chasmData = {
    countSpacer = 10,
    chance      = 7,
    widthMin    = 2,
    widthMax    = 2,
    method      =
        function(tileMap, columnIndex)
            TileMapGenerator.addChasm(tileMap, columnIndex)
        end
}


local decorationData = {
    countSpacer = 1,
    chance      = 2,
    widthMin    = 1,
    widthMax    = 2,
    method      =
        function(tileMap, columnIndex)
            TileMapGenerator.addDecoration(tileMap, columnIndex)
        end
}


function TileMapGenerator:factory(baseMap)
    local tileMap = self.getEmptyTileMap(baseMap)

    self.levelGroundFill(tileMap)

    BaseMapModule.randomlyTerraform(tileMap, chasmData)
    BaseMapModule.randomlyTerraform(tileMap, pillarData)
    BaseMapModule.randomlyTerraform(tileMap, decorationData)

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

function TileMapGenerator.levelGroundFill(tileMap)
    for key, column in pairs(tileMap) do
        TileMapGenerator.addGroundColumn(column)
    end
end

function TileMapGenerator.addGroundColumn(column)
    for index, tile in ipairs(column) do
        if index >= GROUND_ROW then
            tile:addCollidable()
        end
    end
end

function TileMapGenerator.addChasm(tileMap, columnIndex)
    for key, tile in pairs(tileMap[columnIndex]) do
        Modules:unplugInBulk(tile, { "Texture", "Collidable" })
        tile.ground = nil
    end
end

-- Description:
---- Adds a single pillar to provided tileMap at provided columnIndex.
---- Will add collidable module to every single empty tile until ground is reached,
---- starting at pillarHeightCustom if provided, or pillarHeightDefault.
-- Requires:
---- tileMap     = table of Tile objects, generated with getEmptyTileMap()
---- columnIndex = number variable
-- Optionnal:
---- pillarHeightCustom = number
function TileMapGenerator.addPillar(tileMap, columnIndex, pillarHeightCustom)
    for row = pillarHeightCustom or pillarData.heightDefault, MAP_HEIGHT do
        if not tileMap[columnIndex][row].collidable then
            tileMap[columnIndex][row]:addCollidable()
        end
    end
end

-- Description:
---- Adds Texture Module with Decoration Quad at tile above ground tile at given columnIndex
---- Because one decoration is split into 2 sprites,
---- function adapts current decoration to surrounding tiles
-- Requires:
---- tileMap = table of Tile objects, generated with getEmptyTileMap()
---- columnIndex = number variable
function TileMapGenerator.addDecoration(tileMap, columnIndex)
    if columnIndex == 1 or columnIndex + 1 > #tileMap then
        return
    end

    for row = 2, MAP_HEIGHT do
        if not Modules:find(tileMap[columnIndex][row], "Collidable") then
            goto continue
        end

        local decoQuadIndex = math.random(#Tile.getDecorationQuads())

        if decoQuadIndex == 3 then
            if Modules:find(tileMap[columnIndex + 1][row], "Collidable")
                and not Modules:find(tileMap[columnIndex + 1][row - 1], "Texture") then
                tileMap[columnIndex + 1][row - 1]:addDecoration(decoQuadIndex + 1)
            else
                decoQuadIndex = decoQuadIndex - 1
            end
        elseif decoQuadIndex == 4 then
            if Modules:find(tileMap[columnIndex - 1][row], "Collidable")
                and not Modules:find(tileMap[columnIndex - 1][row - 1], "Texture") then
                tileMap[columnIndex - 1][row - 1]:addDecoration(decoQuadIndex - 1)
            else
                decoQuadIndex = decoQuadIndex + 1
            end
        end

        if not Modules:find(tileMap[columnIndex][row - 1], "Texture") then
            tileMap[columnIndex][row - 1]:addDecoration(decoQuadIndex)
            return
        end

        ::continue::
    end
end

-- Description:
---- Adds topper to all first ground tiles of tileMap, pillars included
-- Requires:
---- tileMap = table of Tile objects, generated with getEmptyTileMap()
function TileMapGenerator.addToppers(tileMap)
    for key, column in pairs(tileMap) do
        for key, tile in pairs(column) do
            if tile.collidable then
                tile:addTopper { x = tile.x, y = tile.y }
                goto continue
            end
        end
        ::continue::
    end
end

function TileMapGenerator:resetColumns(map, startColumn, endColumn)
    for columnIndex = startColumn or 1, endColumn or #map, 1 do
        self:resetTiles(map[columnIndex])
    end
end

function TileMapGenerator:resetTiles(column)
    for rowIndex = 1, #column or self.rows do
        column[rowIndex] = Tile {
            x = column[rowIndex].x,
            y = column[rowIndex].y
        }
    end
end
