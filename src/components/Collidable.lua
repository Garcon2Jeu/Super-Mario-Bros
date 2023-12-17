Collidable = Class()

function Collidable:init(def)
    self.collidable = true
    self.onCollide = Collidable.getOnCollide()
end

function Collidable.getOnCollide()
    return function(self, player, yOffset)
        player:blockY(self.y + yOffset)
    end
end
