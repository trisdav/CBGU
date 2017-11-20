-- Written by Tristan Davis
-- Last edited 11/19/17

--[[
	--Usage:
	local backButtons = require("objects.menu_button") -- Include this lua file
	--Button that returns to campus map
	button = backButtons.newCampus("Cafeteria"); -- substitute your scene name for "Cafeteria"
	--or button that returns to main menu
	button = backButtons.newMenu("Cafeteria");

	--For campus button
	sceneGroup:insert(button.campus); -- Be sure to add it to scene group.
	-- For menu button
	sceneGroup:insert(button.menu);
	--For campus button
	button.campus.isVisible = false; -- Make sure it is not visible until it is needed.
	-- For menu button
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
         composer.gotoScene("s_main_menu", transition)
      end
   end


    --Button options
   local bo_campus = {
                  left = display.contentCenterX - 200, --center = width/2
                  top = display.contentCenterY + 400,
                  id = "Menu",
                  label = "Menu",
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

return t;