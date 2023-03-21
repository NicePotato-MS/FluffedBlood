-- Main Menu

require("Scripts/fonts")
require("Scripts/vital")
Gamestate = require("Scripts/hump/gamestate")

menu = {}

local delta

local dotSize = 0.01
local dotProgress = 0
local literalDotSize = 5
local comicSans
local menuTitle

function menu:init()
    comicSans = getFont("ComicSans", "Bold", 40)
    menuTitle = love.graphics.newImage("Art/ui/title.png")
    playButton = love.graphics.newImage("Art/ui/Buttons/1x8.png")
    playText = love.graphics.newText(comicSans, "Play")
    optionsButton = love.graphics.newImage("Art/ui/Buttons/1x8.png")
    optionsText = love.graphics.newText(comicSans, "Options")
end

function menu:draw()
    delta = love.timer.getDelta()

    --Background Color
    local bg = rgb(255,229,232)
    love.graphics.setBackgroundColor(bg[1],bg[2],bg[3])

    literalDotSize = round(love.graphics.getWidth()*dotSize)
    if literalDotSize < 5 then literalDotSize = 5 end
    if dotProgress >= 4 then
        dotProgress = dotProgress-4
    end
    dotProgress = dotProgress + 1 * delta
    for iY=dotProgress*literalDotSize, literalDotSize*2+love.graphics.getHeight(), literalDotSize*4 do
        love.graphics.setColor(1, 1, 1)
        drawDotRow(dotProgress*literalDotSize-literalDotSize*4,0-iY+love.graphics.getHeight()+literalDotSize, literalDotSize) 
    end

    --Title Text
    love.graphics.setColor(255,255,255)
    love.graphics.draw(menuTitle, round(love.graphics.getWidth()/2)-round(menuTitle:getWidth()/2) ,round(love.graphics.getHeight()/256))
    love.graphics.draw(playButton, round(love.graphics.getWidth()/2)-round(playButton:getWidth()*0.8/2),
        (round(love.graphics.getHeight())/2.1),
        0, 0.8)
    love.graphics.draw(playText, round(love.graphics.getWidth()/2)-round(playText:getWidth()*0.8/2),
        (round(love.graphics.getHeight())/2.1),
        0, 0.8)
    love.graphics.draw(optionsButton, round(love.graphics.getWidth()/2)-round(optionsButton:getWidth()*0.8/2),
        (round(love.graphics.getHeight())/1.6),
        0, 0.8)
    love.graphics.draw(optionsText, round(love.graphics.getWidth()/2)-round(optionsText:getWidth()*0.8/2),
        (round(love.graphics.getHeight())/1.6),
        0, 0.8)
    
end

function drawDotRow(x,y,size)
    for i=x, love.graphics.getWidth()+literalDotSize, literalDotSize*4 do
        love.graphics.circle("fill", i, y, size)
    end
end

function menu:mousepressed()
    mouseX, mouseY = love.mouse.getPosition()
end