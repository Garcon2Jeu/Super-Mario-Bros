BlobIdleState = Class { __includes = BaseState }

function BlobIdleState:init(blob, quad)
    self.blob = blob
    self.blob:setQuad(quad)
end

function BlobIdleState:update(dt)
    self.blob:changeState("chase")
end
