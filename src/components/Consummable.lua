Consummable = Class()

function Consummable:init(def)
    self.consummable = true
    self.consummed = false
    self.OnConsume = def
end
