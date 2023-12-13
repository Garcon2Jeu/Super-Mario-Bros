App = Class { __includes = InputComponent }

function App:init()
    math.randomseed(os.time())
    self.setupWindow()

    InputComponent.init(self)
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
        vsync = false
    })
end

function App:quit()
    if self:keyPressed("escape") then
        love.event.quit()
    end
end

return App()
