Hitbox = Class()

local radius = .5

function Hitbox:updateHitbox()
    self.topLeft     = { x = self.x, y = self.y }
    self.topRight    = { x = self.x + self.width, y = self.y }
    self.bottomLeft  = { x = self.x, y = self.y + self.height }
    self.bottomRight = { x = self.x + self.width, y = self.y + self.height }
end

function Hitbox:getHitboxEdge(direction, p1XOffset, p1YOffset, p2XOffset, p2YOffset)
    local p1 = { x = p1XOffset or 0, y = p1YOffset or 0 }
    local p2 = { x = p2XOffset or 0, y = p2YOffset or 0 }

    if direction == "bottom" then
        p1.x, p1.y = p1.x + self.bottomLeft.x, p1.y + self.bottomLeft.y
        p2.x, p2.y = p2.x + self.bottomRight.x, p2.y + self.bottomRight.y
    elseif direction == "right" then
        p1.x, p1.y = p1.x + self.topRight.x, p1.y + self.topRight.y
        p2.x, p2.y = p2.x + self.bottomRight.x, p2.y + self.bottomRight.y
    elseif direction == "left" then
        p1.x, p1.y = p1.x + self.topLeft.x, p1.y + self.topLeft.y
        p2.x, p2.y = p2.x + self.bottomLeft.x, p2.y + self.bottomLeft.y
    elseif direction == "top" then
        p1.x, p1.y = p1.x + self.topLeft.x, p1.y + self.topLeft.y
        p2.x, p2.y = p2.x + self.topRight.x, p2.y + self.topRight.y
    end

    return p1, p2
end

function Hitbox:drawPoints()
    love.graphics.circle("fill", self.topLeft.x, self.topLeft.y, radius)
    love.graphics.circle("fill", self.topRight.x, self.topRight.y, radius)
    love.graphics.circle("fill", self.bottomLeft.x, self.bottomLeft.y, radius)
    love.graphics.circle("fill", self.bottomRight.x, self.bottomRight.y, radius)
end
