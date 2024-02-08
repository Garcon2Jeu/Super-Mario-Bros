MapPointerModule = Class()


-- MapPointerModule.fieldNames = {}


-- Description:
---- returns tile index of grid based on given axis
---- if x given, returns column index, if y given, returns row index
-- Requires:
---- axis = integer value, x or y coordinate
function MapPointerModule:getGridIndex(axis)
    return math.floor(axis / TILESIZE) + 1
end

function MapPointerModule:pointToTile(map, x, y)
    if x < 0
        or y < 0
        -- Ugly?!--
        or x > State.current.level.width
        or y > State.current.level.height then
        -- Ugly?!--
        return nil
    end

    return map[self:getGridIndex(x)][self:getGridIndex(y)]
end

function MapPointerModule:getTilesFromHitPoints(map, edgeDirection)
    local p1, p2 = self:getHitboxEdge(edgeDirection)

    return self:pointToTile(map, p1.x, p1.y),
        self:pointToTile(map, p2.x, p2.y)
end

function MapPointerModule:checkForGround()
    local t1, t2 = self:getTilesFromHitPoints(
        State.current.level.tileMap, "bottom")
    local b1, b2 = self:getTilesFromHitPoints(
        State.current.level.blockMap, "bottom")

    for key, tile in pairs { t1, t2, b1, b2 } do
        if Modules:find(tile, "Collidable") then
            return true
        end
    end

    return false
end

function MapPointerModule:checkforWall()
    local t1, t2 = self:getTilesFromHitPoints(
        State.current.level.tileMap,
        self.facingRight and "right" or "left")
    local b1, b2 = self:getTilesFromHitPoints(
        State.current.level.blockMap,
        self.facingRight and "right" or "left")

    for key, object in pairs { t1, b1 } do
        if Modules:find(object, "Collidable") then
            return object
        end
    end

    return false
end

function MapPointerModule:checkForChasm()
    local columnIndex = self:getGridIndex(self.x)

    for index, tile in ipairs(State.current.level.tileMap[columnIndex]) do
        if Modules:find(tile, "Collidable") then
            return false
        end
    end

    return true
end

-- DEPRECATED --> USE Modules:find(object, "Collidable") instead
---- function MapPointerModule:isTileCollidable(tile)
----     return Modules:find(tile or self, "Collidable")
---- end
