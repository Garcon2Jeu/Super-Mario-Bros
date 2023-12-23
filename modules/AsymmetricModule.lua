AsymmetricModule = Class()

function AsymmetricModule:init(def)
    self.xOffset     = def.xOffset
    self.facingRight = def.facingRight
    self.draw        = self.overrideDrawMethod()
end

function AsymmetricModule.overrideDrawMethod()
    return function(self)
        love.graphics.draw(
            self.spriteSheet, self.quad,
            math.floor(self.x + self.xOffset),
            math.floor(self.y),
            0,
            self.facingRight and -1 or 1, 1,
            self.xOffset
        )
    end
end
