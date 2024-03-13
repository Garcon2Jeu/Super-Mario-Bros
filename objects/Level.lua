Level = Class()


function Level:init(def)
    self.level = def.level
    Modules:plug(self, "BaseMap", def)
    local baseMap = self:generateEmptyMap()

    Modules:plug(self, "TileMap", table.deepCopy(baseMap))
    Modules:plug(self, "BlockMap", { baseMap = table.deepCopy(baseMap), tileMap = self.tileMap })
    Modules:plug(self, "CoinMap", table.deepCopy(baseMap))
    Modules:plug(self, "EnnemiManager", { level = self })

    self:cleanEnd()
    self:addLockAndKey()
    self.background = Background(#self.tileMap)
    self.goal = Goal(self)
end

function Level:update(dt, avatar, cameraScroll)
    self:updateEnnemis(dt, avatar)
    self.background:update(dt, cameraScroll)
    self.goal.flag.stateMachine:update(dt)
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
    self:updateBlockList()

    for columnIndex = #self.tileMap - 5, #self.tileMap do
        TileMapGenerator.addGroundColumn(self.tileMap[columnIndex])
    end
end

function Level:toNextLevel()
    State:change("play", {
        level = self.level + 1,
        columns = self.columns + 25,
        rows = MAP_HEIGHT
    })
end
