-- Main Menu


local ui = require("Scripts/ui/ui")
local Gamestate = require("Scripts/hump/gamestate")
local flux = require("Scripts/ui/flux")
local PB = require("Scripts/ui/button")
local lovePlus = require("Scripts/love-plus")

local menu = {}

local delta
local textureMultiple

local dotSize = 5
local dotProgress = 0
local literalDotSize = 5
local comicSans
local menuTitle
local playButton
local playText
local playButtonTween = {scaleMod = 1}
local playButtonHover = false
local optionsButton
local optionsText
local optionsButtonTween = {scaleMod = 1}
local optionsButtonHover = false

local debugButton

function menu:init()
    comicSans = ui.getFont("ComicSans", "Bold", 15)
    versionText = love.graphics.newText(comicSans, ver)
    menuTitle = lovePlus.loadImage("Art/ui/title.png")
    playButton = lovePlus.loadImage("Art/ui/Buttons/1x8.png")
    playText = love.graphics.newText(comicSans, "Play")
    optionsButton = lovePlus.loadImage("Art/ui/Buttons/1x8.png")
    optionsText = love.graphics.newText(comicSans, "Options")
    debugButton = PB.createButton()
    debugButton:addCollider(PB.createCollider("rect", 100, 100, 100, 100))
    lovePlus.printTable(debugButton)
end

function menu:draw()
    delta = love.timer.getDelta()
    textureMultiple = ui.getTextureMultiple()

    comicSans = ui.getFont("ComicSans", "Bold", 15*textureMultiple)
    playText:setFont(comicSans)
    optionsText:setFont(comicSans)

    --Background Color
    local bg = lovePlus.rgb(255,229,232)
    love.graphics.setBackgroundColor(bg[1],bg[2],bg[3])

    literalDotSize = lovePlus.round(dotSize*textureMultiple)
    if literalDotSize < 5 then literalDotSize = 5 end
    if dotProgress >= 4 then
        dotProgress = dotProgress-4
    end
    dotProgress = dotProgress + 1 * delta
    for iY=dotProgress*literalDotSize, literalDotSize*2+love.graphics.getHeight(), literalDotSize*4 do
        love.graphics.setColor(1, 1, 1)
        for i=dotProgress*literalDotSize-literalDotSize*4, love.graphics.getWidth()+literalDotSize, literalDotSize*4 do
            love.graphics.circle("fill", i, -iY+love.graphics.getHeight()+literalDotSize, literalDotSize)
        end
    end

    love.graphics.setColor(1,1,1)
    --Title Text
    love.graphics.draw(ui.drawAtCenter(menuTitle, ui.screenXScale(0.5), ui.screenYScale(0.2), 0.1*textureMultiple, 0.1*textureMultiple))

    --Play Button
    if ui.mouseInDrawable(ui.drawAtCenter(playButton, ui.screenXScale(0.5), ui.screenYScale(0.5), 0.38*textureMultiple, 0.38*textureMultiple)) then
        if playButtonHover == false then
            playButtonHover = true
            flux.to(playButtonTween, 0.5, {scaleMod = 1.2}):ease("elasticout")
        end
    else
        if playButtonHover == true then
            playButtonHover = false
            flux.to(playButtonTween, 0.5, {scaleMod = 1}):ease("elasticout")
        end
    end
    love.graphics.draw(ui.drawAtCenter(playButton, ui.screenXScale(0.5), ui.screenYScale(0.5), 0.38*textureMultiple*playButtonTween.scaleMod, 0.38*textureMultiple*playButtonTween.scaleMod))
    love.graphics.draw(ui.drawAtCenter(playText, ui.screenXScale(0.5), ui.screenYScale(0.5),  playButtonTween.scaleMod, playButtonTween.scaleMod))

    --Options Button
    if ui.mouseInDrawable(ui.drawAtCenter(optionsButton, ui.screenXScale(0.5), ui.screenYScale(0.64), 0.38*textureMultiple, 0.38*textureMultiple)) then
        if optionsButtonHover == false then
            optionsButtonHover = true
            flux.to(optionsButtonTween, 0.5, {scaleMod = 1.2}):ease("elasticout")
        end
    else
        if optionsButtonHover == true then
            optionsButtonHover = false
            flux.to(optionsButtonTween, 0.5, {scaleMod = 1}):ease("elasticout")
        end
    end
    love.graphics.draw(ui.drawAtCenter(optionsButton, ui.screenXScale(0.5), ui.screenYScale(0.64), 0.38*textureMultiple*optionsButtonTween.scaleMod, 0.38*textureMultiple*optionsButtonTween.scaleMod))
    love.graphics.draw(ui.drawAtCenter(optionsText, ui.screenXScale(0.5), ui.screenYScale(0.64), optionsButtonTween.scaleMod, optionsButtonTween.scaleMod))
    
end

function menu:mousepressed()
    mouseX, mouseY = love.mouse.getPosition()
end

return menu