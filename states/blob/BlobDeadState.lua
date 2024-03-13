BlobDeadState = Class { __includes = BaseState }
BlobDeadState:setStateName("dead")

function BlobDeadState:init(blob, quad)
    Assets.audio["kill"]:play()
    blob:setQuad(quad)
end
