local ui = require("Scripts/ui/ui")
local lovePlus = require("Scripts/lovePlus")

local screen = {}
screen.mt = {}

screen.mt.__index = function(t, key)
    return screen[key]
end

-- The below options is the emulated screen size
local emulateScreenWidth = 1920
local emulateScreenHeight = 1080
-- This should be a higher resolution, as it will more likely be shrunk down then grown

-- For smoother positions, use a Scale object
-- It takes a number between 0 and 1 and turns that into a pixel value
screen.Scale = {}
screen.Scale2 = {}
screen.Scale.mt = {}

screen.Scale.mt.__index = function(t, key)
    return screen.Scale[key]
end

-- Takes a number
function screen.Scale.new(val)
    if type(val) ~= "number" then return nil end
    val = val or 0
    newScale = {
        x = val,
        type="Scale"
    }
    setmetatable(newScale, screen.Scale.mt)
    return newScale
end

-- Takes two numbers or two Scales
function screen.Scale2.new(valX, valY)
    valX = valX or 0
    valY = valY or 0
    
    if type(valX) == "number" then
        -- do nothing
    elseif type(valX) == "table" and valX.type == "Scale" then
        valX = valX.x
    else
        return nil
    end

    if type(valY) == "number" then
        -- do nothing
    elseif type(valY) == "table" and valY.type == "Scale" then
        valY = valY.x
    else
        return nil
    end

    newScale = {
        x = valX,
        y = valY,
        type="Scale2"
    }
    setmetatable(newScale, screen.Scale.mt)
    return newScale
end

function screen.getTextureMultiple()
    local width, height = love.graphics.getDimensions()
    local result = math.min(math.floor(width/(defaultScreenWidth-16)),math.floor(height/(defaultScreenHeight-16)))
    return result
end

function screen.drawAtCenter(drawable, x, y, scaleX, scaleY, rotation)
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

return screen