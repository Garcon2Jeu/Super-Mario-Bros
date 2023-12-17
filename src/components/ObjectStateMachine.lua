ObjectStateMachine = Class()

function ObjectStateMachine:init(def)
    self.stateMachine = StateMachine(def)
end

function ObjectStateMachine:changeState(state, params)
    self.stateMachine:change(state, params)
end
