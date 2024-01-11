AsymmetricModule = Class()

function AsymmetricModule:init(def)
    self.xOffset     = def.xOffset
    self.facingRight = true
    self.draw        = self.overrideDrawMethod(def.reverse)
end

function AsymmetricModule:isFacingRight()
    return self.facingRight
end

function AsymmetricModule:setFacingRight(bool)
    self.facingRight = bool
end

function AsymmetricModule.overrideDrawMethod(reverse)
    local right = reverse and -1 or 1
    local left = reverse and 1 or -1

    return function(self)
        love.graphics.draw(
            self.spriteSheet, self.quad,
            math.floor(self.x + self.xOffset),
            math.floor(self.y),
            0,
            self.facingRight and right or left, 1,
            self.xOffset
        )
    end
end
