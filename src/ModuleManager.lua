ModuleManager = Class()

function ModuleManager:init()
    self.modules = {
        ["Input"]              = function() return InputModule end,
        ["Camera"]             = function() return CameraModule end,

        ["BaseObject"]         = function() return BaseObject end,
        ["Position"]           = function() return PositionModule end,
        ["Dimensions"]         = function() return DimensionsModule end,
        ["Texture"]            = function() return TextureModule end,
        ["Hitbox"]             = function() return HitboxModule end,
        ["Gravity"]            = function() return GravityModule end,
        ["Move"]               = function() return MoveModule end,

        ["StateMachineModule"] = function() return StateMachineModule end,
        ["Animation"]          = function() return AnimationModule end,

        ["BaseMap"]            = function() return BaseMapModule end,
        ["TileMap"]            = function() return TileMapModule end,
        ["BlockMap"]           = function() return BlockMapModule end,
        ["CoinMap"]            = function() return CoinMapModule end,
    }
end

function ModuleManager:plug(object, moduleName, params)
    assert(self.modules[moduleName])
    local module = self.modules[moduleName]()
    self.extractMethods(module, object)
    module.init(object, params)
end

function ModuleManager.extractMethods(from, to)
    for key, value in pairs(from) do
        to[key] = to[key] or value
    end
end

function ModuleManager:plugInBulk(object, def)
    for name, params in pairs(def) do
        self:plug(object, name, params)
    end
end

return ModuleManager()

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
