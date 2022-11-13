--the game "engine"
local colors = require "modules.colors"
local physics = require "physics"
local settings = require "modules.settings"
local m ={}

--"global" game vars
local gameTimer
local drop
local dropMoveTimer

--reset game here

--pause game here

--handle input
local function startDropMove(type)
  local moveAmount
  if(type == "left")then
    moveAmount = -20
  elseif(type == "right")then
    moveAmount = 20
  end
  drop.x = drop.x + moveAmount

end
local function stopDropMove(type)

end
local function onKeyEvent( event )

    if ( event.phase == "down" ) then -- handle down keys only
        if(event.keyName == "left" or event.keyName == "right" and dropMoveTimer == nil) then
          startDropMove(event.keyName)
          return true
        end
    end
    if ( event.phase == "up" ) then -- handle up keys only
      if(event.keyName == "left" or event.keyName == "right") then
        stopDropMove(event.keyName)
        return true
      end
    end
    return false -- we have not handled this key
end

-- Add the key event listener
Runtime:addEventListener( "key", onKeyEvent )

m.start = function (scene)
  --physics
  physics.start()
  --pre declare
  math.randomseed( os.time() )
  local regBg = display.newGroup()
  local movingBg = display.newGroup()
  local function startMovingBg ()
    --[[gameTimer = timer.performWithDelay( 10, function (args)
      movingBg.y = movingBg.y-1
    end, -1 )]]--
  end
  --create bg -toDo make more complex
  scene:insert(regBg)
  scene:insert(movingBg)
  local bg = display.newRect(regBg, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
  colors.setFillColor(bg, colors.gameSky)
  --borders to what is consider "off screen" (hide during build)
  local borderGroup = display.newGroup()
  scene:insert(borderGroup)
  local leftBorder = display.newRect(borderGroup, 0, display.contentCenterY, 5, display.contentHeight )
  local rightBorder = display.newRect(borderGroup, display.contentWidth, display.contentCenterY, 5, display.contentHeight )

  if settings.debug == false then
    borderGroup.alpha = 0
  end

  --start clouds
  local cloud = display.newImageRect(settings.assetsDir.."cloud1.png", 128, 71)
  cloud.x, cloud.y = display.contentCenterX, 40
  cloud.xOrg, cloud.yOrg = cloud.x, cloud.y
  transition.to(cloud, {time=2000, y=-50, alpha=0, onComplete=startMovingBg  })
  --water drop
  local dropScaler = .5
  local dropVerts = {25*dropScaler,0*dropScaler, 10*dropScaler,30*dropScaler, 15*dropScaler,40*dropScaler, 25*dropScaler,50*dropScaler, 35*dropScaler,40*dropScaler, 40*dropScaler,30*dropScaler }
  drop = display.newPolygon( scene,cloud.x, cloud.y, dropVerts ) -- this should be changed to image
  physics.addBody( drop, "static" )
  colors.setFillColor(drop, colors.drop)
  --obstacles
  local obstacle_height = 30
  local function spawnLeaf()
    leaf = display.newImageRect(movingBg, settings.assetsDir.."leaf1.png", 128, 71) --no idea what these parameters are lol
    leaf.x, leaf.y = math.random(display.actualContentWidth), display.actualContentHeight
    leaf.xOrg, leaf.yOrg = leaf.x, leaf.y
  end


  leafTimer = timer.performWithDelay(2000, spawnLeaf, -1)


end



return m
