BlockMap = Class()

function BlockMap:init(baseMap)
    self.blockMap = BlockMapGenerator:factory(baseMap)
end

function BlockMap:drawBlockMap()
    self.blockMap[10][4]:draw()
end
