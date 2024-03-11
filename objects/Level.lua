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
    Modules:plug(self, "EnnemiManager", { level = self })

    self:cleanEnd()
    self.background = Background(#self.tileMap)
    self.goal = Goal(self)
end

function Level:update(dt, avatar, cameraScroll)
    self:updateEnnemis(dt, avatar)
    self.background:update(dt, cameraScroll)
end

function Level:draw()
    self:drawTileMap()
    self:drawCoinMap()
    self:drawBlockMap()
    self:drawEnnemis()
    self.goal:draw()
end

function Level:cleanEnd()
    TileMapGenerator:resetColumns(self.tileMap, #self.tileMap - 5)
    self:emptyColumns(self.blockMap, #self.blockMap - 5)

    for columnIndex = #self.tileMap - 5, #self.tileMap do
        TileMapGenerator.addGroundColumn(self.tileMap[columnIndex])
    end
end
