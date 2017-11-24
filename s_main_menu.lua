local composer = require( "composer" )
local w_button = require( "widget" )
local scene = composer.newScene()
local xCenter = display.contentCenterX;
local yCenter = display.contentCenterY;
 --b_ = button widget
 --bo_ = button options
 --s_ = a scene file
 local transition = {effect = "slideRight", time = 500}

--These are button events
local function Start(event)
   if(event.phase == "ended") then
      composer.gotoScene("Campus", levelTransition)
   end
end
local function Settings(event)
   if(event.phase == "ended") then
      --composer.gotoScene("s_settings", settingsTransition)
   end
end
local function Credits(event)
   if(event.phase == "ended") then
      composer.gotoScene("s_credits", transition)
   end
end
local function quitGame(event)
   if(event.phase == "ended") then
      if system.getInfo("platformName") == "Android" then
         native.requestExit()
      else
         os.exit()
      end
   end
end
 
--Buttons
   local b_start;
   local b_settings;
   local b_credits;
   local b_exit;
   --Button Options
   local bo_exit;
   local bo_start = { left = xCenter - 150, --center = width/2
                     top = yCenter - 260,
                     id = "Start",
                     label = "",
                     onEvent = Start,
                     shape = "roundedRect",
                     width = 300,
                     height = 100,
                     cornerRadius = 30,
                     fillColor = {default = {0,0,0,.05}, over = {0,0,0,0.2}},
                     strokeColor = {default = {0,0,0,0}, over = {0,0,0,0}},
                     strokeWidth = 10
                  }

   local bo_credits = {
                     left = xCenter - 150, --center = width/2
                     top = yCenter - 110, --Offset buttons relative to first button.
                     id = "Credits",
                     label = "",
                     onEvent = Credits,
                     shape = "roundedRect",
                     width = 290,
                     height = 100,
                     cornerRadius = 30,
                     fillColor = {default = {0,0,0,.05}, over = {0,0,0,0.2}},
                     strokeColor = {default = {0,0,0,0}, over = {0,0,0,0}},
                     strokeWidth = 10
                  }
   local bo_exit = {
                     left = xCenter - 150, --center = width/2
                     top = yCenter + 45, --Offset button relative to first button.
                     id = "Exit",
                     label = "",
                     onEvent = quitGame,
                     shape = "roundedRect",
                     width = 300,
                     height = 100,
                     cornerRadius = 30,
                     fillColor = {default = {0,0,0,.05}, over = {0,0,0,0.14}},
                     strokeColor = {default = {0,0,0,0}, over = {0,0,0,0}},
                     strokeWidth = 10
                  }
---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )
 display.setStatusBar( display.HiddenStatusBar )
   local sceneGroup = self.view
   local background = display.newImage("arts/menuScreen.png", 0 , 0);
   background.x = 360;
   background.y = 640;
   sceneGroup:insert(background);
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
      --Initialize buttons.
      b_start    = w_button.newButton(bo_start)
      b_start._view._label.size = 64

      b_credits  = w_button.newButton(bo_credits)
      b_credits._view._label.size = 64
      b_exit     = w_button.newButton(bo_exit)
      b_exit._view._label.size = 64
      sceneGroup:insert(b_start)
      sceneGroup:insert(b_credits)
      sceneGroup:insert(b_exit)
      if(event.params ~= nil) then
         if(event.params.timeMod ~= nil) then
            levelTransition.params.timeMod = event.params.timeMod
         end
      end

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