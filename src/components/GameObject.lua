GameObject = Class()

function GameObject:init(def)
    self.x            = def.x
    self.y            = def.y
    self.width        = def.width
    self.height       = def.height
    self.texture      = def.texture
    self.quad         = def.quad
    self.stateMachine = def.stateMachine
end

function GameObject:draw()
    love.graphics.draw(self.texture, self.quad, self.x, self.y)
end

function GameObject:changeState(state, params)
    self.stateMachine:change(state, params)
end
