TileMapModule = Class()

function TileMapModule:init(baseMap)
    self.tileMap = TileMapGenerator:factory(baseMap)
end

function TileMapModule:drawTileMap()
    for key, column in pairs(self.tileMap) do
        for key, tile in pairs(column) do
            if tile.collidable then
                tile:draw()

                if tile.topper then
                    tile.topper:draw()
                end
            end
        end
    end
end
