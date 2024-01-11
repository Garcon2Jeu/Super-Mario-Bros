Player = Class()

local heartsSheet = Assets.graphics["hearts"]()
local heartsQuads = Quads:getSetsOfQuads(heartsSheet, TILESIZE, TILESIZE)

local coinsSheet = Assets.graphics["coins_and_bombs"]()
local coinQuad = Quads:getSetsOfQuads(coinsSheet, TILESIZE, TILESIZE)[3]

function Player:init(level)
    self.hearts = 3
    self.coins  = 0
    self.level  = 1

    self.avatar = Avatar(level)
end

function Player:drawUI()
    for i = 1, self.hearts do
        love.graphics.draw(heartsSheet, heartsQuads[5], 5 + (i - 1) * 10, 5, 0, .5, .5)
    end

    love.graphics.draw(coinsSheet, coinQuad, 5, 14, 0, .5, .5)
    Assets.fonts.setSmall()
    love.graphics.print(": " .. self.coins, 14, 14.5)
end
