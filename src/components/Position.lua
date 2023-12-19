Position = Class()

function Position:init(def)
    self.x = def.x or 0
    self.y = def.y or 0
end

function Position:setX(x)
    self.x = x
end

function Position:setY(y)
    self.y = y
end
