Goal = Class()

local goalAtlas = Assets.graphics["flags"]()

local goalPostsSet = {
    x = 4,
    y = 0,
    width = 8,
    height = 64,
    gap = 8,
    amount = 6,
}

local goalPostsQuads = {}

for i = 0, goalPostsSet.amount - 1 do
    local x = goalPostsSet.x + i * (goalPostsSet.width + goalPostsSet.gap)

    table.insert(goalPostsQuads,
        love.graphics.newQuad(
            x, 0,
            goalPostsSet.width, goalPostsSet.height,
            goalAtlas:getDimensions())
    )
end




function Goal:init()
    Modules:plugInBulk(self,
        {
            ["Coordinates"] = { x = 10, y = 10 },
            ["Texture"] = { spriteSheet = goalAtlas, quad = goalPostsQuads[1] }
        })
end
