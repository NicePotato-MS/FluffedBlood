local lovePlus = {}
lovePlus.mt = {}

lovePlus.version = 1

local giveErr

lovePlus.mt.__index = function(_, key)
    return lovePlus[key]
end

local function errorWithCheck(msg)
    if giveErr == true then
        love.errorhandler(msg)
    end
end

function lovePlus.getDrawableType(drawable, giveError)
    giveErr = giveError or true
    if not drawable then
        errorWithCheck("getDrawableType(): argument is nil")
        return "Unknown"
    end

    if not drawable.typeOf then

        errorWithCheck("getDrawableType(): argument has no typeOf() method")
        return "Unknown"
    end

    if drawable:typeOf("Image") then
        return "Image"
    elseif drawable:typeOf("Canvas") then
        return "Canvas"
    elseif drawable:typeOf("ParticleSystem") then
        return "ParticleSystem"
    elseif drawable:typeOf("SpriteBatch") then
        return "SpriteBatch"
    elseif drawable:typeOf("Text") then
        return "Text"
    elseif drawable:typeOf("Mesh") then
        return "Mesh"
    elseif drawable:typeOf("Video") then
        return "Video"
    elseif drawable:typeOf("Shader") then
        return "Shader"
    elseif drawable:typeOf("Framebuffer") then
        return "Framebuffer"
    elseif drawable:typeOf("Texture") then
        return "Texture"
    elseif drawable:typeOf("MeshData") then
        return "MeshData"
    elseif drawable:typeOf("BezierCurve") then
        return "BezierCurve"
    elseif drawable:typeOf("LineChain") then
        return "LineChain"
    elseif drawable:typeOf("Points") then
        return "Points"
    else
        errorWithCheck("getDrawableType(): unsupported drawable type")
        return "Unknown"
    end
end

function lovePlus.loadImage(filename, giveError)
    giveErr = giveError or true
    if love.filesystem.getInfo(filename) then
        return love.graphics.newImage(filename)
    else
        love.errorhandler("Could not load image: " .. filename)
        return nil
    end
end


function lovePlus.lerp(a, b, t)
    return a + (b - a) * t
end

function lovePlus.clamp(x, min, max)
    return math.min(math.max(x, min), max)
end

function lovePlus.round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function lovePlus.rgb(r,g,b)
    return {r/255, g/255, b/255}
end

function lovePlus.pointWithin(x, y, x1, y1, x2, y2)
    local minX = math.min(x1, x2)
    local maxX = math.max(x1, x2)
    local minY = math.min(y1, y2)
    local maxY = math.max(y1, y2)
    if x >= minX and x <= maxX and y >= minY and y <= maxY then
        return true
    else
        return false
    end
end

function lovePlus.printTable(tbl, max)
    max = max or 16 -- maximum the function will go before overflowing
    local depth = 1 -- default depth is 1
    local indent = string.rep("  ", depth - 1) -- indentation for current depth

    for k, v in pairs(tbl) do
        if depth >= max then
            print(indent.."...(overflow)")
            return
        end
        if type(v) == "table" and depth > 0 then
            if next(v) == nil then
                print(indent..k.." = {}")
            else
                print(indent..k.." = {")
                lovePlus.printTable(v, depth + 1)
                print(indent.."}")
            end
        elseif type(v) == "string" then
            print(indent..k..' = "'..v..'"')
        else
            print(indent..k.." = "..tostring(v))
        end
    end
end

function lovePlus.duplicateValue(value)
    local valueType = type(value)
    local copyValue

    if valueType == "table" then
        copyValue = {}
        for key, val in pairs(value) do
            copyValue[lovePlus.duplicateValue(key)] = lovePlus.duplicateValue(val)
        end
    elseif valueType == "function" then
        -- Functions cannot be copied in Lua, so we return nil for them
        copyValue = nil
    else
        copyValue = value
    end
    return copyValue
end

return lovePlus