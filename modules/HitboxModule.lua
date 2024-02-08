HitboxModule = Class()


HitboxModule.fieldNames = {
    "topLeft",
    "topRight",
    "bottomLeft",
    "bottomRight"
}

local defaultOffsets = {
    ["bottom"] = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 },
    ["right"]  = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 },
    ["left"]   = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 },
    ["top"]    = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 }
}


local radius = .5

function HitboxModule:init(def)
    self.offsets = def.offsets or defaultOffsets
end

function HitboxModule:updateHitbox()
    self.topLeft     = { x = self.x, y = self.y }
    self.topRight    = { x = self.x + self.width, y = self.y }
    self.bottomLeft  = { x = self.x, y = self.y + self.height }
    self.bottomRight = { x = self.x + self.width, y = self.y + self.height }
end

function HitboxModule:getHitboxEdge(direction)
    local p1, p2 = {}, {}

    if direction == "bottom" then
        p1.x = self.offsets[direction].x1 + self.bottomLeft.x
        p1.y = self.offsets[direction].y1 + self.bottomLeft.y
        p2.x = self.offsets[direction].x2 + self.bottomRight.x
        p2.y = self.offsets[direction].y2 + self.bottomRight.y
    elseif direction == "right" then
        p1.x = self.offsets[direction].x1 + self.topRight.x
        p1.y = self.offsets[direction].y1 + self.topRight.y
        p2.x = self.offsets[direction].x2 + self.bottomRight.x
        p2.y = self.offsets[direction].y2 + self.bottomRight.y
    elseif direction == "left" then
        p1.x = self.offsets[direction].x1 + self.topLeft.x
        p1.y = self.offsets[direction].y1 + self.topLeft.y
        p2.x = self.offsets[direction].x2 + self.bottomLeft.x
        p2.y = self.offsets[direction].y2 + self.bottomLeft.y
    elseif direction == "top" then
        p1.x = self.offsets[direction].x1 + self.topLeft.x
        p1.y = self.offsets[direction].y1 + self.topLeft.y
        p2.x = self.offsets[direction].x2 + self.topRight.x
        p2.y = self.offsets[direction].y2 + self.topRight.y
    end

    return p1, p2
end

function HitboxModule:collides(foreign)
    return self.topLeft.x <= foreign.bottomRight.x
        and self.bottomRight.x >= foreign.topLeft.x
        and self.topLeft.y <= foreign.bottomRight.y
        and self.bottomRight.y >= foreign.bottomRight.y
end

function HitboxModule:drawPoints()
    love.graphics.circle("fill", self.topLeft.x, self.topLeft.y, radius)
    love.graphics.circle("fill", self.topRight.x, self.topRight.y, radius)
    love.graphics.circle("fill", self.bottomLeft.x, self.bottomLeft.y, radius)
    love.graphics.circle("fill", self.bottomRight.x, self.bottomRight.y, radius)
end

function HitboxModule:drawBox()
    love.graphics.rectangle("line", self.topLeft.x, self.topLeft.y, self.width, self.height)
end
