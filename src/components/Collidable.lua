Collidable = Class()

function Collidable:init(def)
    self.collidable = true
    self.onCollide = def or Collidable.getOnCollide()
end

function Collidable.getOnCollide()
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