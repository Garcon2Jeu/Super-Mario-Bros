TileMapModule = Class()

function TileMapModule:init(def)
    self.tileMap = TileMapGenerator:factory(def.baseMap)
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
