--- Convert between colorspaces

local colorspace = {}

local function clamp(a, min, max)
	return math.min(max, math.max(min, a))
end

--- Converts from HSL colorspace to RGB colorspace.
-- Additional arguments are passed through,
-- meaning this function doubles as a hsla2rgba converter.
function colorspace.hsl2rgb(h, s, l, ...)
	h, s, l = h % 360, clamp(s, 0, 1), clamp(l, 0, 1)
	local c = (1 - math.abs(2*l - 1)) * s
	local x = c * (1 - math.abs((h / 60) % 2 - 1))
	local m = l - c/2

	local r, g, b
	if h < 60 then
		r, g, b = c, x, 0
	elseif h < 120 then
		r, g, b = x, c, 0
	elseif h < 180 then
		r, g, b = 0, c, x
	elseif h < 240 then
		r, g, b = 0, x, c
	elseif h < 300 then
		r, g, b = x, 0, c
	else
		r, g, b = c, 0, x
	end

	return r+m, g+m, b+m, ...
end

return colorspace
