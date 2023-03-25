require("../../Scripts/vital")

local defaultScreenWidth = 480
local defaultScreenHeight = 270

function getTextureMultiple()
    local width, height = love.graphics.getDimensions()
    local result = math.min(math.floor(width/(defaultScreenWidth-32)),math.floor(height/(defaultScreenHeight-32)))
    if result < 1 then return 1 else return result end
end

function pointInDrawable(pointX, pointY, drawable, x, y, rotation, scaleX, scaleY)
    local sX = scaleX or 1
    local sY = scaleY or 1
    local width = drawable:getWidth() * sX
    local height = drawable:getHeight() * sY
    local tX = x or 0
    local tY = y or 0
    local centerX = tX + width/2
    local centerY = tY + height/2
    local rot = rotation or 0
    local sinR = math.sin(rot)
    local cosR = math.cos(rot)
    local pX = pointX or 0
    local pY = pointY or 0
    local relX = pX - centerX
    local relY = pY - centerY
    local rotatedX = centerX + cosR*relX - sinR*relY
    local rotatedY = centerY + sinR*relX + cosR*relY
    return (rotatedX >= x and rotatedX <= x + width and
            rotatedY >= y and rotatedY <= y + height)
end

function mouseInDrawable(drawable, x, y, rotation, scaleX, scaleY)
    return pointInDrawable(love.mouse.getX(), love.mouse.getY(), drawable, x, y, rotation, scaleX, scaleY)
end

function drawAtCenter(drawable, x, y, scaleX, scaleY, rotation)
    local sX = scaleX or 1
    local sY = scaleY or 1
    local pass = {
        drawable,
        round(drawable:getWidth()/2*(-sX))+x,
        round(drawable:getHeight()/2*(-sY))+y,
        rotation,
        sX,
        sY,
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
