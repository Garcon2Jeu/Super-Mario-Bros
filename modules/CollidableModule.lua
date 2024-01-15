CollidableModule = Class()

function CollidableModule:init(def)
    self.collidable = true
    self.onCollide = def
end

-- function Collidable:setOnCollide(def)
--     self.onCollide = def
-- end

-- function Collidable:isTileCollidable()
--     return self.collidable
-- end
