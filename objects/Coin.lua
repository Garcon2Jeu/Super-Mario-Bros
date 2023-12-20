Coin = Class()

local coinsSheet = Assets.graphics["coins_and_bombs"]()
local coinsQuads = Quads:getSetsOfQuads(Assets.graphics["coins_and_bombs"](), TILESIZE, TILESIZE)

function Coin:init(def)
    def.spriteSheet = coinsSheet
    def.quad        = coinsQuads[3]

    BaseObject.init(self, def)
end
