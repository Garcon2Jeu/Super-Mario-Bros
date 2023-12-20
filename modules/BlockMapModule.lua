BlockMapModule = Class()

function BlockMapModule:init(baseMap)
    self.blockMap = BlockMapGenerator:factory(baseMap)
    self.blockList = {}
    self:updateBlockList()
end

function BlockMapModule:updateBlockList()
    for columnIndex, column in ipairs(self.blockMap) do
        for rowIndex, block in ipairs(column) do
            if block.modules then
                table.insert(self.blockList,
                    { column = columnIndex, row = rowIndex }
                )
            end
        end
    end
end

function BlockMapModule:drawBlockMap()
    for key, position in pairs(self.blockList) do
        self.blockMap[position.column][position.row]:draw()
    end
end
