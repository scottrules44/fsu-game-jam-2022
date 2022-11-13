--the game "engine"
local colors = require "modules.colors"
local physics = require "physics"
local settings = require "modules.settings"
local m ={}

--"global" game vars
local gameTimer
local drop
local dropMoveTimer
local scoreTimer
--reset game here

--pause game here

--handle input
local moveTimer
local function startDropMove(type)
  local moveAmount
  if(type == "left")then
    moveAmount = -3
  elseif(type == "right")then
    moveAmount = 3
  end
  if(moveTimer == nil)then
    moveTimer = timer.performWithDelay( 10,function  ()
      drop.x = drop.x + moveAmount
    end ,-1 )
  end



end
local function stopDropMove(type)
  if(moveTimer)then
    timer.cancel( moveTimer )
    moveTimer = nil
  end
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





m.start = function (scene)
  --physics
  physics.start()
  physics.setGravity( 0, 0 )

  --pre declare
  math.randomseed( os.time() )
  local regBg = display.newGroup()

  --create bg -toDo make more complex
  scene:insert(regBg)
  local bg = display.newImageRect(regBg, settings.assetsDir.."skybackground.png", display.actualContentWidth, display.actualContentHeight )
  bg.x, bg.y = display.contentCenterX, display.contentCenterY
  bg.xOrg, bg.yOrg = bg.x, bg.y

  --borders to what is consider "off screen" (hide during build)
  local borderGroup = display.newGroup()
  scene:insert(borderGroup)
  local topBorder = display.newRect(borderGroup, display.contentCenterX, -40, display.contentWidth, 20 )
  physics.addBody( topBorder, "static" )
  topBorder.isSensor = true
  topBorder.name = "topBorder"
  local leftBorder = display.newRect(borderGroup, 0-20, display.contentCenterY, 50, display.contentHeight )
  physics.addBody( leftBorder, "static" )
  local rightBorder = display.newRect(borderGroup, display.contentWidth+20, display.contentCenterY, 50, display.contentHeight )
  physics.addBody( rightBorder, "static" )
  if settings.debug == false then
    borderGroup.alpha = 0
  end
  local score = 0
  local scoreDisplay = display.newText(regBg, "Score: " .. tostring(score), display.contentCenterX + 35, display.contentCenterY - 120, 100, 100)
  scoreDisplay.alpha = 0
  local function scoreUpdate( event )
      score = score + 1
      scoreDisplay.text = "Score: " .. tostring(score)
  end
  --game over screen

  --start clouds
  local cloud = display.newImageRect(settings.assetsDir.."cloud1.png", 128, 71)
  cloud.x, cloud.y = display.contentCenterX, 40
  cloud.xOrg, cloud.yOrg = cloud.x, cloud.y

  --water drop
  local dropScaler = .5
  local dropVerts = {25*dropScaler,0*dropScaler, 10*dropScaler,30*dropScaler, 15*dropScaler,40*dropScaler, 25*dropScaler,50*dropScaler, 35*dropScaler,40*dropScaler, 40*dropScaler,30*dropScaler }
  drop = display.newPolygon( scene,cloud.x, cloud.y, dropVerts ) -- this should be changed to image
  physics.addBody( drop, "dynamic" )
  colors.setFillColor(drop, colors.drop)
  drop.name = "drop"
  drop.collision = function (self, event)
    if event.other.name == "topBorder" then
        if ( event.phase == "began" ) then
          timer.cancel( scoreTimer )
          timer.cancel( leafTimer )
          timer.cancel( gameTimer )
          Runtime:removeEventListener( "key", onKeyEvent )
        end
    end
  end
  drop:addEventListener( "collision" )
  --obstacles
  local obstacleDG = display.newGroup()
  local function spawnLeaf()
    leaf = display.newImageRect(obstacleDG, settings.assetsDir.."leaf1.png", 60, 40) --no idea what these parameters are lol
    leaf.x, leaf.y = math.random(display.actualContentWidth), display.actualContentHeight
    leaf.name = "obstacle"
    physics.addBody( leaf, "static", {radius = 20} )

  end

  --start up game
  local function startGame(leaf)
    Runtime:addEventListener( "key", onKeyEvent )
    scoreDisplay.alpha = 1
    scoreTimer = timer.performWithDelay(500, scoreUpdate, -1)
    leafTimer = timer.performWithDelay(500, spawnLeaf, -1)
    gameTimer = timer.performWithDelay(1, function (args)
      for i=1,obstacleDG.numChildren do
        local obstacle = obstacleDG[i]
        if(obstacle and obstacle.y < -40)then -- clean up obstacle
          display.remove(obstacle)

        elseif(obstacle)then
          obstacle.y = obstacle.y-3
        end
      end


    end, -1 )
  end
  transition.to(cloud, {time=2000, y=-50, alpha=0, onComplete=startGame  })


end



return m
