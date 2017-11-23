-- Written by Tristan Davis
-- Last edited 11/19/17
-- Last edited 11/20/17
-- Last edited 11/23/17

local composer = require( "composer" )
local physics = require("physics")
local backButtons = require("objects.menu_button")
local extras = require("objects.extras")
local graphics = require("graphics")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local fork;-- used for eating
local objects = {}; -- A list of objects.
local objectSpriteSheet = {};
local points = 0; -- A sum of possitive and negative objects.
local back_button;
local pointText;
local params = {};
params.cafeScore = 0;


local function positiveObject(posObj)
		points = points + 1;
		display.remove(posObj);
		pointText.text = "Score: " .. points;
end

local function negativeObject(negObj)
		points = points - 1;
		display.remove(negObj);
		pointText.text = "Score: " .. points;
end

local function createObject()
	local n =  math.random(3,5)
	for i=1,n,1 do
		local theObject;
		local o = math.random(1, 9); -- Object

--[[
local sandwichShape = 
sandwichShape.density = 1; sandwichShape.friction = 0.3; sandwichShape.bounce = 0.2; 

local SpiderLowShape = { -98.6428680419922,-23.1428546905518, -112.571441650391,9.35714721679688, -109.714294433594,26.1428623199463, -80.0714416503906,44.0000038146973, -46.1428680419922,23.6428623199463, 19.2142753601074,26.1428623199463, 92.4285659790039,44.0000038146973, 103.499992370605,22.9285755157471 }
local SpiderTopRightShape = { 102.785705566406,22.2142906188965, 108.499992370605,7.92857551574707, 111.357131958008,-5.28571081161499, 57.7857055664063,-34.5714263916016, 20.2857055664063,-9.92856788635254, 6.35713291168213,-16.3571395874023, -11.5000104904175,-14.5714254379272, -12.928581237793,-5.28571081161499 }
local SpiderTopLeftShape = { -11.8571529388428,-14.5714254379272, -11.1428670883179,-43.4999961853027, -24.0000095367432,-45.2857131958008, -97.5714416503906,-24.5714263916016, -55.7857246398926,7.57143259048462, -13.6428670883179,7.21428966522217 }
]]



		if(o == 1) then -- Sandwich
			theObject = display.newImage(objectSpriteSheet, 1); -- Get image
			local triangleShape = { 57.0000076293945,-88.0769195556641, -79.9230728149414,35.0000076293945, -80.6922988891602,47.3076972961426, -63.7692222595215,79.6153945922852, 63.9230880737305,83.4615478515625, 70.0769348144531,76.5384674072266, 81.6153945922852,-37.3076858520508, 72.3846282958984,-85.7692260742188 };
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			physics.addBody(theObject, "dynamic", {isSensor = true, shape = triangleShape})
			--theObject:addEventListener("touch", positiveObject)
			theObject.id = "+"

		elseif(o == 2) then -- Apple, say aaaapple
			theObject = display.newImage(objectSpriteSheet, 2);
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			--theObject:addEventListener("touch", positiveObject)
			theObject.id = "+"
			local anOutline = graphics.newOutline( 2, objectSpriteSheet, 2)
			physics.addBody(theObject, "dynamic", {isSensor = true, outline = anOutline})
		elseif(o == 3) then -- Beans beans beans, the musical fruit.
			theObject = display.newImage(objectSpriteSheet, 3);
			local anOutline = graphics.newOutline( 2, objectSpriteSheet, 3)
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			--theObject:addEventListener("touch", positiveObject)
			theObject.id = "+"
			physics.addBody(theObject, "dynamic", {isSensor = true, outline = anOutline})
		elseif(o == 4) then -- Cracker
			theObject = display.newImage(objectSpriteSheet, 4);
			local anOutline = graphics.newOutline( 2, objectSpriteSheet, 4)
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			--theObject:addEventListener("touch", positiveObject)
			theObject.id = "+"
			physics.addBody(theObject, "dynamic", {isSensor = true, outline = anOutline})
		elseif(o == 5) then -- Spoon
			theObject = display.newImage(objectSpriteSheet, 5);
			local anOutline = graphics.newOutline( 2, objectSpriteSheet, 5)
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			--theObject:addEventListener("touch", negativeObject)
			theObject.id = "-"
			physics.addBody(theObject, "dynamic", {isSensor = true, outline = anOutline})
		elseif(o == 6) then -- Fly
			theObject = display.newImage(objectSpriteSheet, 6);
			local anOutline = graphics.newOutline( 2, objectSpriteSheet, 6)
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			--theObject:addEventListener("touch", negativeObject)
			theObject.id = "-"
			physics.addBody(theObject, "dynamic", {isSensor = true, outline = anOutline})
		elseif(o == 7) then -- Grapes
			theObject = display.newImage(objectSpriteSheet, 7);
			local anOutline = graphics.newOutline( 2, objectSpriteSheet, 7)
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			--theObject:addEventListener("touch", positiveObject)
			theObject.id = "+"
			physics.addBody(theObject, "dynamic", {isSensor = true, outline = anOutline})
		elseif(o == 8) then -- Spider
			local SpiderLowShape = { -98.6428680419922,-23.1428546905518, -112.571441650391,9.35714721679688, -109.714294433594,26.1428623199463, -80.0714416503906,44.0000038146973, -46.1428680419922,23.6428623199463, 19.2142753601074,26.1428623199463, 92.4285659790039,44.0000038146973, 103.499992370605,22.9285755157471 }
			local SpiderTopRightShape = { 102.785705566406,22.2142906188965, 108.499992370605,7.92857551574707, 111.357131958008,-5.28571081161499, 57.7857055664063,-34.5714263916016, 20.2857055664063,-9.92856788635254, 6.35713291168213,-16.3571395874023, -11.5000104904175,-14.5714254379272, -12.928581237793,-5.28571081161499 }
			local SpiderTopLeftShape = { -11.8571529388428,-14.5714254379272, -11.1428670883179,-43.4999961853027, -24.0000095367432,-45.2857131958008, -97.5714416503906,-24.5714263916016, -55.7857246398926,7.57143259048462, -13.6428670883179,7.21428966522217 }

			theObject = display.newImage(objectSpriteSheet, 8);
			local anOutline = graphics.newOutline( 2, objectSpriteSheet, 8)
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			--theObject:addEventListener("touch", negativeObject)
			theObject.id = "-"
			physics.addBody(theObject, "dynamic", {isSensor = true, shape = SpiderLowShape},
												  {isSensor = true, shape = SpiderTopRightShape},
												  {isSensor = true, shape = SpiderTopLeftShape})
		elseif(o == 9) then -- Candy
			theObject = display.newImage(objectSpriteSheet, 9);
			theObject.x = math.random(200, display.contentWidth-200);
			theObject.y = display.contentHeight + 100;
			--theObject:addEventListener("touch", positiveObject)
			theObject.id = "+"
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
	params.cafeScore = points;

	local button = backButtons.newHscore("Cafeteria", -- The name of the current scene
											params) -- Parameters, e.g. params.cafeteriaScore
	button.hscore.isVisible = false;
	local function exitVis(event)
		button.hscore.isVisible = true;
	end
	timer.performWithDelay(4800, exitVis)
	-- TODO: Add a button to return to campus.
end

local function startGame(bar)
	timer.performWithDelay(((1000 * 60)) -5000, gameOver); -- This game is timed.
	bar.timeScale = (1); -- Default time is 1 minute.
	bar:play();
	--transition.to(bar, {x = 65, xScale = 0, time = (1000 * 60) * 2, onComplete = timeOut})
	objectGenerator = timer.performWithDelay(800 * math.random(2,4), createObject, 0)
end

local function sliced(event)
	if(event.phase == "began") then
		if(event.other.id == "+") then
			positiveObject(event.other);
		else
			negativeObject(event.other);
		end
	end
end

local function sword(event)
	if(event.phase == "began") then
		fork.isFocus = true;
		fork.x = event.x;
		fork.y = event.y;
	    physics.addBody(fork, "kinematic", {isSensor = true})
	    fork:addEventListener("collision", sliced)
	elseif(event.phase == "ended") then
		fork:removeEventListener("collision", sliced)
		fork.isFocus = false;
	elseif(event.phase == "moved") then
		fork.x = event.x;
		fork.y = event.y;
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
   		physics.start();
   		physics.setDrawMode("hybrid")
   		local bg = display.newImage("arts/cafeteriaBG1.png", 360, 640)
	    sceneGroup:insert(bg);
	    -- Set up the clock
	    local timeImageSheet = graphics.newImageSheet("arts/barfill.png", extras.getBarFrames())

	    local timeSprite = display.newSprite(timeImageSheet, extras.getBarSequence())
	    timeSprite.anchorY = .5;
	    timeSprite.anchorX = 0;
	    timeSprite.x = 65;
	    timeSprite.y = 111;
	    timeSprite:scale(1.164,1.5)

	   	objectSpriteSheet = extras.getFruitImages();
	   	-- Set up the "sword" to slice "fruit"
	   	bg:addEventListener("touch", sword);
	   	fork = display.newCircle(0, 0,2);  -- This is the "sword"
	   	bg:toBack();
		pointText = display.newText("Score: 0", display.contentCenterX, 40, native.systemFont, 45)
		pointText:setFillColor(0,0,0)
		sceneGroup:insert(fork)
		sceneGroup:insert(pointText);
		sceneGroup:insert(timeSprite);
		startGame(timeSprite);

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
