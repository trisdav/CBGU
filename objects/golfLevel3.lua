--[[
	golfLevels.lua 
	Created by Tristan Davis 11/11/17

	This file will hold all the level data for the various golf levels to be implemented
	in the cat berry greens.

]]


local composer = require( "composer" )
local backButtons = require("objects.menu_button")
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
local isFinal = true; -- If this is the final coarse
local thisLevel = "objects.golfLevel3"; -- Set this so that the current scene name is known.
local params = {};
params.CBGScore = nil;

-- Add any physics bodies here, it is necessary for removal of the scene.
local ball;
local hole;
local holeSensor;
local background;
local miscBodies = {}; -- A catch all for any bodies needing removal at end of scene.

-------------- Transition between courses -----------------
local transOpt = {
                    effect = "fade",
                   	time = 400,
                    params = { golfLevel  = 3 }
                    }

local function nextLevel()
	transOpt.params.golfLevel = transOpt.params.golfLevel + 1;
	transOpt.params.CBGScore = (strokeCount) + params.CBGScore;
	
	--Remove scene objects
	if(isFinal) then
		--composer.removeScene(thisLevel)
		params.CBGScore = 103 - math.round(transOpt.params.CBGScore);
		local button = backButtons.newHscore(thisLevel, params);
		button.isVisible = true;
	elseif(transOpt.golfLevel > 3 ) then
		composer.gotoScene("objects.golfLevel1");
	elseif(transOpt.params.golfLevel == 2) then
		composer.gotoScene("objects.golfLevel2");
	elseif(transOpt.params.golfLevel == 1) then
		composer.gotoScene("objects.golfLevel1");
	elseif(transOpt.params.golfLevel == 3) then
		composer.gotoScene("objects.golfLevel3")
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
	print("Play sound")
		local handle = audio.play(puttSound, {fadein = 0, delay = 0 });
		audio.seek(1550, handle);
		print(handle)
		local function stop(event)
			print(handle)
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
		--print("Here")
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
	local Bottom = { 324,630, -317,627, -318,635 }
	Bottom.density = 1; Bottom.friction = 0.3; Bottom.bounce = 0.2; 

	local Left = { -312,626, -308,-163, -318,-167 }
	Left.density = 1; Left.friction = 0.3; Left.bounce = 0.2; 

	local Leftmid = { -312,-163, -120,-146, -112,-324, -322,-335 }
	Leftmid.density = 1; Leftmid.friction = 0.3; Leftmid.bounce = 0.2; 

	local lefttop = { -314,-339, -310,-635, -355,-640 }
	lefttop.density = 1; lefttop.friction = 0.3; lefttop.bounce = 0.2; 

	local top = { -314,-636, 343,-634, 356,-640 }
	top.density = 1; top.friction = 0.3; top.bounce = 0.2; 

	local righttop = { 343,-636, 341,-335, 356,-332 }
	righttop.density = 1; righttop.friction = 0.3; righttop.bounce = 0.2; 

	local rightmid = { 342,-335, -42,-319, -52,-159, 125,-174, 216,-177, 275,-180, 344,-179 }
	rightmid.density = 1; rightmid.friction = 0.3; rightmid.bounce = 0.2; 

	local rightbottom = { 339,-182, 320,633, 336,633 }
	rightbottom.density = 1; rightbottom.friction = 0.3; rightbottom.bounce = 0.2; 


	local mainBG = display.newImageRect( "arts/golf3bold.png", 720, 1280 )
	mainBG.x = 360
	mainBG.y = 640
	physics.addBody( mainBG, "static", 
	    {density=Bottom.density, friction=Bottom.friction, bounce=Bottom.bounce, shape=Bottom},
	    {density=Left.density, friction=Left.friction, bounce=Left.bounce, shape=Left},
	    {density=Leftmid.density, friction=Leftmid.friction, bounce=Leftmid.bounce, shape=Leftmid},
	    {density=lefttop.density, friction=lefttop.friction, bounce=lefttop.bounce, shape=lefttop},
	    {density=top.density, friction=top.friction, bounce=top.bounce, shape=top},
	    {density=righttop.density, friction=righttop.friction, bounce=righttop.bounce, shape=righttop},
	    {density=rightmid.density, friction=rightmid.friction, bounce=rightmid.bounce, shape=rightmid},
	    {density=rightbottom.density, friction=rightbottom.friction, bounce=rightbottom.bounce, shape=rightbottom}
	)


	local movingBlock = display.newImageRect( "arts/blockLines.png", 300, 182 )
	movingBlock.x = 150
	movingBlock.y = 817
	physics.addBody( movingBlock, "static", { density=1, friction=0.3, bounce=0.2 } )

	local holeGumbo = display.newImageRect( "arts/hole.png", 49, 49 )
	holeGumbo.x = 288
	holeGumbo.y = 110
-------------------------------------------------------------------------
----------------  End of Gumbo - generated code       -------------------
-------------------------------------------------------------------------
	local blockTimer = {} -- For keeping track of the transition phases.
	local function rightTrans(event)
	 -- 150 to 550
		transition.to(movingBlock, {time = 1000, x = 550})
	end
	local function leftTrans(event)
		transition.to(movingBlock, {time = 1000, x = 150})
	end
	blockTimer[1] = timer.performWithDelay(1000, rightTrans, 0);
	local function secondTimer(event)
			blockTimer[2] = timer.performWithDelay(1000, leftTrans, 0);
	end
	 -- This is necessary for creating an offset between block timer 1 and 2
	timer.performWithDelay(1000, secondTimer);

	background = mainBG;
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

	-- Bodies that will need to be removed.
	miscBodies[1] = mainBG;
	miscBodies[2] = ball;
	miscBodies[3] = holeSensor;
	miscBodies[4] = movingBlock;
	-- Code here runs when the scene is first created but has not yet appeared on screen

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
	for i = 1, 4, 1 do -- 4 is the current body count.
		display.remove(miscBodies[i]);
	end
	physics.stop();
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
