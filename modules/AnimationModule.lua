AnimationModule = Class()

function AnimationModule:init(def)
    self.frames = def.frames
    self.frameIndex = 1
    self.timer = Timer.every(def.interval, self:animate())
end

function AnimationModule:animate()
    return function()
        self.frameIndex = self.frameIndex + 1 <= #self.frames
            and self.frameIndex + 1 or 1
    end
end

function AnimationModule:getCurrentFrame()
    return self.frames[self.frameIndex]
end

function AnimationModule:removeTimer()
    self.timer:remove()
end
