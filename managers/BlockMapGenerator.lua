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
        column = 10,
        row = 4
    }

    map[10][4] = block

    tile = map[5][4]

    block = JumpBlock {
        x = tile.x,
        y = tile.y,
        column = 5,
        row = 4
    }

    map[5][4] = block
end
