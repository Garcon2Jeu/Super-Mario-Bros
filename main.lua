require "src.dependencies"

function love.load()
end

function love.update(dt)
    App:update()
end

function love.draw()
end

function love.keypressed(key)
    App:pressKey(key)
end

function love.resize(w, h)
    Push:resize(w, h)
end
