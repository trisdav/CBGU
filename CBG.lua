--[[
		CBG.lua
		created by Tristan Davis 11/11/17
		
		This file will manage the run time events of the cat berry greens.
]]


local composer = require( "composer" )
local transition = {
                    effect = "fade",
                    time = 400,
                    params = {}
                    }

local scene = composer.newScene()
-- create()
function scene:create( event )
    local sceneGroup = self.view
    --sceneGroup:insert(golfObjects.walls)
    -- Code here runs when the scene is first created but has not yet appeared on screen

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        composer.gotoScene("objects.golfLevel1", transition )

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    sceneGroup:removeSelf();
    print("Hello?")
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
