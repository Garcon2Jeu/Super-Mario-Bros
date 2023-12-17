TileTopper = Class { __includes = GameObject }

local toppersSheet = Assets.graphics["tile_tops"]()
local toppersQuads = Quads:getSetsOfQuads(toppersSheet, TILESIZE, TILESIZE, 6, 18)

function TileTopper:init(def)
    def.texture = toppersSheet
    def.quad = toppersQuads[3][1]

    GameObject.init(self, def)
end
