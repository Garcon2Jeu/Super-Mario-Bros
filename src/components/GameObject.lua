GameObject = Class()

function GameObject:init(def)
    self.x       = def.x
    self.y       = def.y
    self.texture = def.texture
    self.quad    = def.quad
end

function GameObject:draw()
    love.graphics.draw(self.texture, self.quad, self.x, self.y)
end

function GameObject:setY(y)
    self.y = y
end

function GameObject:setQuad(quad)
    self.quad = quad
end
