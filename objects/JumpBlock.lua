JumpBlock            = Class()

local jumpBlockSheet = Assets.graphics["jump_blocks"]()
local jumpBlockQuads = Quads:getSetsOfQuads(jumpBlockSheet, TILESIZE, TILESIZE)

local locksKeysAtlas = Assets.graphics["keys_and_locks"]()
local locksQuads     = Quads:getSetsOfQuads(locksKeysAtlas, TILESIZE, TILESIZE, 1, 2)[2]

function JumpBlock:init(def)
    def.width       = TILESIZE
    def.height      = TILESIZE
    def.spriteSheet = jumpBlockSheet
    def.quad        = jumpBlockQuads[7]
    self.column     = def.column
    self.row        = def.row

    Modules:plugInBulk(self, {
        ["Coordinates"] = def,
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
                Assets.audio["powerup_reveal"]:play()
                self:consumme(true)
                self:setSpriteSheet(jumpBlockSheet)
                self:setQuad(jumpBlockQuads[20])
                State.current.level:spawnCoin({
                    x      = self.x,
                    y      = self.y,
                    column = self.column,
                    row    = self.row - 1,
                    isKey  = self.hasKey
                })

                self.hasKey = false
            end
        end
end

function JumpBlock:makeLock()
    self:setSpriteSheet(locksKeysAtlas)
    self:setQuad(locksQuads[1])

    self.onConsume =
        function()
            if State.current.avatar.hasKey and not self:isConsummed() then
                self:consumme(true)
                self:setSpriteSheet(jumpBlockSheet)
                self:setQuad(jumpBlockQuads[20])
                State.current.level.goal.flag:changeState("unlocked")
                State.current.avatar.hasKey = false
            end
        end
end

function JumpBlock:giveKey()
    self.hasKey = true
end
