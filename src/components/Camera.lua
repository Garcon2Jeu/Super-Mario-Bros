Camera = Class()

function Camera:init()
    self.cameraScroll = 0
end

function Camera:updateCamera(referenceX)
    self.cameraScroll = math.floor(referenceX - (VIRTUAL_WIDTH / 2) + (CHARACTER_WIDTH / 2))
end

function Camera:scrollCamera()
    love.graphics.translate(-self.cameraScroll, 0)
end
