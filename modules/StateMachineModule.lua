StateMachineModule = Class()

function StateMachineModule:init(def)
    self.stateMachine = StateMachine(def)
end

function StateMachineModule:changeState(state, params)
    self.stateMachine:change(state, params)
end
