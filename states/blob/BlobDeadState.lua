BlobDeadState = Class { __includes = BaseState }
BlobDeadState:setStateName("dead")

function BlobDeadState:init(blob, quad)
    blob:setQuad(quad)
end

function BlobDeadState:update(dt) end

function BlobDeadState:draw() end

function BlobDeadState:enter() end

function BlobDeadState:exit() end
