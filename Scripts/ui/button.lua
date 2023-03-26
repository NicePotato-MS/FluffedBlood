require("ui")
require("flux")

local PB = {}

function PB.pbError(func, msg)
    local fnc = func or ""
    if fnc ~= "" then fnc = fnc.."(): " end
    assert("PotatoButton: "..fnc..msg)
end

function PB.createButton()
    return {
        colliders = {},
        visuals = {}
    }
end

function PB.createVisual()
    
end

function PB.createCollider()

end

function PB.createAnim(propertyTable, time, easeStyle) -- the 'propertyTable' argument comes from PB.createProperties()
    if type(propertyTable) ~= "table" then
        PB.pbError("createAnim()","passed value propertyTable: '"..propertyTable.."' is not a table")
        return false
    end
    local dur = time or 1
    local sty = easeStyle or "quadout" -- default easing style
    return {
        properties = propertyTable,
        duration = dur,
        style = sty
    }
end

function PB.createProperties(x,y,r,sx,sy) -- Beware! terrible code below
    local pass = {}
    if x ~= nil then pass["x"] = x end
    if y ~= nil then pass["y"] = y end
    if r ~= nil then pass["rotation"] = r end
    if sx ~= nil then pass["scaleX"] = sx end
    if sy ~= nil then pass["scaleY"] = sy end
    return pass
end

function PB.clicked(self) -- use in a love.mouseclicked function in an if statement
    if type(self) ~= "table" then
        PB.pbError("clicked()","passed value self: '"..self.."' is not a table")
        return false
    end
    if self["colliders"] == nil then
        PB.pbError("clicked","passed value self '"..self.."' does not contain 'colliders'")
        return false
    end
end

--[[
buttonStructure = {
    colliders = {
        {
            obj = "rectangle",
            --[return of PB.createProperties]
        }
    }
    visuals = {
        {
            anim = {
                enterHover = {
                    --[return of PB.createAnim()]
                }
                leaveHover = {
                    --[return of PB.createAnim()]
                }
                onClick = {
                    --[return of PB.createAnim()]
                }
            }
        }
    }
}
]]--
return PB