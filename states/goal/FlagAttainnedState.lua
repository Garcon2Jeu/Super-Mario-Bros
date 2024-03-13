FlagAttainnedState = Class { __includes = BaseState }

FlagAttainnedState.stateName = "attainned"

function FlagAttainnedState:init(flag, goal)
    self.flag = flag

    Chain(
        function(next)
            Timer.tween(2, {
                [self.flag] = { y = goal.y + 3 }
            }):finish(next)
        end,
        function()
            State.current.level:toNextLevel()
        end
    )()
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
