-- Written by Tristan Davis
-- Last edited 11/19/17
-- Last edited 11/20/17
-- Last edited 11/26/17

--[[
	--Usage:
	-- For going back to Highscore.lua
		local backButtons = require("objects.menu_button") -- Include this lua file
		local button = backButtons.newHscore("cafeteria", -- The name of the current scene
											params) -- Parameters, e.g. params.cafeteriaScore
		sceneGroup:insert(button.hscore); -- Be sure to insert into scene group
		button.hscore.isVisible = false; -- Keep hidden until needed.
		
		-- For going back to campus
      local backButtons = require("objects.menu_button") -- Include this lua file
      button = backButtons.newCampus("Cafeteria"); -- substitute your scene name for "Cafeteria"
      sceneGroup:insert(button.campus); -- Be sure to add it to scene group.
      button.campus.isVisible = false; -- Make sure it is not visible until it is needed.


	-- For going back to menu.
      local backButtons = require("objects.menu_button") -- Include this lua file
		button = backButtons.newMenu("Cafeteria");
		sceneGroup:insert(button.menu);
		button.menu.isVisible = false;

]]

local composer = require( "composer" )
local w_button = require("widget")


local t = {}
local mt = {__index = t}

function t.newMenu(oldScene)
   --Scene transition options
   local transition = {effect = "slideLeft", time = 500}
   --button functions
   function menuFunc(event)
      if(event.phase == "ended") then
         event.target.isVisible = false;
         oldcomposer.removeScene(oldScene)
         composer.gotoScene("s_main_menu", transition)
      end
   end


    --Button options
   local bo_menu = {
                  left = display.contentCenterX - 200, --center = width/2
                  top = display.contentCenterY + 400,
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


      local b_menu = w_button.newButton(bo_menu)
      b_menu._view._label.size = 64
      mt.menu = b_menu;
      return mt;
end

function t.newCampus(oldScene)

   --Scene transition options
   local transition = {effect = "slideLeft", time = 500}
   --button functions
   function campusFunc(event)
      if(event.phase == "ended") then
         event.target.isVisible = false;
         composer.removeScene(oldScene);
         composer.gotoScene("Campus", transition)
      end
   end


    --Button options
   local bo_campus = {
                  left = display.contentCenterX - 200, --center = width/2
                  top = display.contentCenterY + 400,
                  id = "Campus",
                  label = "Campus",
                  onEvent = campusFunc,
                  shape = "roundedRect",
                  width = 400,
                  height = 160,
                  cornerRadius = 30,
                  fillColor = {default = {1,0,0,1}, over = {1,0.1,0.7,0.4}},
                  strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}},
                  strokeWidth = 10
               }


      local b_campus = w_button.newButton(bo_campus)
      b_campus._view._label.size = 64
      mt.campus = b_campus;
      return mt;
end

function t.newHscore(oldScene, oldParams)

   --Scene transition options
   local transition = {effect = "slideLeft",
						time = 500,
						params = { gymScore = nil,
									classScore = nil,
									dormScore = nil,
									CBGScore = nil,
									cafeteriaScore = nil}
						}
   --button functions
   function hscoreFunc(event)
      if(event.phase == "ended") then
         event.target.isVisible = false;
		 if(oldParams.dormScore ~= nil) then
			transition.params.dormScore = oldParams.dormScore;
		elseif(oldParams.gymScore ~= nil) then
			transition.params.gymScore = oldParams.gymScore;
		elseif(oldParams.CBGScore ~= nil) then
			transition.params.CBGScore = oldParams.CBGScore;
		elseif(oldParams.cafeScore ~= nil) then
			transition.params.cafeScore = oldParams.cafeScore;
      elseif(oldParams.classScore ~= nil) then
         transition.params.classScore = oldParams.classScore;
      elseif(oldParams.libraryScore ~= nil) then
         transition.params.libraryScore = oldParams.classScore;
      elseif(oldParams.partyScore ~= nil) then
         transition.params.partyScore = oldParams.partyScore;
      end
		 
         composer.removeScene(oldScene);
         composer.gotoScene("Highscores", transition)
      end
   end


    --Button options
   local bo_hscore = {
                  left = display.contentCenterX - 200, --center = width/2
                  top = display.contentCenterY + 400,
                  id = "hscore",
                  label = "Score Board",
                  onEvent = hscoreFunc,
                  shape = "roundedRect",
                  width = 400,
                  height = 160,
                  cornerRadius = 30,
                  fillColor = {default = {1,0,0,1}, over = {1,0.1,0.7,0.4}},
                  strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}},
                  strokeWidth = 10
               }


      local b_hscore = w_button.newButton(bo_hscore)
      b_hscore._view._label.size = 64
      mt.hscore = b_hscore;
      return mt;
end

return t;
