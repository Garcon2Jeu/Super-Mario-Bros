Coin = Class()

local coinsSheet = Assets.graphics["coins_and_bombs"]()
local coinsQuads = Quads:getSetsOfQuads(coinsSheet, TILESIZE, TILESIZE)

function Coin:init(def)
    def.spriteSheet = coinsSheet
    def.quad        = coinsQuads[3]
    self.column     = def.column
    self.row        = def.row

    BaseObject.init(self, def)

    Modules:plugInBulk(self, {
        ["Collidable"] = self.getOnCollide(),
        ["Consummable"] = self.getOnConsume()
    })
end

function Coin.getOnCollide()
    return function(self)
        self:onConsume()
    end
end

function Coin.getOnConsume()
    return function(self)
        State.current.level:removeCoin(self)
    end
end
