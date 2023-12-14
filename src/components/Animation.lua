Animation = Class()

function Animation:init(interval, frames)
    self.frames = frames
    self.frameIndex = 1
    self.timer = Timer.every(interval, self:animate())
end

function Animation:animate()
    return function()
        self.frameIndex = self.frameIndex + 1 <= #self.frames
            and self.frameIndex + 1 or 1
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.frameIndex]
end

function Animation:removeTimer()
    self.timer:remove()
end
