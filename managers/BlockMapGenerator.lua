BlockMapGenerator = Class()

local jumpBlockData = {
    countSpacer = 7,
    chance      = 7,
    widthMin    = 1,
    widthMax    = 2,
}

local blockMaxHeight = 2
local blockGroundSpacer = 3

function BlockMapGenerator:factory(def)
    jumpBlockData.method =
        function(blockMap, columnIndex)
            BlockMapGenerator.addBlock(blockMap, columnIndex, def.tileMap)
        end

    BaseMapModule.randomlyTerraform(def.baseMap, jumpBlockData)

    return def.baseMap
end

function BlockMapGenerator.addBlock(blockMap, columnIndex, tileMap)
    for rowIndex = blockMaxHeight, #tileMap[columnIndex] do
        if Modules:find(tileMap[columnIndex][rowIndex], "Collidable") then
            rowIndex = rowIndex - blockGroundSpacer

            if rowIndex < blockMaxHeight then
                return
            end

            blockMap[columnIndex][rowIndex] = JumpBlock {
                x = tileMap[columnIndex][rowIndex].x,
                y = tileMap[columnIndex][rowIndex].y,
                column = columnIndex,
                row = rowIndex
            }
            return
        end
    end
end
