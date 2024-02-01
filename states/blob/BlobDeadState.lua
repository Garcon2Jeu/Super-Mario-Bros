BlobDeadState = Class { __includes = BaseState }
BlobDeadState:setStateName("dead")

function BlobDeadState:init(blob, quad)
    blob:setQuad(quad)
end
