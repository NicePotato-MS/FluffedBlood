-- Main Menu

require("Scripts/vital")
require("Scripts/fonts")
require("Scripts/ui")
Gamestate = require("Scripts/hump/gamestate")


menu = {}

local delta

local dotSize = 5
local dotProgress = 0
local literalDotSize = 5
local comicSans
local menuTitle
local playButton
local playText
local optionsButton
local optionsText

local textureMultiple

function menu:init()
    comicSans = getFont("ComicSans", "Bold", 15)
    menuTitle = love.graphics.newImage("Art/ui/title.png")
    playButton = love.graphics.newImage("Art/ui/Buttons/1x8.png")
    playText = love.graphics.newText(comicSans, "Play")
    optionsButton = love.graphics.newImage("Art/ui/Buttons/1x8.png")
    optionsText = love.graphics.newText(comicSans, "Options")
end

function menu:draw()
    delta = love.timer.getDelta()
    textureMultiple = getTextureMultiple()

    comicSans = getFont("ComicSans", "Bold", 15*textureMultiple)

    --Background Color
    local bg = rgb(255,229,232)
    love.graphics.setBackgroundColor(bg[1],bg[2],bg[3])

    literalDotSize = round(dotSize*textureMultiple)
    if literalDotSize < 5 then literalDotSize = 5 end
    if dotProgress >= 4 then
        dotProgress = dotProgress-4
    end
    dotProgress = dotProgress + 1 * delta
    for iY=dotProgress*literalDotSize, literalDotSize*2+love.graphics.getHeight(), literalDotSize*4 do
        love.graphics.setColor(1, 1, 1)
        drawDotRow(dotProgress*literalDotSize-literalDotSize*4,0-iY+love.graphics.getHeight()+literalDotSize, literalDotSize) 
    end

    love.graphics.setColor(255,255,255)
    --Title Text
    love.graphics.draw(drawAtCenter(menuTitle, screenXScale(0.5), screenYScale(0.2), 0.1*textureMultiple, 0.1*textureMultiple))

    --Play Button
    love.graphics.draw(drawAtCenter(playButton, screenXScale(0.5), screenYScale(0.5), 0.38*textureMultiple, 0.38*textureMultiple))
    love.graphics.draw(drawAtCenter(playText, screenXScale(0.5), screenYScale(0.5), 1*textureMultiple, 1*textureMultiple))

    --Options Button
    love.graphics.draw(drawAtCenter(optionsButton, screenXScale(0.5), screenYScale(0.62), 0.38*textureMultiple, 0.38*textureMultiple))
    love.graphics.draw(drawAtCenter(optionsText, screenXScale(0.5), screenYScale(0.62), 1*textureMultiple, 1*textureMultiple))
    
end

function drawDotRow(x,y,size)
    for i=x, love.graphics.getWidth()+literalDotSize, literalDotSize*4 do
        love.graphics.circle("fill", i, y, size)
    end
end

function menu:mousepressed()
    mouseX, mouseY = love.mouse.getPosition()
end

