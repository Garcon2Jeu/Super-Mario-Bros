BlobChaseState = Class { __includes = BaseState }
BlobChaseState:setStateName("chase")

function BlobChaseState:init(level, blob, interval, frames)
    self.level = level
    self.blob = blob

    Modules:plug(self, "Animation", {
        interval        = interval,
        frames          = frames,
        customAnimation = self:getCustomAnimation(interval)
    })
end

function BlobChaseState:update(dt)
    if not State.current:isInView(self.blob) then
        self.blob:changeState("idle")
    end

    self:crawl(dt)

    if not self.blob:checkForGround() then
        self.blob:changeState("fall")
        return
    end
end

function BlobChaseState:exit()
    self:removeTimer()
end

function BlobChaseState:crawl(dt)
    self.blob:applyDX()
    self.blob:setQuad(self.frames[1])

    if self.blob.dx > 0 then
        self.blob:applyFriction(dt, -5)
    elseif self.blob.dx < 0 then
        self.blob:applyFriction(dt, 5)
    else
        self.blob:setQuad(self.frames[2])
    end
end

function BlobChaseState:getCustomAnimation(interval)
    return function()
        Assets.audio["kill2"]:play()
        self.blob:setDX(self.blob.facingRight and 1 or -1)
        Timer.after(interval / 6, function() self.blob:setDX(0) end)
    end
end
