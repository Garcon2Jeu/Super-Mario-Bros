BlockMapGenerator = Class()


function BlockMapGenerator:factory(map, blockSheet, blockQuad)
    self.addBlock(map, blockSheet, blockQuad)

    return map
end

function BlockMapGenerator.addBlock(map, blockSheet, blockQuad)
    local tile = map[10][6]

    local block = GameObject {
        x       = tile.x,
        y       = tile.y,
        width   = TILESIZE,
        height  = TILESIZE,
        texture = blockSheet,
        quad    = blockQuad
    }

    map[10][6] = block
end
