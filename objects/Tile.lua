Tile = Class()

local tilesSheet = Assets.graphics["tiles"]()
local tilesQuads = Quads:getSetsOfQuads(tilesSheet, TILESIZE, TILESIZE, 6, 10)

local toppersSheet = Assets.graphics["tile_tops"]()
local toppersQuads = Quads:getSetsOfQuads(toppersSheet, TILESIZE, TILESIZE, 6, 18)

function Tile:init(def)
    self.x = def.x
    self.y = def.y
end

function Tile:draw()
    if self.collidable then
        love.graphics.draw(tilesSheet, tilesQuads[21][3], self.x, self.y)
    end

    if self.topper then
        love.graphics.draw(toppersSheet, toppersQuads[3][1], self.x, self.y)
    end
end

function Tile:addCollidable()
    Collidable.init(self)
end
