TileMapGenerator = Class()


local pillarData = {
    countSpacer   = -10,
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
    countSpacer = 3,
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

    self.addGround(tileMap)
    self:randomlyTerraform(tileMap, chasmData)
    self:randomlyTerraform(tileMap, pillarData)
    self:randomlyTerraform(tileMap, decorationData)
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

-- Description:
---- Randomly adds one type of geographical elements to a tileMap.
-- Requires:
---- tileMap = table of Tile objects, generated with getEmptyTileMap()
---- formationData = table of information needed to complete method:
------ countSpacer        = number variable, must be positive, defines number of tiles between generated elements
------ chance             = number variable, must be positive, defines chance of element being generated at current loop.
------                      Divide number by 100 (ex: 2 = 50% chance of being generated)
------ widthMin, widthMax = number variables, must be positive, defines minimum and maxium width of generated element
------ method             = function variable, method to execute to add element (ex: addChasm(), addPillar())
function TileMapGenerator:randomlyTerraform(tileMap, formationData)
    local formationCount = 1

    for columnIndex, v in ipairs(tileMap) do
        formationCount = formationCount - 1

        if formationCount <= -math.abs(formationData.countSpacer) then
            formationCount = App.flipCoin(formationData.chance)
                and math.random(formationData.widthMin, formationData.widthMax)
                or formationCount
        end

        if formationCount > 0 then
            formationData.method(tileMap, columnIndex)
        end
    end
end

function TileMapGenerator.addChasm(tileMap, columnIndex)
    for key, tile in pairs(tileMap[columnIndex]) do
        Modules:unplugInBulk(tile, { "Texture", "Collidable" })
    end
end

-- Description:
---- Adds a single pillar to provided tileMap at provided columnIndex.
---- Will add collidable module to every single empty tile until ground is reached,
---- starting at pillarHeightCustom if provided, or pillarHeightDefault.
-- Requires:
---- tileMap     = table of Tile objects, generated with getEmptyTileMap()
---- columnIndex = number
-- Optionnal:
---- pillarHeightCustom = number
function TileMapGenerator.addPillar(tileMap, columnIndex, pillarHeightCustom)
    for row = pillarHeightCustom or pillarData.heightDefault, MAP_HEIGHT do
        if not tileMap[columnIndex][row].collidable then
            tileMap[columnIndex][row]:addCollidable()
        end
    end
end

function TileMapGenerator.addDecoration(tileMap, columnIndex)
    for row = 1, MAP_HEIGHT do
        if row - 1 > 1 and tileMap[columnIndex][row].collidable then
            tileMap[columnIndex][row - 1]:addDecoration()
            return
        end
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
