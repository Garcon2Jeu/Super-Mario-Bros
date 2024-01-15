Level = Class()

function Level:init()
    Modules:plug(self, "BaseMap", { columns = 20, rows = MAP_HEIGHT })
    local baseMap = self:generateEmptyMap()

    Modules:plugInBulk(self, {
        ["TileMap"]       = App:deepCopy(baseMap),
        ["BlockMap"]      = App:deepCopy(baseMap),
        ["CoinMap"]       = App:deepCopy(baseMap),
        ["EnnemiManager"] = { level = self },
    })
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
