Tile = Class()


local tilesSheet = Assets.graphics["tiles"]()
local tilesQuads = Quads:getSetsOfQuads(tilesSheet, TILESIZE, TILESIZE, 6, 10)


function Tile:init(def)
    ModuleManager:plugInBulk(self, {
        ["Position"] = def,
        ["Dimensions"] = def
    })
end

-- TOFIX!!!!--
function Tile:addCollidable()
    ModuleManager:plug(self, "Collidable")
    ModuleManager:plug(self, "Texture", {
        spriteSheet = tilesSheet,
        quad = tilesQuads[21][3]
    })

    -- ModuleManager:plugInBulk(self, {
    --     ["Texture"] = {
    --         spriteSheet = tilesSheet,
    --         quad = tilesQuads[21][3]
    --     },
    --     ["Collidable"] = {}
    -- })
end

-- TOFIX!!!!--

function Tile:addTopper(def)
    self.topper = TileTopper(def)
end
