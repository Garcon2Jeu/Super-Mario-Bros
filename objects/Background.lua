Background = Class()

local backgroundSheet = Assets.graphics["backgrounds"]()
local backgroundSheetWidth = backgroundSheet:getWidth()
local backgroundQuadHeight = backgroundSheet:getHeight() / 3
local backgroundQuads = Quads:getSetsOfQuads(
    backgroundSheet,
    backgroundSheetWidth,
    backgroundQuadHeight
)

function Background:init(tileMapLength, quadIndex)
    Modules:plugInBulk(self, {
        ["Coordinates"] = { x = 0, y = 0 },
        ["Texture"] = {
            spriteSheet = backgroundSheet,
            quad = backgroundQuads[1],
            sy = VIRTUAL_HEIGHT / backgroundQuadHeight
        }
    })

    self.occurences = tileMapLength / TILESIZE
end

function Background:update(dt, cameraScroll)
    self.x = math.floor((cameraScroll / 3))
end

function Background:draw()
    for i = -1, self.occurences do
        love.graphics.draw(
            self.spriteSheet,
            self.quad,
            -self.x + (i * backgroundSheetWidth),
            self.y,
            0,
            self.sx,
            self.sy)
    end
end

function Background:changeTexture(index)
    self:setQuad(backgroundQuads[index])
end
