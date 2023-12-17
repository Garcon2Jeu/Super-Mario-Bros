Coin = Class { __includes = { GameObject, Hitbox } }

local coinsSheet = Assets.graphics["coins_and_bombs"]()
local coinsQuads = Quads:getSetsOfQuads(Assets.graphics["coins_and_bombs"](), TILESIZE, TILESIZE)

function Coin:init(def)
    def.texture = coinsSheet
    def.quad = coinsQuads[3]

    GameObject.init(self, def)
end
