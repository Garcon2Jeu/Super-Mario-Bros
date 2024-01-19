CollidableModule = Class()

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

-- function Collidable:setOnCollide(def)
--     self.onCollide = def
-- end

-- function Collidable:isTileCollidable()
--     return self.collidable
-- end
