 --b_ = button widget
 --bo_ = button options
 --s_ = a scene file
local main = require("composer");
display.setStatusBar( display.HiddenStatusBar )		
local function func()
	function myFunc()
		print("Hello world")
	end
	myFunc()
end
main.gotoScene("s_main_menu", {effect = "slideRight", time=500})