FlagLockedState = Class { __includes = BaseState }

FlagLockedState.stateName = "locked"

function FlagLockedState:setStateName(stateName)
    self.stateName = stateName
end

function FlagLockedState:getCurrentStateName()
    return self.stateName
end
