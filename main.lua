 --b_ = button widget
 --bo_ = button options
 --s_ = a scene file
 ------------------------------------------------------------------------------------
 -------------------------      Objects for class.lua    ----------------------------
 ------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------

 ------------------------------------------------------------------------------------
-- Fidget object
  fidget = {}
 fidget.__index = fidget
function fidget:new(o)
		o = o or {} -- create table if if user does not provide one

		local phsyics = require("physics")
		local myTimer = nil;
		physics.setGravity(0,0)
	 	local myOptions = {
	 						width = 200, height = 200
		}
		local myText = display.newText("angular velcity", 350, 25, native.systemFont, 64)
		local currentOmega = 0;
		local myImage = display.newImage("arts/educational_instrument.png" )
		myImage.x = display.contentCenterX
		myImage.y = display.contentCenterY
		
		local function spin(event)

			currentOmega = myImage.angularVelocity;
			myImage.angularVelocity = 250 + currentOmega
			myText.text = "angular velocity: " .. math.round(myImage.angularVelocity)
			--myImage.angularVelocity = 1000
			if(myTimer == nil) then
				myTimer = timer.performWithDelay(500, function() myText.text = "angular velocity: " .. math.round(myImage.angularVelocity) end, 0)
			end
		end

		local imageOutline = graphics.newOutline(2, "arts/educational_instrument.png")

		 physics.addBody(myImage, "dynamic", {isSensor = true})
		 myImage.angularDamping = .2
		 myImage:addEventListener("tap", spin)
		self.__index = self
		return myImage
end



 ------------------------------------------------------------------------------------
 -------------------------     Here the game is initialized.     ----------------------------
 ------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------

local main = require("composer");
display.setStatusBar( display.HiddenStatusBar )		

main.gotoScene("s_main_menu", {effect = "slideRight", time=500})