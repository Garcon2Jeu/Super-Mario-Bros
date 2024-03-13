Tile = Class()


local tilesSheet = Assets.graphics["tiles"]()
local tilesQuads = Quads:getSetsOfQuads(tilesSheet, TILESIZE, TILESIZE, 6, 10)

local decorationSheet = Assets.graphics["bushes_and_cacti"]()
local decorationQuads = Quads:getSetsOfQuads(decorationSheet, TILESIZE, TILESIZE, 1, 5)


function Tile:init(def)
    Modules:plugInBulk(self, {
        ["Coordinates"] = def,
        ["Dimensions"]  = def
    })
end

function Tile:addCollidable()
    Modules:plugInBulk(self, {
        ["Collidable"] = self:getOnCollide(),
        ["Texture"]    = { spriteSheet = tilesSheet, quad = tilesQuads[21][3] }
    })

    self.ground = true
end

function Tile:addDecoration(quadIndex)
    Modules:plug(self, "Texture", { spriteSheet = decorationSheet, quad = decorationQuads[1][quadIndex] })
end

function Tile:addTopper(def)
    self.topper = TileTopper(def)
end

function Tile.getOnCollide()
    return function(self, player, yOffset)
        player:blockY(self.y + yOffset)
    end
end

-- TO FIX BY SET
function Tile.getDecorationQuads()
    return decorationQuads[1]
end

function Tile:changeGroundTexture(index)
    self:setQuad(tilesQuads[index][3])
end
