CollidableModule = Class()

function CollidableModule:init(def)
    self.collidable = true
    self.onCollide = def or CollidableModule.getOnCollide()
end

function CollidableModule.getOnCollide()
    return function(self, player, yOffset)
        player:blockY(self.y + yOffset)
    end
end

-- function Collidable:setOnCollide(def)
--     self.onCollide = def
-- end

-- function Collidable:isCollidable()
--     return self.collidable
-- end
