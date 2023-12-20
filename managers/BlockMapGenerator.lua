BlockMapGenerator = Class()


function BlockMapGenerator:factory(map)
    self.addBlock(map)

    return map
end

function BlockMapGenerator.addBlock(map)
    local tile = map[10][4]

    local block = JumpBlock {
        x = tile.x,
        y = tile.y,
    }

    map[10][4] = block
end
