EnnemiManagerModule = Class()

function EnnemiManagerModule:init(def)
    self.ennemis = EnnemiGenerator:factory(def.level)
end

function EnnemiManagerModule:updateEnnemis(dt, avatar)
    for key, ennemi in pairs(self.ennemis) do
        ennemi:update(dt, avatar)
    end
end

function EnnemiManagerModule:drawEnnemis()
    for key, ennemi in pairs(self.ennemis) do
        ennemi:draw()
    end
end

function EnnemiManagerModule:removeEnnemi(index)
    table.remove(self.ennemis, index)
end
