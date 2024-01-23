BaseMapModule = Class()


BaseMapModule.fieldNames = {
    "columns",
    "rows",
    "width",
    "height"
}


function BaseMapModule:init(def)
    self.columns = def.columns
    self.rows    = def.rows
    self.width   = def.columns * TILESIZE
    self.height  = def.rows * TILESIZE
end

function BaseMapModule:generateEmptyMap(columns, rows)
    local map = {}

    for column = 1, columns or self.columns do
        local tileColumn = {}
        local x = (column - 1) * TILESIZE

        for row = 1, rows or self.rows do
            table.insert(tileColumn, {
                x = x,
                y = (row - 1) * TILESIZE,
            })
        end

        table.insert(map, tileColumn)
    end

    return map
end

function BaseMapModule.drawBaseMap(map)
    Assets.colors.setYellow(.5)

    for key, column in pairs(map) do
        for key, tile in pairs(column) do
            love.graphics.rectangle("line", tile.x, tile.y, TILESIZE, TILESIZE)
        end
    end

    Assets.colors.reset()
end

-- Description:
---- Randomly adds one type of geographical elements to a tileMap, column by column.
---- Applies one provided method to a single column each time formationCount is above 0
-- Requires:
---- map = table of Tile objects, generated with getEmptyTileMap()
---- formationData = table of information needed to complete method:
------ countSpacer        = number variable, must be positive, defines number of tiles between generated elements
------ chance             = number variable, must be positive, defines chance of element being generated at current loop.
------                      Divide number by 100 (ex: 2 = 50% chance of being generated)
------ widthMin, widthMax = number variables, must be positive, defines minimum and maxium width of generated element
------ method             = function variable, method to execute to add element (ex: addChasm(), addPillar())
function BaseMapModule.randomlyTerraform(map, formationData)
    local formationCount = 1

    for columnIndex, v in ipairs(map) do
        formationCount = formationCount - 1

        if formationCount <= -formationData.countSpacer then
            formationCount = App.flipCoin(formationData.chance)
                and math.random(formationData.widthMin, formationData.widthMax)
                or formationCount
        end

        if formationCount > 0 then
            formationData.method(map, columnIndex)
        end
    end
end
