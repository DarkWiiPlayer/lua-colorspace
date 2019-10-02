--- Convert between colorspaces

local colorspace = {}

local function clamp(a, min, max)
	return math.min(max, math.max(min, a))
end

local function nmax(fn, ...)
  local n, max = 0, -fn(-math.huge, math.huge)
  for i=1,select('#', ...) do
    local value = select(i, ...)
    if value==fn(value, max) then
      max = value
      n = i
    end
  end
  return n, max
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

--- Converts from RGB colorspace to HSL colorspace.
-- Additional arguments are passed through,
-- meaning this function doubles as a rgba2hsla converter.
function colorspace.rgb2hsl(r, g, b, ...)
  local h, s, l
  r, g, b = clamp(r, 0, 1), clamp(g, 0, 1), clamp(b, 0, 1)
  local imax, max = nmax(math.max, r, g, b)
  local    _, min = nmax(math.min, r, g, b)
  local delta = max-min

  l = (max + min) / 2

  if delta == 0 then
    h = 0
  elseif imax == 1 then
    h = 60 * ((g-b) / delta % 6)
  elseif imax == 2 then
    h = 60 * ((b-r) / delta + 2)
  elseif imax == 3 then
    h = 60 * ((r-g) / delta + 4)
  else
    error('this code should be unreachable')
  end

  if delta > 0 then
    s = delta / (1 - math.abs(2*l - 1))
  else
    s = 0
  end

  return h, s, l, ...
end

return colorspace
