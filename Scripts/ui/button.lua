require("Scripts/ui/ui")
require("Scripts/ui/flux")

local PB = {}

PB.mt = {}

PB.mt.__index = function (table, key)
    return PB[key]
end

function PB.pbError(func, msg)
    local fnc = func or ""
    if fnc ~= "" then fnc = fnc.."(): " end
    love.errorhandler("PotatoButton: "..fnc..msg)
end

function PB.createButton()
    local pass = {
        colliders = {},
        visuals = {}
    }
    setmetatable(pass, PB.mt)
    return pass
end

function PB.createVisual()
    
end


function PB:addCollider(collider)
    if type(self) ~= "table" then
        PB.pbError("addCollider","passed value self: '"..self.."' is not a table")
        return false
    end
    if type(collider) ~= "table" then
        PB.pbError("addCollider","passed value collider: '"..collider.."' is not a table")
        return false
    end
    if self["colliders"] == nil then
        PB.pbError("addCollider","passed value self '"..self.."' does not contain 'colliders'")
        return false
    end

    self.colliders[#self.colliders+1] = collider
end

function PB.createCollider(obj, x, y, arg1, arg2, arg3)
    --[[
    Rectangle
    -obj = "rect" or "rectangle"
    -x
    -y
    -arg1 = width
    -arg2 = height
    -arg3 = rotation
    ]]--

    if obj == "rect" or obj == "rectangle" then
        local px = x or 0
        local py = y or 0
        local sX = arg1 or 1
        local sY = arg2 or 1
        local r = arg3 or 0
        return {
            obj = "rect",
            properties = {
                x = px,
                y = py,
                rotation = r,
                scaleX = sX,
                scaleY = sY
            }
        }
    else
        PB.pbError("createCollider","obj '"..obj.."' is not a known type")
        return
    end
end

function PB.createAnim(propertyTable, time, easeStyle) -- the 'propertyTable' argument comes from PB.createProperties()
    if type(propertyTable) ~= "table" then
        PB.pbError("createAnim","passed value propertyTable: '"..propertyTable.."' is not a table")
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

function PB:clicked() -- use in a love.mouseclicked function in an if statement
    if type(self) ~= "table" then
        PB.pbError("clicked","passed value self: '"..self.."' is not a table")
        return false
    end
    if self["colliders"] == nil then
        PB.pbError("clicked","passed value self '"..self.."' does not contain 'colliders'")
        return false
    end

    for k, v in pairs(self.colliders) do
        local p = v.properties
        if v.obj == "rect" then
            if mouseInRectangle(p.x, p.y, p.scaleX, p.scaleY, p.rotation) then return true end
        else
            PB.pbError("clicked","collider is not a recognized type")
            return false
        end
    end
    return false
end

--[[
buttonStructure = {
    colliders = {
        {
            obj = "rect",
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