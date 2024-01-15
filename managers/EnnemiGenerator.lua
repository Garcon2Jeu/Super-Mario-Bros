EnnemiGenerator = Class()

function EnnemiGenerator:factory(level)
    return {
        Blob { x = 0, y = 0, level = level },
        Blob { x = 200, y = 0, level = level }
    }
end
