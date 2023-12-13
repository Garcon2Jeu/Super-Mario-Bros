require "src.dependencies"

function love.load()
    State = StateMachine {
        ["start"] = function() return StartState() end,
    }

    State:change("start")
end

function love.update(dt)
    State:update(dt)
    App:update()
end

function love.draw()
    State:draw()
end

function love.keypressed(key)
    App:pressKey(key)
end

function love.resize(w, h)
    Push:resize(w, h)
end
