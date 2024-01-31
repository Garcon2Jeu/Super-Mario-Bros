Level = Class()

local levelData = {
    columns = 100,
    rows = MAP_HEIGHT
}

function Level:init()
    Modules:plug(self, "BaseMap", levelData)
    local baseMap = self:generateEmptyMap()

    Modules:plug(self, "TileMap", table.deepCopy(baseMap))
    Modules:plug(self, "BlockMap", { baseMap = table.deepCopy(baseMap), tileMap = self.tileMap })
    Modules:plug(self, "CoinMap", table.deepCopy(baseMap))
    -- Modules:plug(self, "EnnemiManager", { level = self })

    self.background = Background(#self.tileMap)
end

function Level:update(dt, avatar, cameraScroll)
    -- self:updateEnnemis(dt, avatar)
    self.background:update(dt, cameraScroll)
end

function Level:draw()
    self:drawTileMap()
    self:drawCoinMap()
    self:drawBlockMap()
    -- self:drawEnnemis()
end
