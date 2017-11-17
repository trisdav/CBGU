local composer = require( "composer" )
local graphics = require("graphics")
local audio = require("audio")
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
               left = xCenter - 200, --center = width/2
               top = yCenter + 400,
               id = "Menu",
               label = "Menu",
               onEvent = menuFunc,
               shape = "roundedRect",
               width = 400,
               height = 160,
               cornerRadius = 30,
               fillColor = {default = {1,0,0,1}, over = {1,0.1,0.7,0.4}},
               strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}},
               strokeWidth = 10
            }

 local fishOpts = { 
                      frames = {
                                -- Frame 1, mouth open
                                 {
                                    x = 167,
                                    y = 4,
                                    width = 627,
                                    height = 410  
                                 },
                                -- Frame 2, mouth closed
                                 {
                                    x = 183,
                                    y = 430,
                                    width = 593,
                                    height = 274
                                 }
                                }
                  }
-- Fish sheet
local fishSheet = graphics.newImageSheet("arts/fishSprite.png", fishOpts)

local fishSeq = {
                  { name = "open", start = 1, count = 1, time = 1},
                  { name = "closed", start = 2, count = 1, time = 1}
                }
local willy = audio.loadStream("arts/WilhelmScream.wav")

local function AAAAAAAH(event)
   print("Event")
   print(event.target.sequence)
   if(event.target.sequence == "closed")then
      event.target:setSequence("open");
      event.target:play()
      audio.play(willy)
   else
      event.target:setSequence("closed");
      event.target:play()
   end
end
---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
 display.setStatusBar( display.HiddenStatusBar )
   local sceneGroup = self.view
 
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   --display.newText( [parent,] text, x, y [, width, height], font [, fontSize] )
      local developedText = display.newText("Developed by:", display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight, native.systemFont, 64, "center")
      local myText = display.newText("Tristan Davis", display.contentCenterX, display.contentCenterY + 64, display.contentWidth, display.contentHeight, native.systemFont, 64, "center") 
      local zachText = display.newText("Zach Parker", display.contentCenterX, display.contentCenterY + (64 * 2), display.contentWidth, display.contentHeight, native.systemFont, 64, "center") 
      local lostText = display.newText("Brian \"Lost\" Lofty", display.contentCenterX, display.contentCenterY + (64 * 3), display.contentWidth, display.contentHeight, native.systemFont, 64, "center") 
      local brandiText = display.newText("Brandi LeBaron", display.contentCenterX, display.contentCenterY + (64 * 4), display.contentWidth, display.contentHeight, native.systemFont, 64, "center") 
      local bg = display.newImage("arts/cafeteriaBG1.png", 360, 640)
      fishSprite = display.newSprite(fishSheet, fishSeq);
      fishSprite:setSequence("closed")
      --fishSprite:scale(.5,.5)
      fishSprite.x = display.contentCenterX;
      fishSprite.y = display.contentCenterY;
      fishSprite:addEventListener("tap", AAAAAAAH);
      --myText.align = "center";
      myText:setFillColor(0,0,0)
      zachText:setFillColor(0,0,0)
      lostText:setFillColor(0,0,0)
      brandiText:setFillColor(0,0,0)
      b_menu = w_button.newButton(bo_menu)
      b_menu._view._label.size = 64
      sceneGroup:insert(developedText)
      sceneGroup:insert(myText)
      sceneGroup:insert(zachText)
      sceneGroup:insert(lostText)
      sceneGroup:insert(brandiText)
      sceneGroup:insert(b_menu)
      sceneGroup:insert(fishSprite)
      sceneGroup:insert(bg)
            bg:toBack();

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