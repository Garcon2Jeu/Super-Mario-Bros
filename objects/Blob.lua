Blob = Class()

local creaturesSheet = Assets.graphics["creatures"]()
local creaturesQuads = Quads:getSetsOfQuads(creaturesSheet, TILESIZE, TILESIZE)

function Blob:init()
    local def = {
        x = 50,
        y = 50,
        width = TILESIZE,
        height = TILESIZE,
        spriteSheet = creaturesSheet,
        quad = creaturesQuads[9]
    }

    BaseObject.init(self, def)
end
