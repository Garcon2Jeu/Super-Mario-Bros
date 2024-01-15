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

-- Refactor to MapPointerModule? ---
function Level:pointToTile(map, x, y)
    if x < 0 or y < 0 or x > self.width or y > self.height then
        return nil
    end

    local column = math.floor(x / TILESIZE) + 1
    local row = math.floor(y / TILESIZE) + 1

    return map[column][row]
end

function Level:getTilesFromHitPoints(map, object, edgeDirection)
    local x1, y1, x2, y2 = object:getHitboxOffset(edgeDirection)
    local p1, p2 = object:getHitboxEdge(edgeDirection, x1, y1, x2, y2)

    return self:pointToTile(map, p1.x, p1.y), self:pointToTile(map, p2.x, p2.y)
end

function Level:isCollidable(tile)
    if not tile then
        return false
    end

    return tile.collidable
end

-- Refactor to MapPointerModule? ---
