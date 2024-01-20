CollidableModule = Class()


CollidableModule.fieldNames = {
    "collidable",
    "onCollide"
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
