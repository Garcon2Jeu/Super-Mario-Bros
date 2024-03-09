Goal = Class()

local goalAtlas = Assets.graphics["flags"]()

local polesSet = {
    x = 4,
    y = 0,
    width = 8,
    height = 64,
    gap = 8,
    amount = 6,
}

local polesQuads = {}

for i = 0, polesSet.amount - 1 do
    local x = polesSet.x + i * (polesSet.width + polesSet.gap)

    table.insert(polesQuads,
        love.graphics.newQuad(
            x, 0,
            polesSet.width, polesSet.height,
            goalAtlas:getDimensions())
    )
end

local flagsSet = {
    x = 96,
    y = 0,
    width = 16,
    height = 10,
    gap = 8,
    amount = 6,
    interval = .13
}

local flagsQuads = {}

for i = 1, 3 do
    table.insert(flagsQuads, love.graphics.newQuad(
        flagsSet.x + (i - 1) * flagsSet.width,
        flagsSet.y,
        i < 3 and flagsSet.width or 6,
        i < 3 and flagsSet.height or 15,
        goalAtlas:getDimensions())
    )
end

function Goal:init()
    Modules:plugInBulk(self,
        {
            ["Coordinates"] = { x = 5, y = 5 },
            ["Animation"] = { frames = { flagsQuads[1], flagsQuads[2] }, interval = flagsSet.interval },
        })
end

function Goal:draw()
    love.graphics.draw(goalAtlas, polesQuads[1], self.x, self.y)
    love.graphics.draw(goalAtlas, self:getCurrentFrame(), self.x + 6, self.y + 5)
end
