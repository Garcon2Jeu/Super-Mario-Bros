LockBlock = Class()

local locksKeysAtlas = Assets.graphics["keys_and_locks"]()
local locksQuads = Quads:getSetsOfQuads(locksKeysAtlas, TILESIZE, TILESIZE, 1, 2)[2]

function LockBlock:init()
    Modules:plugInBulk(self, {
        ["Coordinates"] = { x = 0, y = 0 },
        ["Dimensions"] = { width = TILESIZE, height = TILESIZE },
        ["Texture"] = { spriteSheet = locksKeysAtlas, quad = locksQuads[1] },
        -- ["Collidable"] = {}
    })
end
