local console_toggle = require("console.console")
Gamestate = require("Scripts/hump/gamestate")
flux = require("Scripts/ui/flux")

require("Scenes/menu")

local plrX = 0
local plrY = 0

function love.load()
    print("\n")

    if love.mouse.isCursorSupported() then
        local cursor = love.mouse.newCursor("Art/ui/Cursors/cursor.png", 0, 0)
        love.mouse.setCursor(cursor)
    end

    Gamestate.registerEvents()
    Gamestate.switch(menu)
end

function love.draw()
    local delta = love.timer.getDelta()
    flux.update(delta)
end

function love.textinput(text)
    console_toggle(text)
end
