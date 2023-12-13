AssetsManager = Class()

function AssetsManager:init()
    self.graphics = self.getGraphicsMethods()
    self.audio    = self.getAudioMethods()
    self.colors   = self.getColorsMethods()
    self.fonts    = self.getFontsMethods()
end

function AssetsManager.getGraphicsMethods()
    return {
        ["backgrounds"]       = function() return love.graphics.newImage("assets/graphics/backgrounds.png") end,
        ["blue_alien"]        = function() return love.graphics.newImage("assets/graphics/blue_alien.png") end,
        ["bushes_and_cacti"]  = function() return love.graphics.newImage("assets/graphics/bushes_and_cacti.png") end,
        ["buttons"]           = function() return love.graphics.newImage("assets/graphics/buttons.png") end,
        ["coins_and_bombs"]   = function() return love.graphics.newImage("assets/graphics/coins_and_bombs.png") end,
        ["creatures"]         = function() return love.graphics.newImage("assets/graphics/creatures.png") end,
        ["doors_and_windows"] = function() return love.graphics.newImage("assets/graphics/doors_and_windows.png") end,
        ["faces_and_hills"]   = function() return love.graphics.newImage("assets/graphics/faces_and_hills.png") end,
        ["fireballs"]         = function() return love.graphics.newImage("assets/graphics/fireballs.png") end,
        ["flags"]             = function() return love.graphics.newImage("assets/graphics/flags.png") end,
        ["full_sheet"]        = function() return love.graphics.newImage("assets/graphics/full_sheet.png") end,
        ["gems"]              = function() return love.graphics.newImage("assets/graphics/gems.png") end,
        ["green_alien"]       = function() return love.graphics.newImage("assets/graphics/green_alien.png") end,
        ["hearts"]            = function() return love.graphics.newImage("assets/graphics/hearts.png") end,
        ["jump_blocks"]       = function() return love.graphics.newImage("assets/graphics/jump_blocks.png") end,
        ["keys_and_locks"]    = function() return love.graphics.newImage("assets/graphics/keys_and_locks.png") end,
        ["ladders_and_signs"] = function() return love.graphics.newImage("assets/graphics/ladders_and_signs.png") end,
        ["mushrooms"]         = function() return love.graphics.newImage("assets/graphics/mushrooms.png") end,
        ["numbers"]           = function() return love.graphics.newImage("assets/graphics/numbers.png") end,
        ["pink_alien"]        = function() return love.graphics.newImage("assets/graphics/pink_alien.png") end,
        ["tile_tops"]         = function() return love.graphics.newImage("assets/graphics/tile_tops.png") end,
        ["tiles"]             = function() return love.graphics.newImage("assets/graphics/tiles.png") end,
        ["water"]             = function() return love.graphics.newImage("assets/graphics/water.png") end,
        ["tile"]              = function() return love.graphics.newImage("assets/graphics/tile.png") end,
    }
end

function AssetsManager.getAudioMethods()
    return {
        ["death"]          = function() return love.audio.newSource("assets/audio/death.wav", "static") end,
        ["empty_block"]    = function() return love.audio.newSource("assets/audio/empty_block.wav", "static") end,
        ["jump"]           = function() return love.audio.newSource("assets/audio/jump.wav", "static") end,
        ["kill"]           = function() return love.audio.newSource("assets/audio/kill.wav", "static") end,
        ["kill2"]          = function() return love.audio.newSource("assets/audio/kill2.wav", "static") end,
        ["music"]          = function() return love.audio.newSource("assets/audio/music.wav", "static") end,
        ["pickup"]         = function() return love.audio.newSource("assets/audio/pickup.wav", "static") end,
        ["powerup_reveal"] = function() return love.audio.newSource("assets/audio/powerup_reveal.wav", "static") end,
    }
end

function AssetsManager.getColorsMethods()
    return {
        setBlack  = function(alpha) love.graphics.setColor(0, 0, 0, alpha or 1) end,
        setWhite  = function(alpha) love.graphics.setColor(1, 1, 1, alpha or 1) end,
        setRed    = function(alpha) love.graphics.setColor(1, 0, 0, alpha or 1) end,
        setYellow = function(alpha) love.graphics.setColor(1, 1, 0, alpha or 1) end,
    }
end

function AssetsManager.getFontsMethods()
    local smallFont  = love.graphics.newFont("assets/fonts/font.ttf", 8)
    local mediumFont = love.graphics.newFont("assets/fonts/font.ttf", 16)
    local largeFont  = love.graphics.newFont("assets/fonts/font.ttf", 32)
    local titleFont  = love.graphics.newFont("assets/fonts/ArcadeAlternate.ttf", 32)

    return {
        setSmall  = function() love.graphics.setFont(smallFont) end,
        setMedium = function() love.graphics.setFont(mediumFont) end,
        setLarge  = function() love.graphics.setFont(largeFont) end,
        setTitle  = function() love.graphics.setFont(titleFont) end,
    }
end

return AssetsManager()
