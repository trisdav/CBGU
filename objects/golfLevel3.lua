--[[
	golfLevels.lua 
	Created by Tristan Davis 11/11/17

	This file will hold all the level data for the various golf levels to be implemented
	in the cat berry greens.

]]


local composer = require( "composer" )

local scene = composer.newScene()

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
	--Remove scene objects
	composer.removeScene("objects.golfLevel3")

	if(transOpt.params.golfLevel > 2) then
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
		putter.isVisible = true; -- Return the putter.
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
	local LeftBlock = { -357,-335, -112,-325, -117,-143, -358,-152 }
	LeftBlock.density = 1; LeftBlock.friction = 0.3; LeftBlock.bounce = 0.2; 

	local shape_3 = { -355,-338, -355,-440, -359,-440 }
	shape_3.density = 1; shape_3.friction = 0.3; shape_3.bounce = 0.2; 

	local RightBlock = { 355,-333, -41,-321, -53,-161, 357,-177 }
	RightBlock.density = 1; RightBlock.friction = 0.3; RightBlock.bounce = 0.2; 

	local shape_6 = { 354,-178, 352,636, 358,637 }
	shape_6.density = 1; shape_6.friction = 0.3; shape_6.bounce = 0.2; 

	local shape_7 = { -357,-442, -355,-639, -359,-640 }
	shape_7.density = 1; shape_7.friction = 0.3; shape_7.bounce = 0.2; 

	local Top = { -355,-635, -356,-639, 359,-636 }
	Top.density = 1; Top.friction = 0.3; Top.bounce = 0.2; 

	local shape_8 = { 355,-335, 352,-637, 357,-637 }
	shape_8.density = 1; shape_8.friction = 0.3; shape_8.bounce = 0.2; 

	local shape_9 = { -355,-152, -354,632, -358,634 }
	shape_9.density = 1; shape_9.friction = 0.3; shape_9.bounce = 0.2; 

	local Bottom = { -356,634, 352,631, 354,638 }
	Bottom.density = 1; Bottom.friction = 0.3; Bottom.bounce = 0.2; 


	local mainBG = display.newImageRect( "arts/golf-l3.png", 720, 1280 )
	mainBG.x = 360
	mainBG.y = 640
	physics.addBody( mainBG, "static", 
		{density=LeftBlock.density, friction=LeftBlock.friction, bounce=LeftBlock.bounce, shape=LeftBlock},
		{density=shape_3.density, friction=shape_3.friction, bounce=shape_3.bounce, shape=shape_3},
		{density=RightBlock.density, friction=RightBlock.friction, bounce=RightBlock.bounce, shape=RightBlock},
		{density=shape_6.density, friction=shape_6.friction, bounce=shape_6.bounce, shape=shape_6},
		{density=shape_7.density, friction=shape_7.friction, bounce=shape_7.bounce, shape=shape_7},
		{density=Top.density, friction=Top.friction, bounce=Top.bounce, shape=Top},
		{density=shape_8.density, friction=shape_8.friction, bounce=shape_8.bounce, shape=shape_8},
		{density=shape_9.density, friction=shape_9.friction, bounce=shape_9.bounce, shape=shape_9},
		{density=Bottom.density, friction=Bottom.friction, bounce=Bottom.bounce, shape=Bottom}
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
