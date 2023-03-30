local lovePlus = require("Scripts/love-plus")

local ui = {}

local defaultScreenWidth = 480
local defaultScreenHeight = 270

function ui.getTextureMultiple()
    local width, height = love.graphics.getDimensions()
    local result = math.min(math.floor(width/(defaultScreenWidth-16)),math.floor(height/(defaultScreenHeight-16)))
    if result < 1 then return 1 else return result end
end

function ui.pointInRectangle(px, py, rx, ry, rw, rh, rr)
    -- Convert point to local space of rectangle
    local cosR = math.cos(-rr)
    local sinR = math.sin(-rr)
    local dx = px - rx
    local dy = py - ry
    local pxL = cosR * dx + sinR * dy
    local pyL = -sinR * dx + cosR * dy
    
    -- Check if point is inside local rectangle bounds
    return pxL >= -rw/2 and pxL <= rw/2 and pyL >= -rh/2 and pyL <= rh/2
end

function ui.mouseInRectangle(rx, ry, rw, rh, rr)
    return ui.pointInRectangle(love.mouse.getX(), love.mouse.getY(), rx, ry, rw, rh, rr)
end

function ui.pointInDrawable(pointX, pointY, drawable, x, y, rotation, scaleX, scaleY)
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

function ui.mouseInDrawable(drawable, x, y, rotation, scaleX, scaleY)
    return ui.pointInDrawable(love.mouse.getX(), love.mouse.getY(), drawable, x, y, rotation, scaleX, scaleY)
end

function ui.drawAtCenter(drawable, x, y, scaleX, scaleY, rotation)
    local sX = scaleX or 1
    local sY = scaleY or 1
    local pass = {
        drawable,
        lovePlus.round(drawable:getWidth()/2*(-sX))+x,
        lovePlus.round(drawable:getHeight()/2*(-sY))+y,
        rotation,
        sX,
        sY,
    }
    return unpack(pass)
end

function ui.screenXScale(x)
    local real = defaultScreenWidth*ui.getTextureMultiple()
    return lovePlus.round((love.graphics.getWidth()-real)/2+real*x)
end

function ui.screenYScale(y)
    local real = defaultScreenHeight*ui.getTextureMultiple()
    return lovePlus.round((love.graphics.getHeight()-real)/2+real*y)
end

function ui.drawTextWithStroke(text, x, y, r, g, b, strokeSize, width, height)
    local dx = {-1, 0, 1, 0}
    local dy = {0, -1, 0, 1}

    -- Draw the text with the stroke color
    love.graphics.setColor(r, g, b)
    love.graphics.draw(text, x, y, 0, width, height)

    -- Draw the text with the stroke effect
    love.graphics.setColor(0, 0, 0)
    for i = 1, strokeSize do
        for j = 1, 4 do
            love.graphics.draw(text, x + i * dx[j], y + i * dy[j], 0, width, height)
        end
    end
end


local Fonts = {} -- The table that holds all fonts
--Font Name
---Size
----Style

function ui.getFont(name, style, size) -- very ugly
    if Fonts[name] == nil then Fonts[name] = {} end -- Create the font table if it doesn't exist
    if Fonts[name][size] == nil then Fonts[name][size] = {} end -- Create the size table if it doesn't exist
    if Fonts[name][size][style] ~= nil then return Fonts[name][size][style] end -- Check if font exists already
    local file = "Fonts/"..name.."/"..style..".ttf"
    if love.filesystem.getInfo(file) == nil then return nil end -- Check if the font exists
    Fonts[name][size][style] = love.graphics.newFont(file, size)
    return Fonts[name][size][style]
end

return ui