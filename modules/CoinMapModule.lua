CoinMapModule = Class()

function CoinMapModule:init(baseMap)
    self.coinMap = baseMap
    self.coinIndices = {}

    self.coinMap[7][4] = Coin {
        x = self.coinMap[7][4].x,
        y = self.coinMap[7][4].y,
        column = 7,
        row = 4
    }
    table.insert(self.coinIndices, { column = 7, row = 4 })
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

    for key, position in pairs(self.coinIndices) do
        if position.column == coin.position
            and position.row == coin.row then
            self.coinIndices[position.column][position.row] = nil
        end
    end
end
