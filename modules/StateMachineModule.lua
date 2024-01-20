StateMachineModule = Class()


StateMachineModule.fieldNames = {
    "stateMachine",
}


function StateMachineModule:init(def)
    self.stateMachine = StateMachine(def)
end

function StateMachineModule:changeState(state, params)
    self.stateMachine:change(state, params)
end

-- Description
---- Returns whether current stateName matches provided name,
---- else returns stateName
-- Optionnal
---- name = string variable
function StateMachineModule:getCurrentStateName(name)
    return not name and self.stateMachine.current:getCurrentStateName()
        or name == self.stateMachine.current:getCurrentStateName()
end
