--

local composer = require( "composer" )
local colors = require "modules.colors"

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

    local title = display.newText(sceneGroup, "Water Drop", display.contentCenterX, 40, native.systemFontBold, 30)
    colors.setFillColor(title, colors.title)
    --play button
    local playButton = display.newGroup()
    local playBg = display.newRect( display.contentCenterX, display.contentCenterY, 200, 50 )
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
