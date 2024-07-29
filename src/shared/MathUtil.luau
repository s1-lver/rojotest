local MathUtil = {}

function MathUtil.Lerp(a, b, c)
    return a + (b - a) * c
end

return MathUtil