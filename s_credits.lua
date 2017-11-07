local composer = require( "composer" )
local scene = composer.newScene()
--Center points used for relative positioning.
local xCenter = display.contentCenterX;
local yCenter = display.contentCenterY;
--Create necessary variables for creating buttons.
local w_button = require("widget")
local b_menu;
--This is for displaying names in credits scene.

 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here

--Scene transition options
local transition = {effect = "slideLeft", time = 500}
--button functions
function menuFunc(event)
   if(event.phase == "ended") then
      composer.gotoScene("s_main_menu", transition)
   end
end


 --Button options
local bo_menu = {
               left = xCenter - 50, --center = width/2
               top = yCenter - 150 + 240,
               id = "Menu",
               label = "Menu",
               onEvent = menuFunc,
               shape = "roundedRect",
               width = 100,
               height = 40,
               cornerRadius = 6.28,
               fillColor = {default = {1,0,0,1}, over = {1,0.1,0.7,0.4}},
               strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}},
               strokeWidth = 4
            }
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
 display.setStatusBar( display.HiddenStatusBar )
   local sceneGroup = self.view
 
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   --display.newText( [parent,] text, x, y [, width, height], font [, fontSize] )
      local developedText = display.newText("Developed by:", display.contentCenterX + 50, -25, display.contentWidth, display.contentHeight, native.systemFont, 20, "center")
      local myText = display.newText("Tristan Davis", display.contentCenterX + 50, 0, display.contentWidth, display.contentHeight, native.systemFont, 20, "center") 
      local zachText = display.newText("Zach Parker", display.contentCenterX + 50, 25, display.contentWidth, display.contentHeight, native.systemFont, 20, "center") 
      local lostText = display.newText("Brian \"Lost\" Lofty", display.contentCenterX + 50, 50, display.contentWidth, display.contentHeight, native.systemFont, 20, "center") 
      local brandiText = display.newText("Brandi LeBaron", display.contentCenterX + 50, 75, display.contentWidth, display.contentHeight, native.systemFont, 20, "center") 

      --myText.align = "center";
      myText:setFillColor(1,1,0)
      zachText:setFillColor(1,1,0)
      lostText:setFillColor(1,1,0)
      brandiText:setFillColor(1,1,0)
      b_menu = w_button.newButton(bo_menu)
      sceneGroup:insert(myText)
      sceneGroup:insert(zachText)
      sceneGroup:insert(lostText)
      sceneGroup:insert(brandiText)
      sceneGroup:insert(b_menu)
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
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
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene