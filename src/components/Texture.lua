Texture = Class()

function Texture:init(def)
    self.spriteSheet = def.spriteSheet or 0
    self.quad = def.quad or 0
end

function Texture:setSpriteSheet(spriteSheet)
    self.spriteSheet = spriteSheet
end

function Texture:setQuad(quad)
    self.quad = quad
end

function Texture:draw()
    love.graphics.draw(self.spriteSheet, self.quad, self.x, self.y)
end
