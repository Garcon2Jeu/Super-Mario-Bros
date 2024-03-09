QuadManager = Class()


-- Description:
---- Bundles processes and methods to get sets of quads in a symmetrical atlas
-- Requires:
---- atlas = drawable variable obtained with love.graphics.newImage()
---- tileWidth, tileHeight = number variables, represent each tile width and height in each set of quads
-- Optionnal:
---- setsPerAtlasWide, setsPerAtlasTall = number variables, represent the amount of sets of quads in a symmetrical atlas
---- keys = array of strings variable, will add string keys to each set from top left to bottom right
function QuadManager:getSetsOfQuads(atlas, tileWidth, tileHeight, setsPerAtlasWide, setsPerAtlasTall, keys)
    local coordinates = self.getCoordinates(atlas, tileWidth, tileHeight, setsPerAtlasWide, setsPerAtlasTall)
    local sets = {}

    for key, set in pairs(coordinates) do
        table.insert(sets, self.getSetOfQuads(atlas, set, tileWidth, tileHeight, keys))
    end

    return #sets == 1 and sets[1] or sets
end

-- Description:
---- Uses provided data to calculate each sets' quads' coordinates and returns all in an array called "coordinates",
---- in which each element is a set
-- Requires:
---- atlas = drawable variable obtained with love.graphics.newImage()
---- tileWidth, tileHeight = number variables, represent each tile width and height in each set of quads
-- Optionnal:
---- setsPerAtlasWide, setsPerAtlasTall = number variables, represent the amount of sets of quads in a symmetrical atlas
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

-- Description:
---- Generates all quads from coordinates inside "set"
-- Requires:
---- atlas = drawable variable obtained with love.graphics.newImage()
---- set = array variable, holds coordinates of each quad
---- tileWidth, tileHeight = number variables, represent each tile width and height in each set of quads
-- Optionnal:
---- keys = array of strings variable, will add string keys to each set from top left to bottom right
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

-- QuadManager = Class()

-- function QuadManager:getSetsOfQuads(atlas, tileWidth, tileHeight, setsPerAtlasWide, setsPerAtlasTall, keys)
--     local coordinates = self.getCoordinates(atlas, tileWidth, tileHeight, setsPerAtlasWide, setsPerAtlasTall)
--     local sets = {}

--     for key, set in pairs(coordinates) do
--         table.insert(sets, self.getSetOfQuads(atlas, set, tileWidth, tileHeight, keys))
--     end

--     return #sets == 1 and sets[1] or sets
-- end

-- function QuadManager.getCoordinates(atlas, tileWidth, tileHeight, setsPerAtlasWide, setsPerAtlasTall)
--     local setWidth
--     local setHeight

--     local coordinates = {}

--     if not setsPerAtlasTall and not setsPerAtlasWide
--         or setsPerAtlasTall == 1 and setsPerAtlasWide == 1 then
--         setWidth = atlas:getWidth()
--         setHeight = atlas:getHeight()

--         table.insert(coordinates, { x = 0, y = 0 })
--     else
--         setWidth = atlas:getWidth() / setsPerAtlasWide
--         setHeight = atlas:getHeight() / setsPerAtlasTall

--         for row = 1, setsPerAtlasTall do
--             local y = (row - 1) * setHeight
--             for column = 1, setsPerAtlasWide do
--                 local x = (column - 1) * setWidth
--                 table.insert(coordinates, { x = x, y = y })
--             end
--         end
--     end

--     local quadsPerSetWide = setWidth / tileWidth
--     local quadsPerSetTall = setHeight / tileHeight

--     for key, set in pairs(coordinates) do
--         set.quads = {}

--         for row = 1, quadsPerSetTall do
--             local y = (row - 1) * tileHeight + set.y
--             for column = 1, quadsPerSetWide do
--                 local x = (column - 1) * tileWidth + set.x

--                 table.insert(set.quads, { x = x, y = y })
--             end
--         end
--     end

--     return coordinates
-- end

-- function QuadManager.getSetOfQuads(atlas, set, tileWidth, tileHeight, keys)
--     local quads = {}

--     for key, quadData in pairs(set.quads) do
--         local quad = love.graphics.newQuad(
--             quadData.x,
--             quadData.y,
--             tileWidth,
--             tileHeight,
--             atlas:getDimensions()
--         )

--         if keys and #keys > 0 then
--             quads[keys[1]] = quad
--             table.remove(keys, 1)
--         else
--             table.insert(quads, quad)
--         end
--     end

--     return quads
-- end

-- return QuadManager()
