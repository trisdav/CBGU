--[[
	golfLevels.lua 
	Created by Tristan Davis 11/11/17

	This file will hold all the level data for the various golf levels to be implemented
	in the cat berry greens.
 
	TODO:
	1. Update the nextLevel function to include the latest level.
	2. Update the scene:destroy function to destroy all old physics objects.
	3. Add any objects to the scene group.
	--- Note ---
	This is old. It needs to be updated.
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
local Sand;

-------------- Transition between courses -----------------
local transOpt = {
                    effect = "fade",
                   	time = 400,
                    params = { golfLevel  = 1 }
                    }

local function nextLevel()
	transOpt.params.golfLevel = transOpt.params.golfLevel + 1;
	--Remove scene objects
	composer.removeScene("objects.golfLevel2")

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

-------------------------------------------------------------------------
----------------  End of Gumbo - generated code       -------------------
-------------------------------------------------------------------------

	background = mainBG;
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
	putter:toBack();
	sceneGroup:insert(Sand);
	Sand:toBack();
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
    sceneGroup:remove(background)
    sceneGroup:remove(ball);
    sceneGroup:remove(holeSensor)
    sceneGroup:remove(Sand)
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
