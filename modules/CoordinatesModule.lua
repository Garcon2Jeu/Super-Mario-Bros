CoordinatesModule = Class()

function CoordinatesModule:init(def)
    self.x = def.x or 0
    self.y = def.y or 0
end

function CoordinatesModule:setX(x)
    self.x = x
end

function CoordinatesModule:setY(y)
    self.y = y
end
