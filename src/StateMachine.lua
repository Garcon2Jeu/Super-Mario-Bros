StateMachine = Class()

function StateMachine:init(states)
    self.states = states
    self.current = BaseState()
    self.placeholder = nil
    self.debug = "base"
end

function StateMachine:change(stateName, enterParams)
    assert(self.states[stateName])
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(enterParams)
    self.debug = stateName
end

function StateMachine:update(dt)
    self.current:update(dt)
end

function StateMachine:draw()
    self.current:draw()
end
