App = Class()

function App:init()
    math.randomseed(os.time())
    self.setupWindow()

    Modules:plug(self, "Input", {})
end

function App:update()
    self:quit()
    self:flushKeys()
end

function App.setupWindow()
    love.window.setTitle("SMB - Project")
    love.graphics.setDefaultFilter("nearest", "nearest")
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resize = true,
        vsync = true
    })
end

function App:quit()
    if self:keyPressed("escape") then
        love.event.quit()
    end
end

function App.flipCoin(max)
    return math.random(max or 2) == 1
end

return App()
