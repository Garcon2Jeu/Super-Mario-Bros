BaseObject = Class()

function BaseObject:init(def)
    Modules:plugInBulk(self, {
        ["Coordinates"] = { x = def.x, y = def.y },
        ["Dimensions"]  = { width = def.width, height = def.height },
        ["Texture"]     = { spriteSheet = def.spriteSheet, quad = def.quad }
    })
end

-- function BaseObject:init(def, extraModules)
--     local modules = {
--         ["Position"]   = def,
--         ["Dimensions"] = def,
--         ["Texture"]    = def
--     }

--     if extraModules then
--         for key, extraModule in pairs(extraModules) do
--             modules[extraModule] = def
--         end
--     end

--     Modules:plugInBulk(self, modules)
-- end



-- function PlayerCharacter:init(level)
--     local def = {
--         x = CENTER_WIDTH - CHARACTER_WIDTH / 2,
--         y = 0,
--         width = CHARACTER_WIDTH,
--         height = CHARACTER_HEIGHT,
--         spriteSheet = pinkAtlas,
--         quad = pinkQuads[1]
--     }

--     local extraModules = { "Gravity", "Move", "Hitbox" }
--     BaseObject.init(self, def, extraModules)

--     Modules:plug(self, "StateMachineModule", self:getStates(level))
--     self:changeState("fall")

--     self.xOffset     = CHARACTER_WIDTH / 2 or 0
--     self.facingRight = true
-- end

-- function PlayerCharacter:init(level)
--     BaseObject.init(self, {
--         x = CENTER_WIDTH - CHARACTER_WIDTH / 2,
--         y = 0,
--         width = CHARACTER_WIDTH,
--         height = CHARACTER_HEIGHT,
--         spriteSheet = pinkAtlas,
--         quad = pinkQuads[1]
--     })

--     Modules:plugInBulk(self, {
--         ["StateMachineModule"] = self:getStates(level),
--         ["Gravity"]            = {},
--         ["Move"]               = {},
--         ["Hitbox"]             = {}
--     })

--     self:changeState("fall")

--     self.xOffset     = CHARACTER_WIDTH / 2 or 0
--     self.facingRight = true
-- end
