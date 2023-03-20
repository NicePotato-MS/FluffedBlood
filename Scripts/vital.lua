function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function rgb(r,g,b)
    return {r/255, g/255, b/255}
end