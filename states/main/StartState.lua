StartState = Class { __includes = BaseState }

StartState = Class()
StartState.stateName = "base"

function StartState:init() end

function StartState:update(dt) end

function StartState:draw() end

function StartState:enter() end

function StartState:exit() end

function StartState:setStateName(stateName)
    self.stateName = stateName
end

function StartState:getCurrentStateName()
    return self.stateName
end
