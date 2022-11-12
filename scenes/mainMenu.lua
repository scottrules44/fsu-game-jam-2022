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
    local bg = display.newRect(sceneGroup,  display.contentCenterX, display.contentCenterY, display.actualContentWidth,display.actualContentHeight )
    colors.setFillColor(bg, colors.sky)

    local title = display.newText(sceneGroup, settings.title, display.contentCenterX, 40, native.systemFontBold, 40)
    colors.setFillColor(title, colors.title)
    --play button
    local playButton = display.newGroup()
    sceneGroup:insert(playButton)
    local playBg = display.newRoundedRect( display.contentCenterX, display.contentCenterY, 200, 50, 20 )
    local playTxt = display.newText( "Play", playBg.x, playBg.y, native.systemFont, 20)
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
    --about text




    --toDo remove on destoy or hide?
    -- Called when the app's view has been resized
    local function onResize( event )

    end


    Runtime:addEventListener( "resize", onResize )
end



-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
-- -----------------------------------------------------------------------------------

return scene
