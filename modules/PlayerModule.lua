PlayerModule = Class()

local heartsSheet = Assets.graphics["hearts"]()
local heartsQuads = Quads:getSetsOfQuads(heartsSheet, TILESIZE, TILESIZE)

local coinsSheet = Assets.graphics["coins_and_bombs"]()
local coinQuad = Quads:getSetsOfQuads(coinsSheet, TILESIZE, TILESIZE)[3]

local locksKeysAtlas = Assets.graphics["keys_and_locks"]()
local keysQuads = Quads:getSetsOfQuads(locksKeysAtlas, TILESIZE, 13, 1, 2)[1]

function PlayerModule:init()
    self.hearts     = 3
    self.coins      = 0
    self.levelIndex = 1
end

function PlayerModule:drawUI()
    if self.hasKey then
        love.graphics.draw(locksKeysAtlas, keysQuads[1], 5, 20)
    end

    for i = 1, self.hearts do
        love.graphics.draw(heartsSheet, heartsQuads[5], 5 + (i - 1) * 10, 5, 0, .5, .5)
    end

    love.graphics.draw(coinsSheet, coinQuad, 5, 14, 0, .5, .5)
    Assets.fonts.setSmall()
    love.graphics.print(": " .. self.coins, 14, 14.5)
end

function PlayerModule:addHeart()
    self.hearts = self.hearts + 1
end

function PlayerModule:removeHeart()
    self.hearts = self.hearts - 1
end

function PlayerModule:hasLost()
    return self.hearts == 0 or self.y >= VIRTUAL_HEIGHT
end

function PlayerModule:addCoin()
    self.coins = self.coins + 1
end

function PlayerModule:giveKey()
    self.hasKey = true
end
