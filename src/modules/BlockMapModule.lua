BlockMapModule = Class()

function BlockMapModule:init(def)
    self.blockMap = BlockMapGenerator:factory(def.baseMap)
end

function BlockMapModule:drawBlockMap()
    self.blockMap[10][4]:draw()
end
