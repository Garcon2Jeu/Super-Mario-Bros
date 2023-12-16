BlockMapGenerator = Class()


function BlockMapGenerator:factory(map, blockSheet, blockQuad)
    self.addBlock(map, blockSheet, blockQuad)

    return map
end

function BlockMapGenerator.addBlock(map, blockSheet, blockQuad)
    local tile = map[10][4]

    local block = Block {
        x       = tile.x,
        y       = tile.y,
        width   = TILESIZE,
        height  = TILESIZE,
        texture = blockSheet,
        quad    = blockQuad
    }

    map[10][4] = block
end
