BlobChaseState = Class { __includes = BaseState }
BlobChaseState:setStateName("chase")

function BlobChaseState:init(level, blob, interval, frames)
    self.level = level
    self.blob = blob
    self.frames = frames

    Timer.every(interval,
        function()
            self.blob:setDX(self.blob.facingRight and 1 or -1)
            Timer.after(interval / 6, function() self.blob:setDX(0) end)
        end
    )
end

function BlobChaseState:update(dt)
    self:crawl(dt)
end

function BlobChaseState:exit()
    self:removeTimer(self)
end

function BlobChaseState:crawl(dt)
    self.blob:applyDX()

    if self.blob.dx > 0 then
        self.blob:applyFriction(dt, -5)
        self.blob:setQuad(self.frames[1])
    elseif self.blob.dx < 0 then
        self.blob:applyFriction(dt, 5)
        self.blob:setQuad(self.frames[1])
    else
        self.blob:setQuad(self.frames[2])
    end
end
