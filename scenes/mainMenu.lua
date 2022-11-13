--This is main menu

local composer = require( "composer" )
local colors = require "modules.colors"
local settings = require "modules.settings"
---
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view

    --menu
    local bg = display.newImageRect(sceneGroup, settings.assetsDir.."skybackground.png", display.actualContentWidth, display.actualContentHeight )
  bg.x, bg.y = display.contentCenterX, display.contentCenterY
  bg.xOrg, bg.yOrg = bg.x, bg.y

    local title = display.newText(sceneGroup, settings.title, display.contentCenterX, 40, native.systemFontBold, 40)
    colors.setFillColor(title, colors.title)
    --play button
    local playButton = display.newGroup()
    sceneGroup:insert(playButton)
    local playBg = display.newRoundedRect(playButton, display.contentCenterX, display.contentCenterY, 200, 50, 20 )
    local playTxt = display.newText(playButton, "Play", playBg.x, playBg.y, native.systemFont, 20)
    colors.setFillColor(playTxt, colors.title)

    playBg:addEventListener("touch", function(e)
      local self = e.target

      if(e.phase == "began")then
        self.alpha = .3
      elseif(e.phase == "ended")then
        composer.gotoScene( "scenes.gameScene", "fade" )
        self.alpha = 1
      end
    end)
    --high score
    local highScoreDisplay = display.newText(sceneGroup, "High Score: " .. tostring(settings.highScore), playBg.x, playBg.y -50, native.systemFont, 20)
    colors.setFillColor(highScoreDisplay, colors.title)
    --how to play
    local howToPlay1 = display.newText(sceneGroup, "How to play:", display.contentCenterX, display.actualContentHeight-70, native.systemFontBold, 14)
    local howToPlay2 = display.newText(sceneGroup, "Use left and right arrow key to control leaf and avoid leafs", display.contentCenterX, display.actualContentHeight-50, native.systemFontBold, 14)
    colors.setFillColor(howToPlay1, colors.title)
    colors.setFillColor(howToPlay2, colors.title)
    --about text
    local about = display.newText(sceneGroup, "Created for DevLUP 2022 Game Jam (Scott, Sky, Jamie)", display.contentCenterX, display.actualContentHeight-20, native.systemFont, 12)
    colors.setFillColor(about, colors.title)

end



-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
-- -----------------------------------------------------------------------------------

return scene
