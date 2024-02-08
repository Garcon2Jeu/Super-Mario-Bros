OverState = Class { __includes = BaseState }
OverState.stateName = "over"

function OverState:init()
    App:enableInput(true)
    Modules:plug(self, "Camera")
end

function OverState:enter(params)
    self.level = params.level
    self.cameraScroll = params.cameraScroll
end

function OverState:update(dt)
    if App:keyPressed("return") then
        State:change("start")
    end
end

function OverState:draw()
    self:scrollCamera()
    self.level.background:draw()
    self.level:draw()
    self:drawGameOverScreen()
end

function OverState:exit() end

function OverState:setStateName(stateName)
    self.stateName = stateName
end

function OverState:getCurrentStateName()
    return self.stateName
end

function OverState:drawGameOverScreen()
    Assets.colors.setBlack()
    Assets.fonts.setLarge()
    love.graphics.printf("GAME OVER", self.cameraScroll + 1, 51, VIRTUAL_WIDTH, "center")
    Assets.fonts.setMedium()
    love.graphics.printf("Press Enter", self.cameraScroll + 1, 81, VIRTUAL_WIDTH, "center")

    Assets.colors.setWhite()
    Assets.fonts.setLarge()
    love.graphics.printf("GAME OVER", self.cameraScroll, 50, VIRTUAL_WIDTH, "center")
    Assets.fonts.setMedium()
    love.graphics.printf("Press Enter", self.cameraScroll, 80, VIRTUAL_WIDTH, "center")

    Assets.colors.reset()
end
