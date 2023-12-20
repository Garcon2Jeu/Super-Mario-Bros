JumpBlock            = Class()

local jumpBlockSheet = Assets.graphics["jump_blocks"]()
local jumpBlockQuads = Quads:getSetsOfQuads(jumpBlockSheet, TILESIZE, TILESIZE)

function JumpBlock:init(def)
    def.width       = TILESIZE
    def.height      = TILESIZE
    def.spriteSheet = jumpBlockSheet
    def.quad        = jumpBlockQuads[7]

    Modules:plugInBulk(self, {
        ["Position"]    = def,
        ["Dimensions"]  = def,
        ["Texture"]     = def,
        ["Collidable"]  = self.getOnCollide(),
        ["Consummable"] = self.getOnConsume()
    })
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
                self:setQuad(jumpBlockQuads[20])
                State.current.level:spawnCoin(self.x, self.y)
            end
        end
end
