App = Class()

function App:init()
    math.randomseed(os.time())
    self.setupWindow()

    ModuleManager:plug(self, "Input", {})
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

function App:deepCopy(original)
    if type(original) ~= "table" then
        return original
    end

    local copy = {}
    for key, value in pairs(original) do
        copy[self:deepCopy(key)] = self:deepCopy(value)
    end

    return copy
end

return App()
