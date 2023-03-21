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
  