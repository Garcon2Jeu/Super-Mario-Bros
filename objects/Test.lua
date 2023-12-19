Test = Class()

local pinkAtlas = Assets.graphics["pink_alien"]()
local pinkQuads = Quads:getSetsOfQuads(pinkAtlas, CHARACTER_WIDTH, CHARACTER_HEIGHT)

function Test:init()
    ModuleManager:plug(self, "BaseObject", {
        x           = 50,
        y           = 50,
        width       = TILESIZE,
        height      = 20,
        spriteSheet = pinkAtlas,
        quad        = pinkQuads[1]
    })
end
