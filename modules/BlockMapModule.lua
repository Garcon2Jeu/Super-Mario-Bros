BlockMapModule = Class()


BlockMapModule.fieldNames = {
    "blockMap",
    "blockIndices"
}


function BlockMapModule:init(baseMap)
    self.blockMap = BlockMapGenerator:factory(baseMap)
    self.blockIndices = {}
    self:updateBlockList()
end

function BlockMapModule:updateBlockList()
    self.blockIndices = {}

    for columnIndex, column in ipairs(self.blockMap) do
        for rowIndex, block in ipairs(column) do
            if block.modules then
                table.insert(self.blockIndices,
                    { column = columnIndex, row = rowIndex }
                )
            end
        end
    end
end

function BlockMapModule:drawBlockMap()
    for key, index in pairs(self.blockIndices) do
        self.blockMap[index.column][index.row]:draw()
    end
end

function BlockMapModule:addLockAndKey()
    local lockIndices = {
        column = self.blockIndices[1].column,
        row = self.blockIndices[1].row
    }

    local keyIndices = {
        column = self.blockIndices[#self.blockIndices].column,
        row = self.blockIndices[#self.blockIndices].row
    }

    self.blockMap[lockIndices.column][lockIndices.row]:makeLock()
    self.blockMap[keyIndices.column][keyIndices.row]:giveKey()
end
