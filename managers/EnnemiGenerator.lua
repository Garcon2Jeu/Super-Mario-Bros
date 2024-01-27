EnnemiGenerator = Class()


local ennemiData = {
    countSpacer = 5,
    chance = 4,
    widthMin = 1,
    widthMax = 2,
}

function EnnemiGenerator:factory(level)
    local ennemisList = {}

    ennemiData.method =
        function(tileMap, columnIndex)
            EnnemiGenerator.addEnnemi(ennemisList, level, columnIndex)
        end

    BaseMapModule.randomlyTerraform(level.tileMap, ennemiData)

    return ennemisList
end

function EnnemiGenerator.addEnnemi(ennemisList, level, columnIndex)
    table.insert(ennemisList, Blob {
        x = level.tileMap[columnIndex][1].x,
        y = level.tileMap[columnIndex][1].y,
        level = level })
end
