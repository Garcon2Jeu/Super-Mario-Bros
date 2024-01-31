require "src.dependencies"


function love.load()
    State = StateMachine {
        ["play"] = function() return PlayState() end,
    }

    State:change("play")
end

function love.update(dt)
    Timer.update(dt)
    State:update(dt)
    App:update()
end

function love.draw()
    Push:start()
    State:draw()
    Push:finish()
end

function love.keypressed(key)
    App:pressKey(key)
end

function love.resize(w, h)
    Push:resize(w, h)
end
