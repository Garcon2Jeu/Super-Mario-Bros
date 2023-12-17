Tile = Class { __includes = GameObject }


local tilesSheet = Assets.graphics["tiles"]()
local tilesQuads = Quads:getSetsOfQuads(tilesSheet, TILESIZE, TILESIZE, 6, 10)


function Tile:init(def)
    GameObject.init(self, def)
end

function Tile:addCollidable()
    Collidable.init(self)

    self.texture = tilesSheet
    self.quad = tilesQuads[21][3]
end
