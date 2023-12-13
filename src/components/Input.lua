Input = Class()

function Input:init()
    self.keysPressed = {}
    self.canInput = true
end

function Input:pressKey(key)
    if self.canInput then
        self.keysPressed[key] = true
    end

    return self.canInput
end

function Input:keyPressed(key)
    return self.keysPressed[key]
end

function Input:flushKeys()
    self.keysPressed = {}
end

function Input:enableInput(bool)
    self.canInput = bool
end
