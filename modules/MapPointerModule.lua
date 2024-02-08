MapPointerModule = Class()


-- MapPointerModule.fieldNames = {}


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

-- DEPRECATED --> USE Modules:find(object, "Collidable") instead
---- function MapPointerModule:isTileCollidable(tile)
----     return Modules:find(tile or self, "Collidable")
---- end
