ConsummableModule = Class()


ConsummableModule.fieldNames = {
    "consummable",
    "consummed",
    "onConsume",
}


function ConsummableModule:init(def)
    self.consummable = true
    self.consummed = false
    self.onConsume = def
end

function ConsummableModule:consumme(bool)
    self.consummed = bool
end

function ConsummableModule:isConsummed()
    return self.consummed
end
