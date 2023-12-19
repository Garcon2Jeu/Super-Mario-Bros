ObjectMaker = Class()

function ObjectMaker:init()
    self.components = {
        ["BaseObject"] = function() return BaseObject end,

        ["Position"] = function() return Position end,
        ["Dimensions"] = function() return Dimensions end,
        ["Texture"] = function() return Texture end,
    }
end

function ObjectMaker:factory(object, def)
    for name, params in pairs(def) do
        self:plugComponent(object, name, params)
    end
end

function ObjectMaker:plugComponent(object, componentName, params)
    assert(self.components[componentName])
    local component = self.components[componentName]()
    self.extractMethods(component, object)
    component.init(object, params)
end

function ObjectMaker.extractMethods(from, to)
    for key, value in pairs(from) do
        to[key] = value
    end
end

return ObjectMaker()

-- function ObjectMaker:assertComponents(def)
--     for name, value in pairs(def) do
--         assert(self.components[name])
--     end
-- end

-- function ObjectMaker.extractMethods(component, object)
--     for key, value in pairs(component) do
--         object[key] = value
--     end
-- end
