CollidableModule = Class()

CollidableModule.defaultDef = {
    collidable = nil,
    onCollide = nil
}

function CollidableModule:init(def)
    self.collidable = true
    self.onCollide = def
end

function CollidableModule:setCollidable(bool)
    self.collidable = bool
end

function CollidableModule:toggleCollidable()
    self.collidable = not self.collidable
end
