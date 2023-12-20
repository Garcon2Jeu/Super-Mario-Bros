BlockMapModule = Class()

function BlockMapModule:init(baseMap)
    self.blockMap = BlockMapGenerator:factory(baseMap)
end

function BlockMapModule:drawBlockMap()
    self.blockMap[10][4]:draw()
end
