StartState = Class { __includes = BaseState }

function StartState:init()
    self.player = PlayerCharacter()
end

function StartState:update(dt)
    self.player:update(dt)
end

function StartState:draw()
    self.player:draw()
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
    love.graphics.print(tostring(self.player.stateMachine.debug), 50, 50)
    ------------------------------------------------------DEBUG-------------------------------------------------------------------
end
