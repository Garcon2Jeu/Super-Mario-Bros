BlobIdleState = Class { __includes = BaseState }

function BlobIdleState:init(blob, quad)
    self.blob = blob
    self.blob:setQuad(quad)
end

-- function BlobIdleState:update(dt)
--     if App:keyPressed("space") then
--         self.player:changeState("jump")
--         return
--     end

--     if self.player:isRunning() then
--         self.player:changeState("run")
--         return
--     end
-- end
