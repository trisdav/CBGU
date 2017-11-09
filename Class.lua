
-----------------------------------------------------------------------------------------
--
-- Class.lua
--      In this class the user will have to keep nervous energy stable by using fidget
-- spinner. At regular intervals the teacher will add random characters to a white
-- board. The user will have to tap the characters in sequence on a mock-up keyboard.
--
--
-- Created by Tristan Davis on 11/07/17
-- Last edited by Tristan Davis 11/9/17
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local physics = require("physics")

--------------------------------------------------------------------------
-------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
--------------------------------------------------------------------------
-------
-- local forward references should go here
--------------------------------------------------------------------------
-------
-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    physics.start()
    local myFidget = fidget:new()
    sceneGroup:insert(myFidget)
    myFidget.x = display.contentCenterX - 200;
    myFidget.y = display.contentCenterY + 500;


-- Initialize the scene here.
end
-- "scene:show()"
function scene:show( event )
    local phase = event.phase

    if ( phase == "will" ) then
    -- Called when the scene is still off screen (but is about to come on screen.)
    elseif ( phase == "did" ) then

       -- noteBook:scale(.5, .5)
    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    end
end
-- "scene:hide()"
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
    -- Called immediately after scene goes off screen.
    end
end
-- "scene:destroy()"
function scene:destroy( event )
    local sceneGroup = self.view
    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end
--------------------------------------------------------------------------
-------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
--------------------------------------------------------------------------
-------
return scene