BlockMap = Class()

-- local blockSheet = Assets.graphics["jump_blocks"]()
-- local blockQuads = Quads:getSetsOfQuads(blockSheet, TILESIZE, TILESIZE)

function BlockMap:drawBlockMap()
    self.blockMap[10][4]:draw()
end
