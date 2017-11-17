local composer = require( "composer" )
local widget = require("widget")
local physics = require("physics")

 local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
--holds basketballs
local ballTable = {}

--variables for velocity tracking
local speedX = 0
local speedY = 0
local prevTime = 0
local prevX = 0
local prevY = 0
local gameOver = false

--gets the velocity of the ball
function trackVelocity(event)
    local timePassed = event.time - prevTime
    prevTime = prevTime + timePassed
     local index = #ballTable
     if ballTable[index] ~= nil then
      speedX = (ballTable[index].x - prevX)/(timePassed/1000)
      speedY = (ballTable[index].y - prevY)/(timePassed/1000)

      prevX = ballTable[index].x
      prevY = ballTable[index].y
    end
end

--handles dragging the ball
local function moveBall( event )
    local ball = event.target

    local phase = event.phase
    if "began" == phase then
        display.getCurrentStage():setFocus( ball )

        -- Store initial position
        ball.x0 = event.x - ball.x
        ball.y0 = event.y - ball.y

        -- Avoid gravitational forces
        event.target.bodyType = "kinematic"

        -- Stop current motion, if any
        event.target:setLinearVelocity( 0, 0 )
        event.target.angularVelocity = 0

    else
        if "moved" == phase then
            ball.x = event.x - ball.x0
            ball.y = event.y - ball.y0
            if ball.x > display.contentCenterX then
              ball.x = display.contentCenterX
            end
            if ball.y < display.contentCenterY then
              ball.y = display.contentCenterY
            end
        elseif "ended" == phase or "cancelled" == phase then
            ball:setLinearVelocity(speedX/5, speedY/5)
            display.getCurrentStage():setFocus( nil )
            ball:removeEventListener("touch",moveBall)
            event.target.bodyType = "dynamic"
        end
    end

    return true
end

--creates a basketball
local function createBall()
  local index = #ballTable + 1
  ballTable[index]= display.newCircle( 50, 1000, 50)
  ballTable[index]:setFillColor(1, (140/255), 0)
  physics.addBody(ballTable[index], "kinematic", {density = .8, friction = .3, bounce = .6, radius = 50})
  ballTable[index]:addEventListener("touch", moveBall)
  background:toFront()
  ballTable[index]:toFront()
end

--destroys the basketball
local function destroyBall()
  local index = #ballTable
  display.remove(ballTable[index])
  --creates a new ball if the game isn't over yet
  if gameOver == false then
      createBall()
  end
end

--detects collision between ball and floor
local function ballFloorCollision(event)
  if event.phase == "began" then
    --delete with a timer because it crashes otherwise
    local t = timer.performWithDelay(2, destroyBall)
  end
end

--function to start the game
local function Start(event)
   if(event.phase == "ended") then
     display.remove(b_start)
     createBall()
   end
end

--will start the timer
local function startTimer()
  t = timer.performWithDelay()
end

--button to start game
local bo_start = { left = display.contentCenterX/2, --center = width/2
                  top = display.contentCenterY/4,
                  id = "Start",
                  label = "Start Game",
                  onEvent = Start,
                  shape = "roundedRect",
                  width = 400,
                  height = 160,
                  cornerRadius = 30,
                  fillColor = {default = {1,0,0,1}, over = {1,0.1,0.7,0.4}},
                  strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}},
                  strokeWidth = 10
               }



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    physics.start()
    physics.setGravity( 0, 18 )
    --physics.setDrawMode( "hybrid" )
    Runtime:addEventListener("enterFrame", trackVelocity)
    --set background image
    background  = display.newImage("courtBackground.png")
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    background:toBack()

    --creates the backboard
    backboard = display.newRect(714, 320, 20, 300)
    backboard:setFillColor(0, 153/255, 51/255)
    physics.addBody( backboard, "static")

    --creates the front of the rim
    rimFront = display.newRoundedRect( 510, 400, 10, 10, 10)
    rimFront:setFillColor(1, (130/255), 0)
    physics.addBody(rimFront, "static")

    --creates the back of the rim
    rimBack1 = display.newRect( 690, 419, 30, 50)
    rimBack1:setFillColor(1, (130/255), 0)
    rimBack2 = display.newRect(675, 400, 55, 10)
    rimBack2:setFillColor(1, (130/255), 0)
    physics.addBody(rimBack1, "static")
    physics.addBody(rimBack2, "static")

    --creates the top of the rim
    rimTop = display.newRect( 580, 400, 135, 10)
    rimTop:setFillColor(1, (130/255), 0)
    rimTop:toFront()

    --creates the net
      --left vertical piece
    netPart1 = display.newRect( 510, 455, 2, 100 )
    netPart1:setFillColor(194/255, 194/255, 163/255)
    physics.addBody(netPart1, "static")
      --right vertical piece
    netPart2 = display.newRect( 660, 455, 2, 100)
    netPart2:setFillColor(194/255, 194/255, 163/255)
    physics.addBody(netPart2, "static")
      --bottom part of net
    netBottom = display.newRect(585, 505, 2, 150)
    netBottom.rotation = 90
      --the rest of the net
    net = display.newImage("net.png", 585, 455)

    --creates the floor of the court
    courtBottom = display.newRect( display.contentCenterX, 1200, display.contentWidth, 180)
    courtBottom:setFillColor((245/255),(211/255),(139/255))
    courtBottom:addEventListener("collision", ballFloorCollision)

    --creates a wall to the right so the ball doesn't go off screen
    rightWall = display.newRect( 724, display.contentCenterY, 10, display.contentHeight )
    physics.addBody(rightWall, "static")

    --creates a ceiling
    ceiling = display.newRect( display.contentCenterX, -5, display.contentWidth, 10 )
    physics.addBody(ceiling, "static")

    --creates a left wall
    leftWall = display.newRect( -10, display.contentCenterY, 10, display.contentHeight)
    physics.addBody(leftWall, "static")

    --display start button
    b_start = widget.newButton(bo_start)
    b_start._view._label.size = 64

    local bg = display.newImage("arts/cafeteriaBG1.png", 360, 640)
    sceneGroup:insert(bg);
    local timeBar = display.newImage("arts/barfill.png", 355, 110)
    timeBar:scale(1.16,1.3)
    sceneGroup:insert(timeBar);
    timeBar:toBack();

    physics.addBody(courtBottom, "static")
    sceneGroup:insert(backboard)
    sceneGroup:insert(courtBottom)
    sceneGroup:insert(rimFront)
    sceneGroup:insert(rimTop)
    sceneGroup:insert(rimBack1)
    sceneGroup:insert(rimBack2)
    sceneGroup:insert(netPart1)
    sceneGroup:insert(netPart2)
    sceneGroup:insert(netBottom)
    sceneGroup:insert(net)
    background:toFront()
    net:toFront()
    netBottom:toFront()

    --creates the initial basketball
    --createBall()
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
