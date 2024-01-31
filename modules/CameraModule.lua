CameraModule = Class()


local cameraOffset = math.floor(VIRTUAL_WIDTH / 3) + (CHARACTER_WIDTH / 2)



CameraModule.fieldNames = {
    "cameraScroll"
}


function CameraModule:init()
    self.cameraScroll = 0
end

-- Description:
---- Update Camera's X relative to a given X coordinate (player avatar)
---- Camera follows referenceX if it pushes past cameraOffset
---- and stops if referenceX plus the difference between the screen's width and cameraOffset
---- goes further than the last tile's X plus its width
---- Allows going back and forth from start and end of the level
-- Requires:
---- referenceX = number variable, references which X coordinate the camera should follow
---- tileMapWidth = number variable, width of current level's tileMap
-- Optionnal:
function CameraModule:updateCamera(referenceX, tileMapWidth)
    if referenceX < cameraOffset then
        self.cameraScroll = 0
    elseif referenceX + (VIRTUAL_WIDTH - cameraOffset) >= tileMapWidth then
        self.cameraScroll = tileMapWidth - VIRTUAL_WIDTH
    else
        self.cameraScroll = math.floor(referenceX - cameraOffset)
    end
end

function CameraModule:scrollCamera()
    love.graphics.translate(-self.cameraScroll, 0)
end
