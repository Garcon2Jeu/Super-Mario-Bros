CoinMapModule = Class()


CoinMapModule.fieldNames = {
    "coinMap",
    "coinIndices"
}


function CoinMapModule:init(baseMap)
    self.coinMap = baseMap
    self.coinIndices = {}
end

function CoinMapModule:drawCoinMap()
    for key, position in pairs(self.coinIndices) do
        if self.coinMap[position.column][position.row].modules then
            self.coinMap[position.column][position.row]:draw()
        end
    end
end

function CoinMapModule:spawnCoin(def)
    local coin = Coin(def)

    self.coinMap[def.column][def.row] = coin
    table.insert(self.coinIndices, { column = def.column, row = def.row })

    Timer.tween(.1, {
        [coin] = { y = coin.y - TILESIZE }
    })
end

function CoinMapModule:removeCoin(coin)
    self.coinMap[coin.column][coin.row] = { x = coin.x, y = coin.y }

    for index, position in ipairs(self.coinIndices) do
        if position.column == coin.column
            and position.row == coin.row then
            table.remove(self.coinIndices, index)
        end
    end
end
