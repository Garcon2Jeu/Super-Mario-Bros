Collidable = Class()

function Collidable:init(def)
    self.collidable = true
    self.onCollide = def
end
