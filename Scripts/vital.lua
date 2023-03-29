function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function rgb(r,g,b)
    return {r/255, g/255, b/255}
end

function pointWithin(x, y, x1, y1, x2, y2)
    local minX = math.min(x1, x2)
    local maxX = math.max(x1, x2)
    local minY = math.min(y1, y2)
    local maxY = math.max(y1, y2)
    if x >= minX and x <= maxX and y >= minY and y <= maxY then
        return true
    else
        return false
    end
end

function printTable(tbl, depth)
    depth = depth or 1 -- default depth is 1
    local indent = string.rep("  ", depth - 1) -- indentation for current depth

    for k, v in pairs(tbl) do
        if type(v) == "table" and depth > 0 then
            print(indent .. k .. " = {")
            printTable(v, depth + 1)
            print(indent .. "}")
        else
            print(indent .. k .. " = " .. tostring(v))
        end
    end
end

function seperate_by_newlines(strings)
    local result = {}
    for key, value in pairs(strings) do
      if type(value) == "table" then
        result[key] = seperate_by_newlines(value)
      else
        local subresult = {}
        for line in string.gmatch(value, "[^\n]+") do
          table.insert(subresult, line)
        end
        result[key] = subresult
      end
    end
    return result
  end
  