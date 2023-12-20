QuadManager = Class()

function QuadManager:getSetsOfQuads(atlas, tileWidth, tileHeight, setsPerAtlasWide, setsPerAtlasTall, keys)
    local coordinates = self.getCoordinates(atlas, tileWidth, tileHeight, setsPerAtlasWide, setsPerAtlasTall)
    local sets = {}

    for key, set in pairs(coordinates) do
        table.insert(sets, self.getSetOfQuads(atlas, set, tileWidth, tileHeight, keys))
    end

    return #sets == 1 and sets[1] or sets
end

function QuadManager.getCoordinates(atlas, tileWidth, tileHeight, setsPerAtlasWide, setsPerAtlasTall)
    local setWidth
    local setHeight

    local coordinates = {}

    if not setsPerAtlasTall and not setsPerAtlasWide
        or setsPerAtlasTall == 1 and setsPerAtlasWide == 1 then
        setWidth = atlas:getWidth()
        setHeight = atlas:getHeight()

        table.insert(coordinates, { x = 0, y = 0 })
    else
        setWidth = atlas:getWidth() / setsPerAtlasWide
        setHeight = atlas:getHeight() / setsPerAtlasTall

        for row = 1, setsPerAtlasTall do
            local y = (row - 1) * setHeight
            for column = 1, setsPerAtlasWide do
                local x = (column - 1) * setWidth
                table.insert(coordinates, { x = x, y = y })
            end
        end
    end

    local quadsPerSetWide = setWidth / tileWidth
    local quadsPerSetTall = setHeight / tileHeight

    for key, set in pairs(coordinates) do
        set.quads = {}

        for row = 1, quadsPerSetTall do
            local y = (row - 1) * tileHeight + set.y
            for column = 1, quadsPerSetWide do
                local x = (column - 1) * tileWidth + set.x

                table.insert(set.quads, { x = x, y = y })
            end
        end
    end

    return coordinates
end

function QuadManager.getSetOfQuads(atlas, set, tileWidth, tileHeight, keys)
    local quads = {}

    for key, quadData in pairs(set.quads) do
        local quad = love.graphics.newQuad(
            quadData.x,
            quadData.y,
            tileWidth,
            tileHeight,
            atlas:getDimensions()
        )

        if keys and #keys > 0 then
            quads[keys[1]] = quad
            table.remove(keys, 1)
        else
            table.insert(quads, quad)
        end
    end

    return quads
end

return QuadManager()
