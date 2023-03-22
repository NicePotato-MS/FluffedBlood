require("Scripts/vital")

local defaultScreenWidth = 480
local defaultScreenHeight = 270

function getTextureMultiple()
    local width, height = love.graphics.getDimensions()
    local result = math.min(math.floor(width/(defaultScreenWidth-32)),math.floor(height/(defaultScreenHeight-32)))
    if result < 1 then return 1 else return result end
    hi
end

function drawAtCenter(drawable, x, y, scaleX, scaleY, rotation)
    local pass = {
        drawable,
        round(drawable:getWidth()/2*(0-scaleX))+x,
        round(drawable:getHeight()/2*(0-scaleY))+y,
        rotation,
        scaleX,
        scaleY,
    }
    return unpack(pass)
end

function screenXScale(x)
    local real = defaultScreenWidth*getTextureMultiple()
    return round((love.graphics.getWidth()-real)/2+real*x)
end

function screenYScale(y)
    local real = defaultScreenHeight*getTextureMultiple()
    return round((love.graphics.getHeight()-real)/2+real*y)
end
