local Fonts = {} -- The table that holds all fonts
--Font Name
---Size
----Style

function getFont(name, style, size) -- very ugly
    if Fonts[name] == nil then Fonts[name] = {} end -- Create the font table if it doesn't exist
    if Fonts[name][size] == nil then Fonts[name][size] = {} end -- Create the size table if it doesn't exist
    if Fonts[name][size][style] ~= nil then return Fonts[name][size][style] end -- Check if font exists already
    local file = "Fonts/"..name.."/"..style..".ttf"
    if love.filesystem.getInfo(file) == nil then return nil end -- Check if the font exists
    Fonts[name][size][style] = love.graphics.newFont(file, size)
    return Fonts[name][size][style]
end