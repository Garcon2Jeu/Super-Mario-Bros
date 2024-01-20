InputModule = Class()


InputModule.fieldNames = {
    "keysPressed",
    "canInput"
}


function InputModule:init()
    self.keysPressed = {}
    self.canInput = true
end

function InputModule:pressKey(key)
    if self.canInput then
        self.keysPressed[key] = true
    end

    return self.canInput
end

function InputModule:keyPressed(key)
    return self.keysPressed[key]
end

function InputModule:flushKeys()
    self.keysPressed = {}
end

function InputModule:enableInput(bool)
    self.canInput = bool
end
