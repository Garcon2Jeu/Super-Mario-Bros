StartState           = Class { __includes = BaseState }

StartState.stateName = "base"

function StartState:init()
    self.level = Level()
end

function StartState:update(dt)
    if App:keyPressed("return") then
        State:change("play")
    end
end

function StartState:draw()
    self.level.background:draw()
    self:drawTitles()
end

function StartState:enter() end

function StartState:exit() end

function StartState:setStateName(stateName)
    self.stateName = stateName
end

function StartState:getCurrentStateName()
    return self.stateName
end

function StartState:drawTitles()
    Assets.fonts.setTitle()
    Assets.colors.setBlack()
    love.graphics.printf("Super GD50 Bros.", 1, VIRTUAL_HEIGHT / 4 + 1, VIRTUAL_WIDTH, "center")
    Assets.fonts.setMedium()
    love.graphics.printf("Press Enter", 1, VIRTUAL_HEIGHT / 4 + 76, VIRTUAL_WIDTH, "center")

    Assets.fonts.setTitle()
    Assets.colors.setWhite()
    love.graphics.printf("Super GD50 Bros.", 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, "center")
    Assets.fonts.setMedium()
    love.graphics.printf("Press Enter", 0, VIRTUAL_HEIGHT / 4 + 75, VIRTUAL_WIDTH, "center")
end
