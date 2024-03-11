FlagUnlockedState = Class { __includes = BaseState }

FlagUnlockedState.stateName = "base"

function FlagUnlockedState:init(flag, flagQuad)
    self.flag = flag
    self.flag:setQuad(flagQuad)
end

function FlagUnlockedState:draw()
    self.flag:draw()
end

function FlagUnlockedState:setStateName(stateName)
    self.stateName = stateName
end

function FlagUnlockedState:getCurrentStateName()
    return self.stateName
end
