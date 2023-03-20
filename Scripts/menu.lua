-- Main Menu

require("Scripts/fonts")
require("Scripts/vital")
Gamestate = require("Scripts/hump/gamestate")

menu = {}

local dotSize = 0.03
local dotProgress = 0
local comicSans
local menuTitle

function menu:init()
    comicSans = getFont("ComicSans", "Bold", 80)
    menuTitle = love.graphics.newText(comicSans, {{1,0,0},"Fluffed Blood"})
end

function menu:draw()
    local bg = rgb(255,229,232)
    love.graphics.setBackgroundColor(bg[1],bg[2],bg[3])
    love.graphics.draw(menuTitle, round(love.graphics.getWidth()/2)-round(menuTitle:getWidth()/2) ,round(love.graphics.getHeight()/8))
    local literalDotSize = round(love.graphics.getWidth()*dotSize)
    if dotProgress == 1 then
        dotProgress = 0
    else
        dotProgress +=
    love.graphics.circle("fill", 100, 100, literalDotSize)
end
