CameraModule = Class()

function CameraModule:init()
    self.cameraScroll = 0
end

function CameraModule:updateCamera(referenceX)
    self.cameraScroll = math.floor(referenceX - (VIRTUAL_WIDTH / 2) + (CHARACTER_WIDTH / 2))
end

function CameraModule:scrollCamera()
    love.graphics.translate(-self.cameraScroll, 0)
end
