TileMapGenerator = Class()


local noPillarCountSpacer = -10
local pillarChance        = 7
local pillarHeightDefault = 4
local pillarWidthMin      = 3
local pillarWidthMax      = 7


local noChasmCountSpacer = 10
local chasmChance        = 7
local chasmWidthMin      = 2
local chasmWidthMax      = 2


function TileMapGenerator:factory(baseMap)
    local tileMap = self.getEmptyTileMap(baseMap)

    self.addGround(tileMap)

    self:randomlyTerraform(tileMap, {
        countSpacer = noChasmCountSpacer,
        chance      = chasmChance,
        widthMin    = chasmWidthMin,
        widthMax    = chasmWidthMax,
        method      = function(tileMap, columnIndex) self.addChasm(tileMap, columnIndex) end
    })

    self:randomlyTerraform(tileMap, {
        countSpacer = noPillarCountSpacer,
        chance      = pillarChance,
        widthMin    = pillarWidthMin,
        widthMax    = pillarWidthMax,
        method      = function(tileMap, columnIndex) self.addPillar(tileMap, columnIndex) end
    })

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
---- Randomly adds one type of geographical elements to a tileMap
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
        tile.collidable = nil
        tile.onCollide = nil
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
    for row = pillarHeightCustom or pillarHeightDefault, MAP_HEIGHT do
        if not tileMap[columnIndex][row].collidable then
            tileMap[columnIndex][row]:addCollidable()
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
