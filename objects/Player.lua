Player = Class()

local heartsSheet = Assets.graphics["hearts"]()
local heartsQuads = Quads:getSetsOfQuads(heartsSheet, 16, 16)

function Player:init()
    self.hearts    = 3
    self.score     = 0
    self.level     = 1
    self.character = nil
end

function Player:draw()
    self:drawUI()
end

function Player:drawUI()
    for i = 1, self.hearts do
        love.graphics.draw(heartsSheet, heartsQuads[5], 5 + (i - 1) * 10, 5, 0, .5, .5)
    end
end
