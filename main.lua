require "src.dependencies"


function love.load()
    State = StateMachine {
        ["start"] = function() return StartState() end,
        ["play"] = function() return PlayState() end,
        ["over"] = function() return OverState() end,
    }

    State:change("start")

    Assets.audio["music"]:play()
    Assets.audio["music"]:setLooping(true)
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
