CoinMap = Class()

function CoinMap:init()
    self.coinMap = {}
end

function CoinMap:drawCoinMap()
    for key, coin in pairs(self.coinMap) do
        coin:draw()
    end
end

function CoinMap:spawnCoin(x, y)
    local coin = Coin { x = x, y = y }

    Timer.tween(.1, {
        [coin] = { y = coin.y - TILESIZE }
    })

    table.insert(self.coinMap, coin)
end
