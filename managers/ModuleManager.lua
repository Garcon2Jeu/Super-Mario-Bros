ModuleManager = Class()

function ModuleManager:init()
    self.modules = {
        ["Input"]              = function() return InputModule end,
        ["Camera"]             = function() return CameraModule end,

        ["BaseObject"]         = function() return BaseObject end,
        ["Coordinates"]        = function() return CoordinatesModule end,
        ["Dimensions"]         = function() return DimensionsModule end,
        ["Texture"]            = function() return TextureModule end,
        ["Hitbox"]             = function() return HitboxModule end,
        ["Gravity"]            = function() return GravityModule end,
        ["Move"]               = function() return MoveModule end,
        ["Collidable"]         = function() return CollidableModule end,
        ["Consummable"]        = function() return ConsummableModule end,
        ["Asymmetric"]         = function() return AsymmetricModule end,

        ["StateMachineModule"] = function() return StateMachineModule end,
        ["Animation"]          = function() return AnimationModule end,

        ["MapPointer"]         = function() return MapPointerModule end,
        ["BaseMap"]            = function() return BaseMapModule end,
        ["TileMap"]            = function() return TileMapModule end,
        ["BlockMap"]           = function() return BlockMapModule end,
        ["CoinMap"]            = function() return CoinMapModule end,
        ["EnnemiManager"]      = function() return EnnemiManagerModule end,
    }
end

function ModuleManager:plug(object, moduleName, params)
    local module = self:getModule(moduleName)

    self.extractMethods(module, object)
    module.init(object, params)
    self.updateModulesList(object, moduleName)
end

function ModuleManager:getModule(moduleName)
    assert(self.modules[moduleName])
    return self.modules[moduleName]()
end

function ModuleManager.extractMethods(from, to)
    for key, value in pairs(from) do
        to[key] = to[key] or value
    end
end

function ModuleManager.updateModulesList(object, moduleName)
    object.modules = object.modules or {}
    table.insert(object.modules, moduleName)
end

function ModuleManager:plugInBulk(object, def)
    for name, params in pairs(def) do
        self:plug(object, name, params)
    end
end

-- Warning! Doesn't remove fields, only "nils" their value
-- (before: object.key = "value" -> after: object.key = nil)
function ModuleManager:unplug(object, moduleName)
    for key, value in pairs(self:getModule(moduleName)) do
        object[key] = nil
    end

    for key, value in pairs(self:getModule(moduleName).fieldNames) do
        object[value] = nil
    end

    table.removeByValue(object.modules, moduleName)
end

function ModuleManager:unplugInBulk(object, def)
    for key, moduleName in pairs(def) do
        self:unplug(object, moduleName)
    end
end

function ModuleManager:find(object, moduleName)
    if not object or not object.modules then
        return false
    end

    return table.indexOfValue(object.modules, moduleName)
end

return ModuleManager()

-- function ObjectMaker:assertComponents(def)
--     for name, value in pairs(def) do
--         assert(self.components[name])
--     end
-- end
