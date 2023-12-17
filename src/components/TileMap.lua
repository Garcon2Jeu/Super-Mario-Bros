TileMap = Class()

function TileMap:drawTileMap()
    for key, column in pairs(self.tileMap) do
        for key, tile in pairs(column) do
            tile:draw()
        end
    end
end
