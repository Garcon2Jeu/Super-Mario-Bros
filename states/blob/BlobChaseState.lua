BlobChaseState = Class { __includes = BaseState }

function BlobChaseState:init(level, blob, interval, frames)
    self.level = level
    self.blob = blob
    self.frames = frames

    Timer.every(interval,
        function()
            self.blob:setDX(self.blob.facingRight and 1 or -1)
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
    if self.blob.dx > 0 then
        self.blob:applyDX()
        self.blob:applyFriction(dt, -5)
        self.blob:setQuad(self.frames[1])
        -- elseif self.blob.dx < -0 then
        --     self.blob:applyDX()
        --     self.blob:applyFriction(dt, 5)
        --     self.blob:setQuad(self.frames[1])
    else
        self.blob:setQuad(self.frames[2])
    end
end
