require("Scripts/Scenes/menu")
Gamestate = require("Scripts/hump/gamestate")

local plrX = 0
local plrY = 0



function love.load()
    
    local cursor = love.mouse.newCursor("Art/ui/Cursors/cursor.png", 0, 0)
    love.mouse.setCursor(cursor)

    Gamestate.registerEvents()
    Gamestate.switch(menu)
end

