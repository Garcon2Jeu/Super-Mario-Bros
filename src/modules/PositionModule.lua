PositionModule = Class()

function PositionModule:init(def)
    self.x = def.x or 0
    self.y = def.y or 0
end

function PositionModule:setX(x)
    self.x = x
end

function PositionModule:setY(y)
    self.y = y
end
