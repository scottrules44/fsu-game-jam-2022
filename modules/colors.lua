--Put all Colors and Functions

local m ={}
--methods
m.setFillColor = function (obj, color)
  obj:setFillColor(color[1], color[2], color[3], color[4])
end

--[[
Color 0-1, rgba
]]--

--Sky BG (might replace with image)
m.sky = {188/255,200/255,198/255,1}

m.gameSky = {115/255, 147/255, 179/255,1}

--title

m.title = {0,0,1, .5}

--water drop

m.drop = {0,0,1, .7}

--

return m
