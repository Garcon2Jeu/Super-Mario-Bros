TextureModule = Class()


TextureModule.fieldNames = {
    "spriteSheet",
    "quad"
}


function TextureModule:init(def)
    self.spriteSheet = def.spriteSheet
    self.quad = def.quad
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

-- function TextureModule.getDefaultDef()
--     return TextureModule.defaultDef
-- end
