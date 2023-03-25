require("ui")
require("flux")

local buttons = {}

testButton = {
    colliders = {
        rectangleExample = {
            obj = "rectangle",
            properties = {
                x = 0,
                y = 0,
                rotation = 0,
                scaleX = 100,
                scaleY = 100
            }
        }
    },
    visuals = {
        imageExample = {
            obj = love.graphics.newImage("Art/ui/Buttons/1x8.png"),
            properties = {
                x = 0,
                y = 0,
                rotation = 0,
                scaleX = 1,
                scaleY = 1
            },
            anim = {
                toStart = {
                    properties = {
                        x = 0,
                        y = 0,
                        rotation = 0,
                        scaleX = 1
                        scaleY = 1
                    },
                    duration = 0.5,
                    style = "elasticout"
                },
                toFinish = {
                    properties = {
                        x = 0,
                        y = 0,
                        rotation = 0,
                        scaleX = 1.2,
                        scaleY = 1.2
                    },
                    duration = 0.5,
                    style = "elasticout"
                }
            }
        }
    }
}

-- Theoretically you can set a variable to a string and use 'var:createButton()' but this is not recommended 
function createButton(self) -- self is a string that is the button identifier
    if self == nil then return end

end

function destroyButton(self) -- self is a string that is the button identifier
    if self == nil then return end
    self == nil
end

function clearButtons()
    buttons = {}
end

0