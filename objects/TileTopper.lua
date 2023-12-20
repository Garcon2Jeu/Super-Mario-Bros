TileTopper = Class()


local toppersSheet = Assets.graphics["tile_tops"]()
local toppersQuads = Quads:getSetsOfQuads(toppersSheet, TILESIZE, TILESIZE, 6, 18)


function TileTopper:init(def)
    BaseObject.init(self, {
        x = def.x,
        y = def.y,
        width = TILESIZE,
        height = TILESIZE,
        spriteSheet = toppersSheet,
        quad = toppersQuads[3][1]
    })
end
