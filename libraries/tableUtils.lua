function table.deepCopy(original)
    if type(original) ~= "table" then
        return original
    end

    local copy = {}
    for key, value in pairs(original) do
        copy[table.deepCopy(key)] = table.deepCopy(value)
    end

    return copy
end

-- Only works with arrays (keys are consecutive integers)
-- (ex: t = {1,2,3} works but t = {a=1,b=2,c=3} does not)
function table.indexOfValue(t, targetValue)
    for index, value in ipairs(t) do
        if value == targetValue then
            return index
        end
    end
end

-- Only works with arrays (keys are consecutive integers)
-- (ex: t = {1,2,3} works but t = {a=1,b=2,c=3} does not)
function table.removeByValue(t, string)
    table.remove(t, table.indexOfValue(t, string))
end
