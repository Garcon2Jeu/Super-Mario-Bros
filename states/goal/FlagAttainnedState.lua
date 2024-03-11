FlagAttainnedState = Class { __includes = BaseState }

FlagAttainnedState.stateName = "base"

function FlagAttainnedState:init(flag)
    self.flag = flag

    Timer.tween(2, {
        [self.flag] = { y = self.flag.y - 30 }
    })
end

function FlagAttainnedState:update(dt)
    self.flag:setQuad(self.flag:getCurrentFrame())
end

function FlagAttainnedState:draw()
    self.flag:draw()
end

function FlagAttainnedState:exit()
    self.flag:removeTimer()
end

function FlagAttainnedState:setStateName(stateName)
    self.stateName = stateName
end

function FlagAttainnedState:getCurrentStateName()
    return self.stateName
end
