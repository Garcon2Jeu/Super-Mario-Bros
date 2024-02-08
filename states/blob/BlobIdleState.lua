BlobIdleState = Class { __includes = BaseState }
BlobIdleState:setStateName("idle")

function BlobIdleState:init(blob, quad)
    self.blob = blob
    self.blob:setQuad(quad)
end

function BlobIdleState:update(dt)
    if State.current:isInView(self.blob) then
        self.blob:changeState("chase")
    end
end
