InputComponent = Class()

function InputComponent:init()
    self.keysPressed = {}
    self.canInput = true
end

function InputComponent:pressKey(key)
    if self.canInput then
        self.keysPressed[key] = true
    end

    return self.canInput
end

function InputComponent:keyPressed(key)
    return self.keysPressed[key]
end

function InputComponent:flushKeys()
    self.keysPressed = {}
end

function InputComponent:enableInput(bool)
    self.canInput = bool
end
