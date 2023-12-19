Dimensions = Class()

function Dimensions:init(def)
    self.width = def.width or 0
    self.height = def.height or 0
end

function Dimensions:setWidth(width)
    self.width = width
end

function Dimensions:setHeight(height)
    self.height = height
end
