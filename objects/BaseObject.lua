BaseObject = Class()

function BaseObject:init(def)
    ModuleManager:plugInBulk(self, {
        ["Position"]   = { x = def.x, y = def.y },
        ["Dimensions"] = { width = def.width, height = def.height },
        ["Texture"]    = { spriteSheet = def.spriteSheet, quad = def.quad }
    })
end
