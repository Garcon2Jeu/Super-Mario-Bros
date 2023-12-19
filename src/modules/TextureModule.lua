TextureModule = Class()

function TextureModule:init(def)
    self.spriteSheet = def.spriteSheet or 0
    self.quad = def.quad or 0
end

function TextureModule:setSpriteSheet(spriteSheet)
    self.spriteSheet = spriteSheet
end

function TextureModule:setQuad(quad)
    self.quad = quad
end

function TextureModule:draw()
    love.graphics.draw(self.spriteSheet, self.quad, self.x, self.y)
end
