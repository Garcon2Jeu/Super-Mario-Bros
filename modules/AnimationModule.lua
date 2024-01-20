AnimationModule = Class()


AnimationModule.fieldNames = {
    "frames",
    "frameIndex",
    "timer"
}


-- Requires:
---- def.frames = list of variables of type Quad
---- def.interval = time between frame changes, number type variable
-- Optionnal
---- def.customAnimation = function variable, if not included, will be replaced by default animation function
function AnimationModule:init(def)
    self.frames = def.frames
    self.frameIndex = 1
    self.timer = Timer.every(def.interval, def.customAnimation or self:defaultAnimation())
end

-- Alternate between all provided frames in self.frames at given interval
function AnimationModule:defaultAnimation()
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
