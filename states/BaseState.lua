-- BaseState = Class { __includes = BaseState }

BaseState = Class()
BaseState.stateName = "base"

function BaseState:init() end

function BaseState:update(dt) end

function BaseState:draw() end

function BaseState:enter() end

function BaseState:exit() end

function BaseState:setStateName(stateName)
    self.stateName = stateName
end

function BaseState:getCurrentStateName()
    return self.stateName
end
