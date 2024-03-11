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

function Goal:init(level)
    Modules:plugInBulk(self, {
        ["Coordinates"] = { x = level.tileMap[#level.tileMap - 1][1].x, y = level.tileMap[#level.tileMap][GROUND_ROW].y - 48 },
        ["Texture"]     = { spriteSheet = goalAtlas, quad = polesQuads[1] },
    })

    self.flag = Flag(self)
end

function Goal:update(dt)
    self.flag.stateMachine:update()
end

function Goal:draw()
    love.graphics.draw(self.spriteSheet, self.quad, self.x, self.y)
    self.flag.stateMachine:draw()
end
