Level = Class()

function Level:init()
    Modules:plug(self, "BaseMap", { columns = 100, rows = MAP_HEIGHT })
    local baseMap = self:generateEmptyMap()

    Modules:plug(self, "TileMap", table.deepCopy(baseMap))
    Modules:plug(self, "BlockMap", { baseMap = table.deepCopy(baseMap), tileMap = self.tileMap })
    Modules:plug(self, "CoinMap", table.deepCopy(baseMap))
    Modules:plug(self, "EnnemiManager", { level = self })
end

function Level:update(dt, avatar)
    self:updateEnnemis(dt, avatar)
end

function Level:draw()
    self:drawTileMap()
    self:drawCoinMap()
    self:drawBlockMap()
    self:drawEnnemis()
end
