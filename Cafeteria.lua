-- Written by Tristan Davis
-- Last edited 11/19/17
-- Last edited 11/20/17

local composer = require( "composer" )
local physics = require("physics")
local backButtons = require("objects.menu_button")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local objects = {}; -- A list of objects.
local points = 0; -- A sum of possitive and negative objects.
local back_button;
local pointText;
local params = {};
params.cafeScore = 0;
-- All the foods
local apple = "arts/apple.png"
local cracker = "arts/cracker.png"
local sandwich = "arts/sandwich.png"
local candy = "arts/candy.png"
local spider = "arts/spider.png"
local spoon = "arts/spoon.png"
local fly = "arts/fly.png"
local grapes = "arts/grapes.png"
local bean = "arts/bean.png"

local function positiveObject(event)
	if(event.phase == "moved") then
		points = points + 1;
		display.remove(event.target);
		pointText.text = "Score: " .. points;
	end
end

local function negativeObject(event)
	if(event.phase == "moved") then
		points = points - 1;
		display.remove(event.target);
		pointText.text = "Score: " .. points;
	end
end

local function createObject()
	local n =  math.random(3,5)
	for i=1,n,1 do
		local theObject;
		local o = math.random(1, 9); -- Object

		if(o == 1) then -- apple
			theObject = display.newImage(apple);
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			theObject:addEventListener("touch", positiveObject)
			physics.addBody(theObject, "dynamic", {isSensor = true})
		elseif(o == 2) then -- cracker
			theObject = display.newImage(cracker);
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			theObject:addEventListener("touch", positiveObject)
			physics.addBody(theObject, "dynamic", {isSensor = true})
		elseif(o == 3) then -- sandwich
			theObject = display.newImage(sandwich);
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			theObject:addEventListener("touch", positiveObject)
			physics.addBody(theObject, "dynamic", {isSensor = true})
		elseif(o == 4) then -- candy
			theObject = display.newImage(candy);
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			theObject:addEventListener("touch", positiveObject)
			physics.addBody(theObject, "dynamic", {isSensor = true})
		elseif(o == 5) then -- spider
			theObject = display.newImage(spider);
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			theObject:addEventListener("touch", negativeObject)
			physics.addBody(theObject, "dynamic", {isSensor = true})
		elseif(o == 6) then -- spoon
			theObject = display.newImage(spoon);
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			theObject:addEventListener("touch", negativeObject)
			physics.addBody(theObject, "dynamic", {isSensor = true})
		elseif(o == 7) then -- fly
			theObject = display.newImage(fly);
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			theObject:addEventListener("touch", negativeObject)
			physics.addBody(theObject, "dynamic", {isSensor = true})
		elseif(o == 8) then -- grapes
			theObject = display.newImage(grapes);
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			theObject:addEventListener("touch", positiveObject)
			physics.addBody(theObject, "dynamic", {isSensor = true})
		elseif(o == 9) then -- bean
			theObject = display.newImage(bean);
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			theObject:addEventListener("touch", positiveObject)
			physics.addBody(theObject, "dynamic", {isSensor = true})

		--elseif(o == 10) then
		else
			print("Random food out of bounds.")
		end
		theObject:setLinearVelocity(math.random(-100,100), -150 * math.random(4,6));
		theObject.angularVelocity = math.random(5,15)
	end
		--return theObject;
	local function kill()
		display.remove(theObject);
	end
	timer.performWithDelay(1000 * 10 , kill);
end


local objectGenerator;
local function gameOver(event)
	-- Game over things.
	timer.cancel(objectGenerator);
	-- TODO: Add a button to return to campus.
end

local function timeOut(event)
		params.cafeScore = points;

		local button = backButtons.newHscore("cafeteria", -- The name of the current scene
											params) -- Parameters, e.g. params.cafeteriaScore
		button.hscore.isVisible = true;
end

local function startGame(bar)
	timer.performWithDelay(((1000 * 60) * 2) -4000, gameOver); -- This game is timed.
	transition.to(bar, {x = 65, xScale = 0, time = (1000 * 60) * 2, onComplete = timeOut})
	objectGenerator = timer.performWithDelay(800 * math.random(2,4), createObject, 0)


end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
   		physics.start();
   		local bg = display.newImage("arts/cafeteriaBG1.png", 360, 640)
	    sceneGroup:insert(bg);
	    local timeBar = display.newImage("arts/barfill.png", 355, 110)
	    timeBar:scale(1.16,1.3)
	    sceneGroup:insert(timeBar);
	   	timeBar:toBack();
	   	bg:toBack();
	   	startGame(timeBar);
		pointText = display.newText("Score: 0", display.contentCenterX, 40, native.systemFont, 45)
		pointText:setFillColor(0,0,0)
		sceneGroup:insert(pointText);
    -- Code here runs when the scene is first created but has not yet appeared on screen



end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
	    --physics.setDrawMode("hybrid")
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
