MapPointerModule = Class()

function MapPointerModule:pointToTile(map, x, y)
    if x < 0 or y < 0
        -- Ugly?!--
        or x > State.current.level.width or y > State.current.level.height then
        -- Ugly?!--
        return nil
    end

    local column = math.floor(x / TILESIZE) + 1
    local row = math.floor(y / TILESIZE) + 1

    return map[column][row]
end

function MapPointerModule:getTilesFromHitPoints(map, object, edgeDirection)
    local x1, y1, x2, y2 = object:getHitboxOffset(edgeDirection)
    local p1, p2 = object:getHitboxEdge(edgeDirection, x1, y1, x2, y2)

    return self:pointToTile(map, p1.x, p1.y),
        self:pointToTile(map, p2.x, p2.y)
end

function MapPointerModule:isTileCollidable(tile)
    return Modules:find(tile, "Collidable")
end

function MapPointerModule:checkForGround()
    local t1, t2 = self:getTilesFromHitPoints(
        State.current.level.tileMap, self, "bottom")
    local b1, b2 = self:getTilesFromHitPoints(
        State.current.level.blockMap, self, "bottom")

    for key, tile in pairs { t1, t2, b1, b2 } do
        if self:isTileCollidable(tile) then
            return true
        end
    end

    return false
end
