local defaultScreenWidth = 480-16
local defaultScreenHeight = 270-16

function getTextureMultiple()
    local width, height = love.graphics.getDimensions()
    return math.min(math.floor(width/defaultScreenWidth),math.floor(height/defaultScreenHeight))
end