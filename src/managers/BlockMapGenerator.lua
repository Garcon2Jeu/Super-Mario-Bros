BlockMapGenerator = Class()

local blockSheet = Assets.graphics["jump_blocks"]()
local blockQuads = Quads:getSetsOfQuads(blockSheet, TILESIZE, TILESIZE)

function BlockMapGenerator:factory(map)
    self.addBlock(map)

    return map
end

function BlockMapGenerator.addBlock(map)
    local tile = map[10][4]

    local block = GameObject {
        x         = tile.x,
        y         = tile.y,
        width     = TILESIZE,
        height    = TILESIZE,
        texture   = blockSheet,
        quad      = blockQuads[7],
        -- onConsume = onConsume,
        onCollide = BlockMapGenerator.getOnCollide()
    }

    map[10][4] = block
end

function BlockMapGenerator.getOnCollide()
    return function(self, player, yOffset)
        player:blockY(self.y + yOffset)
    end
end
