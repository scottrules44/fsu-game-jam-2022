--the game "engine"
local colors = require "modules.colors"
local physics = require "physics"
local settings = require "modules.settings"
local m ={}

--reset game here

--pause game here

m.start = function (scene)
  --create bg -toDo make more complex
  local bg = display.newRect(scene, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
  colors.setFillColor(bg, colors.gameSky)
  --borders to what is consider "off screen" (hide during build)
  local borderGroup = display.newGroup()
  local leftBorder = display.newRect(borderGroup, 0, display.contentCenterY, 5, display.contentHeight )
  local rightBorder = display.newRect(borderGroup, display.contentWidth, display.contentCenterY, 5, display.contentHeight )

  if settings.debug == false then
    borderGroup.alpha = 0
  end

  --start clouds
  

end



return m
