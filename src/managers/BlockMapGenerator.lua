BlockMapGenerator = Class()

function BlockMapGenerator:factory(tileMap, blockSheet, blockQuad)
    local blockMap = self.emptyTileMap(tileMap)
    self.addBlock(tileMap, blockMap, blockSheet, blockQuad)

    return blockMap
end

function BlockMapGenerator.emptyTileMap(tileMap)
    local blockMap = tileMap

    for key, column in pairs(blockMap) do
        for key, block in pairs(column) do
            block = {}
        end
    end

    return blockMap
end

function BlockMapGenerator.addBlock(tileMap, blockMap, blockSheet, blockQuad)
    local tile = tileMap[10][4]

    local block = Block {
        x       = tile.x,
        y       = tile.y,
        width   = TILESIZE,
        height  = TILESIZE,
        texture = blockSheet,
        quad    = blockQuad
    }

    blockMap[10][4] = block
end
