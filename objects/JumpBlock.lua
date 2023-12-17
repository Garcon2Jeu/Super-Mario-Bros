JumpBlock = Class { __includes = {
    GameObject,
    Collidable,
    Consummable
} }

local JumpBlockSheet = Assets.graphics["jump_blocks"]()
local JumpBlockQuads = Quads:getSetsOfQuads(JumpBlockSheet, TILESIZE, TILESIZE)

function JumpBlock:init(def)
    def.texture = JumpBlockSheet
    def.quad    = JumpBlockQuads[7]

    GameObject.init(self, def)
    Collidable.init(self, self.getOnCollide())
    Consummable.init(self, self.getOnConsume())
end

function JumpBlock.getOnCollide()
    return
        function(self, player, yOffset)
            if player.dy < 0 then
                self:onConsume()
            end

            player:blockY(self.y + yOffset)
        end
end

function JumpBlock.getOnConsume()
    return
        function(self)
            if not self:isConsummed() then
                self:consumme(true)
                self:setQuad(JumpBlockQuads[20])
                State.current.level:spawnCoin(self.x, self.y)
            end
        end
end
