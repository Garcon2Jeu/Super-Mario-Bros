TileTopper = Class()


local toppersSheet = Assets.graphics["tile_tops"]()
local toppersQuads = Quads:getSetsOfQuads(toppersSheet, TILESIZE, TILESIZE, 6, 18)


function TileTopper:init(def)
    def.width       = TILESIZE
    def.height      = TILESIZE
    def.spriteSheet = toppersSheet
    def.quad        = toppersQuads[3][1]

    BaseObject.init(self, def)
end
