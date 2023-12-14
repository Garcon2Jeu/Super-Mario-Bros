StartState = Class { __includes = BaseState }

function StartState:init()
    self.player = PlayerCharacter()
    self.level = Level()
end

function StartState:update(dt)
    self.player:update(dt)
end

function StartState:draw()
    self.player:draw()
    self.level:draw()
end
