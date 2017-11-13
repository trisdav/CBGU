--[[
		CBG.lua
		created by Tristan Davis 11/11/17
		
		This file will manage the run time events of the cat berry greens.
]]


local composer = require( "composer" )
local golfObjects = require("objects.golfLevels")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local putter = display.newCircle(0,0,600); -- used for putting
local putterLine;
local speedAmp = 4; -- Used to increase the max/min speed.
local checkTimer;
local defaultDamp;
local narrationText;
local strokeCount = 1;
local win = 0;
local currentLevel;

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
-- Will set up the next level.




---- Is moving will check to see if the ball is in motion still. if it is not
-- it will allow the user to put again.
local function isMoving(event)
	local xv,yv = golfObjects.ball:getLinearVelocity();
		xv = math.abs(xv);
		yv = math.abs(yv);
		if(win == 0) then
			narrationText.text = "Current velocity: " .. math.round(xv + yv)
		end
	-- If the ball is close to stopping increase damping to prevent 'creeping'
	if(xv+yv < 400) then
		golfObjects.ball.linearDamping = 1;
		golfObjects.ball.angularDamping = 1;

	elseif(xv + yv < 200) then
		print("slow down!")
		golfObjects.ball.linearDamping = 2;
		golfObjects.ball.angularDamping = 2; 
	elseif(xv + yv < 50) then
		print("Stop!!")
		golfObjects.ball:setLinearVelocity(0,0)
		golfObjects.ball.angularVelocity = 0
	end

	-- if ball is no longer in motion.
	if(xv == 0 and yv == 0) then
		golfObjects.ball.linearDamping = defaultDamp;
		golfObjects.ball.angularDamping = defaultDamp;
		timer.cancel(checkTimer); -- Stop checking to see if ball is in motion.
		-- Set the putter to the new ball positon
		putter.x = golfObjects.ball.x;
		putter.y = golfObjects.ball.y;
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
		local deltaX = event.xStart + event.x;
		local deltaY = event.yStart + event.y;
		-- Normalize positions
		deltaX = deltaX - golfObjects.ball.x;
		deltaY = deltaY - golfObjects.ball.y;
		-- If a line already exists remove it.
		if(putterLine ~= nil) then
			display.remove(putterLine);
		end
		putterLine = display.newLine(golfObjects.ball.x, golfObjects.ball.y, deltaX, deltaY);
		putterLine.strokeWidth = 8;
		putterLine:setStrokeColor(0,0,1)
	end
	if(event.phase == "ended") then
		putter.isVisible = false; -- Temporarily remove putter.
		-- Get change in x and y
		local deltaX = event.x - event.xStart;
		local deltaY = event.y - event.yStart;
		-- set ball velocity
		golfObjects.ball:setLinearVelocity(deltaX * speedAmp, deltaY * speedAmp)
		putterLine:removeSelf();
		-- while ball is in motion check to see if it is still in motion
		checkTimer = timer.performWithDelay(50, isMoving, 0) 
	end
end

local function nextLevel()

end

---- Will handle the times the player manages to land the ball in the hole.
local function inTheHole(event)

	if(event.other == golfObjects.ball) then
		golfObjects.ball:setLinearVelocity(0,0);
		golfObjects.ball.angularVelocity = 0;
		transition.to(event.other, {time = 150, x = golfObjects.hole.x, y = golfObjects.hole.y})
		narrationText.text = "Hole in: ".. strokeCount;
		win = 1;
		--print("Here")
		timer.performWithDelay(2000, nextLevel)
	end
end

-- create()
function scene:create( event )
    local sceneGroup = self.view
    -- Create the golf course.
    -- Create the flicker doodle thingy
	putter:toBack();
	currentLevel = (event.params.golfLevel or 1)
    golfObjects.getLevel(currentLevel);
    narrationText =  display.newText( "Putt!", 340, 100, native.systemFont, 64 )
	narrationText:setFillColor( 1, 0, 0.5 )


    sceneGroup:insert(golfObjects.background)
    sceneGroup:insert(golfObjects.hole)
	golfObjects.background:toFront();
	putter.x = golfObjects.ball.x;
	putter.y = golfObjects.ball.y;
	defaultDamp = golfObjects.ball.linearDamping;
	putter:addEventListener("touch", putterEvent);
	golfObjects.hole:toFront();
	local holeSensor = display.newCircle(golfObjects.hole.x, golfObjects.hole.y, 15)
	holeSensor:toBack();
	physics.addBody(holeSensor, "kinematic", {isSensor = true, radius = 10})
	holeSensor:addEventListener("collision", inTheHole);
	sceneGroup:insert(holeSensor);
	holeSensor:toBack();
	sceneGroup:insert(narrationText);
	sceneGroup:insert(golfObjects.ball);
	sceneGroup:insert(putter);
	putter:toBack();
    --sceneGroup:insert(golfObjects.walls)
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
    sceneGroup:removeSelf();
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
