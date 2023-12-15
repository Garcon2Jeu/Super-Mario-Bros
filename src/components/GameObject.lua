GameObject = Class()

function GameObject:init(def)
    self.x            = def.x
    self.y            = def.y
    self.width        = def.width
    self.height       = def.height
    self.texture      = def.texture
    self.xOffset      = def.width and self.width / 2
    self.stateMachine = def.stateMachine

    self.facingRight  = true
end

function GameObject:draw()
    love.graphics.draw(
        self.texture, self.quad,
        math.floor(self.x + self.xOffset),
        math.floor(self.y),
        0,
        self.facingRight and 1 or -1, 1,
        self.xOffset
    )
end

function GameObject:changeState(state, params)
    self.stateMachine:change(state, params)
end

function GameObject:isFacingRight()
    return self.facingRight
end

function GameObject:setFacingRight(bool)
    self.facingRight = bool
end

function GameObject:setQuad(quad)
    self.quad = quad
end

function GameObject:setY(y)
    self.y = y
end
