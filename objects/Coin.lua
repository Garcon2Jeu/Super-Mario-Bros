Coin = Class()

local coinsSheet = Assets.graphics["coins_and_bombs"]()
local coinsQuads = Quads:getSetsOfQuads(coinsSheet, TILESIZE, TILESIZE)

local locksKeysAtlas = Assets.graphics["keys_and_locks"]()
local keysQuads = Quads:getSetsOfQuads(locksKeysAtlas, TILESIZE, 13, 1, 2)[1]

function Coin:init(def)
    self.isKey      = def.isKey
    def.spriteSheet = self.isKey and locksKeysAtlas or coinsSheet
    def.quad        = self.isKey and keysQuads[1] or coinsQuads[3]
    self.column     = def.column
    self.row        = def.row

    BaseObject.init(self, def)

    Modules:plugInBulk(self, {
        ["Collidable"] = self.getOnCollide(),
        ["Consummable"] = self:getOnConsume()
    })
end

function Coin.getOnCollide()
    return function(self)
        self:onConsume()
    end
end

function Coin:getOnConsume()
    if not self.isKey then
        return function(self)
            Assets.audio["pickup"]:play()
            State.current.level:removeCoin(self)
            State.current.avatar:addCoin()
        end
    else
        return function(self)
            Assets.audio["pickup"]:play()
            State.current.level:removeCoin(self)
            State.current.avatar:giveKey()
        end
    end
end
