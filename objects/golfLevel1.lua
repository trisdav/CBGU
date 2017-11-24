--[[
	golfLevels.lua 
	Created by Tristan Davis 11/11/17

	This file will hold all the level data for the various golf levels to be implemented
	in the cat berry greens.
	Last edited 11-16-17

]]


local composer = require( "composer" )
local audio = require("audio")

local scene = composer.newScene()
local bounceSound = audio.loadSound("arts/365789_5966424-lq.mp3");
local puttSound = audio.loadSound("arts/366597_6736410-lq.mp3");

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local putter = display.newCircle(0,0,600); -- used for putting
putter:setFillColor(0,0,0, .05)
putter:setStrokeColor(1,0,0, .5)
putter.strokeWidth = 2
local putterLine;
local speedAmp = 4; -- Used to increase the max/min speed.
local checkTimer;
local defaultDamp;
local narrationText;
local strokeCount = 1;
local win = 0;
local sandDamp = 0;
local currentLevel;
local isFinal = false; -- If this is the last coarse in the sequence set to true.
local params = {};
params.CBGScore = nil;

-- Add any physics bodies here, it is necessary for removal of the scene.
local ball;
local hole;
local holeSensor;
local background;
local Sand;

-------------- Transition between courses -----------------
local transOpt = {
                    effect = "fade",
                   	time = 400,
                    params = { golfLevel  = 1 }
                    }

local function nextLevel()
	transOpt.params.golfLevel = transOpt.params.golfLevel + 1;
	transOpt.params.CBGScore = (strokeCount) + params.CBGScore;
	--Remove scene objects
	composer.removeScene("objects.golfLevel1")
	if(isFinal) then
		--button is visible
	elseif(transOpt.params.golfLevel > 2) then
		composer.gotoScene("objects.golfLevel1", transOpt);
	elseif(transOpt.params.golfLevel == 2) then
		composer.gotoScene("objects.golfLevel2", transOpt);
	elseif(transOpt.params.golfLevel == 1) then
		composer.gotoScene("objects.golfLevel1", transOpt);
	else
		print("Thats odd, that level does not seem to exist.")
	end
end

------------- golf ball stuff ----------------

local function setBall(x, y, dens, fri, bnc, damp)
	ball = display.newCircle(360,640, 15) -- Default golf ball
	ball:setFillColor(.5,.5,.5) -- Default golf ball color	
	ball.x = x;
	ball.y = y;
	physics.addBody(ball, "dynamic",{ density = (dens or 1), friction = (fri or .2), bounce = (bnc or .2), radius = 15})
	ball.angularDamping = (damp or .4);
end

---- Is moving will check to see if the ball is in motion still. if it is not
-- it will allow the user to put again.
local function isMoving(event)
	local xv,yv = ball:getLinearVelocity();
		xv = math.abs(xv);
		yv = math.abs(yv);
		if(win == 0) then
			narrationText.text = "Current velocity: " .. math.round(xv + yv)
		end
	-- If the ball is close to stopping increase damping to prevent 'creeping'
	if(xv+yv < 400) then
		ball.linearDamping = 1 + sandDamp;
		ball.angularDamping = 1 + sandDamp;

	elseif(xv + yv < 200) then
		print("slow down!")
		ball.linearDamping = 2 + sandDamp;
		ball.angularDamping = 2 + sandDamp; 
	elseif(xv + yv < 50) then
		print("Stop!!")
		ball:setLinearVelocity(0,0)
		ball.angularVelocity = 0
	end

	-- if ball is no longer in motion.
	if(xv == 0 and yv == 0) then
		ball.linearDamping = defaultDamp + sandDamp;
		ball.angularDamping = defaultDamp + sandDamp;
		timer.cancel(checkTimer); -- Stop checking to see if ball is in motion.
		-- Set the putter to the new ball positon
		putter.x = ball.x;
		putter.y = ball.y;
		if(win  ~= 1) then
			putter.isVisible = true; -- Return the putter.
		end
		strokeCount = strokeCount + 1;
		if( win == 0) then
			narrationText.text = "Putt!"
		end
	end

end

---- putterEvent will handle drawing the vector decribing force and direction as well as
-- implementing that force on the ball.
local function putterEvent(event)
	if(event.phase == "moved") then
		-- Get change in x and y
		local deltaX = ball.x + event.x;
		local deltaY = ball.y + event.y;
		-- Normalize positions
		deltaX = deltaX - ball.x;
		deltaY = deltaY - ball.y;
		-- If a line already exists remove it.
		if(putterLine ~= nil) then
			display.remove(putterLine);
		end
		putterLine = display.newLine(ball.x, ball.y, deltaX, deltaY);
		putterLine.strokeWidth = 8;
		putterLine:setStrokeColor(0,0,1)
	end
	if(event.phase == "ended") then
		--- Audio
		local handle = audio.play(puttSound, {fadein = 0, delay = 0});
		audio.seek(1550, handle);

		local function stop(event)
			audio.stop(handle);
		end
		timer.performWithDelay(500, stop, 1);
		-- physics
		putter.isVisible = false; -- Temporarily remove putter.
		-- Get change in x and y
		local deltaX = event.x - ball.x;
		local deltaY = event.y - ball.y;
		-- set ball velocity
		ball:setLinearVelocity(deltaX * speedAmp, deltaY * speedAmp)
		display.remove(putterLine)
		-- while ball is in motion check to see if it is still in motion
		checkTimer = timer.performWithDelay(50, isMoving, 0) 

	end
end

---- Will handle the times the player manages to land the ball in the hole.
local function inTheHole(event)

	if(event.other == ball) then
		-- audio
		local handle = audio.play(puttSound, {fadein = 0, delay = 0 });
		audio.seek(2000, handle);
		local function stop(event)
			audio.stop(handle);
		end
		timer.performWithDelay(500, stop, 1);
		-- physics
		ball:setLinearVelocity(0,0);
		ball.angularVelocity = 0;
		transition.to(event.other, {time = 150, x = hole.x, y = hole.y})
		narrationText.text = "Hole in: ".. strokeCount;
		win = 1;
		--print("Here")=
		timer.performWithDelay(2000, nextLevel)
	end
end
---------------- Sand event --------------------
local function sandPit(event)
	if(event.phase == "began") then
		--in the pit.
		sandDamp = 20;
		ball.linearDamping = sandDamp;
		ball.angularDamping = sandDamp;
	elseif(event.phase == "ended") then
		-- Out of the pit.
		ball.linearDamping = defaultDamp;
		ball.angularDamping = defaultDamp;
		sandDamp = 0;
	end

end

--- Wall collision ---
local function wallColl(event)
	if(event.phase == "began") then
		local handle = audio.play(bounceSound, {fadein = 0, delay = 0});
		audio.seek(725, handle);
	end
end

-- create()
function scene:create( event )
    local sceneGroup = self.view
    -- Create the golf course.
    -- Create the flicker doodle thingy
-------------------------------------------------------------------------
---------------- THE following was generated by GUMBO -------------------
-------------------------------------------------------------------------
	local physics = require( "physics" )
	physics.start()
	--physics.setDrawMode( "hybrid" )
	--physics.setDrawMode( "debug" )

	---------------------------
	-- Shapes
	---------------------------
	local shape_1 = { -332,637, -334,497, -355,478 }
	shape_1.density = 1; shape_1.friction = 0.3; shape_1.bounce = 0.2; 

	local shape_3 = { -336,495, -244,384, -178,222, -151,84, -160,-78, -180,-209, -237,-403, -320,-516 }
	shape_3.density = 1; shape_3.friction = 0.3; shape_3.bounce = 0.2; 

	local shape_4 = { -319,-515, -334,-636, -320,-638 }
	shape_4.density = 1; shape_4.friction = 0.3; shape_4.bounce = 0.2; 

	local top = { -320,-626, 351,-616, 350,-637, -307,-638 }
	top.density = 1; top.friction = 0.3; top.bounce = 0.2; 

	local shape_5 = { 346,-615, 357,-503, 348,-507 }
	shape_5.density = 1; shape_5.friction = 0.3; shape_5.bounce = 0.2; 

	local topright = { 345,-506, 172,-439, 85,-341, 30,-224, 6,-129, 5,-39, 18,74, 66,186 }
	topright.density = 1; topright.friction = 0.3; topright.bounce = 0.2; 

	local shape_7 = { 66,188, 153,327, 225,411, 281,458, 340,477, 356,476, 351,211 }
	shape_7.density = 1; shape_7.friction = 0.3; shape_7.bounce = 0.2; 

	local shape_8 = { 341,480, 343,637, 354,484, 354,637 }
	shape_8.density = 1; shape_8.friction = 0.3; shape_8.bounce = 0.2; 

	local shape_9 = { 337,474, 358,634, 343,634, 342,616 }
	shape_9.density = 1; shape_9.friction = 0.3; shape_9.bounce = 0.2; 

	local bottomwall = { 342,623, -336,610, -338,632 }
	bottomwall.density = 1; bottomwall.friction = 0.3; bottomwall.bounce = 0.2; 


	local mainBG = display.newImageRect( "arts/golf1bold.png", 720, 1280 )
	mainBG.x = 360
	mainBG.y = 640
	physics.addBody( mainBG, "static", 
	    {density=shape_1.density, friction=shape_1.friction, bounce=shape_1.bounce, shape=shape_1},
	    {density=shape_3.density, friction=shape_3.friction, bounce=shape_3.bounce, shape=shape_3},
	    {density=shape_4.density, friction=shape_4.friction, bounce=shape_4.bounce, shape=shape_4},
	    {density=top.density, friction=top.friction, bounce=top.bounce, shape=top},
	    {density=shape_5.density, friction=shape_5.friction, bounce=shape_5.bounce, shape=shape_5},
	    {density=topright.density, friction=topright.friction, bounce=topright.bounce, shape=topright},
	    {density=shape_7.density, friction=shape_7.friction, bounce=shape_7.bounce, shape=shape_7},
	    {density=shape_9.density, friction=shape_9.friction, bounce=shape_9.bounce, shape=shape_9},
	    {density=bottomwall.density, friction=bottomwall.friction, bounce=bottomwall.bounce, shape=bottomwall}
	)

	local holeGumbo = display.newImageRect( "arts/hole.png", 50, 50 )
	holeGumbo.x = 597
	holeGumbo.y = 85
-------------------------------------------------------------------------
----------------  End of Gumbo - generated code       -------------------
-------------------------------------------------------------------------

	background = mainBG; -- For sake of the generated code.
	background:addEventListener("collision", wallColl);
	hole = holeGumbo;

	setBall(360,1200); -- Set the position of the ball.
	physics.setGravity(0,0)

    narrationText =  display.newText( "Putt!", 340, 100, native.systemFont, 64 )
	narrationText:setFillColor( 1, 0, 0.5 )
	
    sceneGroup:insert(background)
    sceneGroup:insert(hole)
	background:toFront();
	-- Create sensor for detectin when user has landed a hole.
	holeSensor = display.newCircle(hole.x, hole.y, 15)
	physics.addBody(holeSensor, "kinematic", {isSensor = true, radius = 10})
	holeSensor:addEventListener("collision", inTheHole);
	
	-- Create sensor for determining the trojectory vector.
	putter.x = ball.x;
	putter.y = ball.y;

	defaultDamp = ball.linearDamping;
	putter:addEventListener("touch", putterEvent);
	hole:toFront();
	
	-- Set up the scoring system
	if(event.params ~= nil) then
		params.CBGScore = event.params.CBGScore or 0; -- CBGScore
	else
		params.CBGScore = 0;
	end
	
	sceneGroup:insert(holeSensor);
	holeSensor:toBack();
	sceneGroup:insert(narrationText);
	sceneGroup:insert(ball);
	sceneGroup:insert(putter);
	--putter:toBack();

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

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
    -- Remove any scene bodies
    sceneGroup:remove(background)
    sceneGroup:remove(ball)
    sceneGroup:remove(hole)
    sceneGroup:remove(holeSensor)
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
