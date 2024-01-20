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
