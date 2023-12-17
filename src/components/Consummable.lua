Consummable = Class()

function Consummable:init(def)
    self.consummable = true
    self.consummed = false
    self.consumme = Consummable.consumme
    self.OnConsume = def
end

function Consummable:consumme(bool)
    self.consummed = bool
end
