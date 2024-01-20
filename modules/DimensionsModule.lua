DimensionsModule = Class()


DimensionsModule.fieldNames = {
    "width",
    "height"
}


function DimensionsModule:init(def)
    self.width = def.width or 0
    self.height = def.height or 0
end

function DimensionsModule:setWidth(width)
    self.width = width
end

function DimensionsModule:setHeight(height)
    self.height = height
end
