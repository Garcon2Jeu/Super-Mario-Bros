Block = Class { __includes = { GameObject, Hitbox } }

function Block:init(def)
    GameObject.init(self, def)
    self:updateHitbox()
end
