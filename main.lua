require("Scripts/menu")
Gamestate = require("Scripts/hump/gamestate")

local scribblesFont
local scribblesImage
local plrX = 0
local plrY = 0



function love.load()
    local cursor = love.mouse.newCursor("Art/Cursors/cursor.png", 0, 0)
    love.mouse.setCursor(cursor)

    Gamestate.registerEvents()
    Gamestate.switch(menu)
end