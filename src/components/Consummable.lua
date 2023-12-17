Consummable = Class()

function Consummable:init(def)
    self.consummable = true
    self.consummed = false
    self.onConsume = def
end

function Consummable:consumme(bool)
    self.consummed = bool
end

function Consummable:isConsummed()
    return self.consummed
end
