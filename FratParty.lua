local composer = require( "composer" )
local widget = require("widget")
local physics = require("physics")
local menuButton = require("objects.menu_button")
local backButtons = require("objects.menu_button")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

 local params = {}
local score = 1
local glug = audio.loadStream("arts/glug.wav")
local gasp = audio.loadStream("arts/gasp.wav")
local function gameOver(event)
    b_left:removeSelf()
    b_right:removeSelf()
    -- Game over things.
     params.partyScore = score
    local button = backButtons.newHscore("FratParty", -- The name of the current scene
                                            params) -- Parameters, e.g. params.cafeteriaScore
    button.hscore.isVisible = false;
    local function exitVis(event)
        button.hscore.isVisible = true;
    end
    timer.performWithDelay(100, exitVis)
    -- TODO: Add a button to return to campus.
end

local xCenter =display.contentCenterX
local yCenter =display.contentCenterY
local function drink()
    score = score+1
    goalText.text = "Inebriation: " .. score
    --print(pivotJoint.jointAngle)
    audio.play(glug)
    t = timer.performWithDelay(1000,drink,1)
    if(pivotJoint.jointAngle >30 or pivotJoint.jointAngle < -30) then
        timer.cancel(t)
        pivotJoint:removeSelf()
        audio.pause()
        audio.play(gasp)
        timer.performWithDelay(1000,gameOver)
    end

end

local function Start(event)
     if(event.phase == "ended") then
    display.remove(b_start)
    timer.performWithDelay(1000,drink, 1)
    stickman:applyLinearImpulse(.01,0,stickman.x,stickman.y)
end
end
local function LeftPush(event)
if event.phase == "began" then
stickman:applyForce(-1, 0, stickman.x,stickman.y)
elseif event.phase == "ended" then
stickman:applyForce(0,0,stickman.x,stickman.y)
end
end

local function RightPush(event)
if event.phase == "began" then
stickman:applyForce(1, 0, stickman.x,stickman.y)
elseif event.phase == "ended" then
stickman:applyForce(0,0,stickman.x,stickman.y)
end
end

local bo_start = { left = xCenter - 200, --center = width/2
                     top = yCenter - 450,
                     id = "Start",
                     label = "Start",
                     onEvent = Start,
                     shape = "roundedRect",
                     width = 400,
                     height = 160,
                     cornerRadius = 30,
                     fillColor = {default = {1,0,0,1}, over = {1,0.1,0.7,0.4}},
                     strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}},
                     strokeWidth = 10
                  }
local bo_left = {    left = 0,
                     top = display.contentHeight - 160,
                     id = "Left",
                     label = "Left",
                     onEvent = LeftPush,
                     shape = "roundedRect",
                     width = 400,
                     height = 160,
                     cornerRadius = 30,
                     fillColor = {default = {1,0,0,1}, over = {1,0.1,0.7,0.4}},
                     strokeColor = {default = {1,0.4,0,1}, over = {0.8,0.8,1,1}},
                     strokeWidth = 10
                  }
local bo_right = { left = display.contentWidth -400,
                     top = display.contentHeight -160,
                     id = "Right",
                     label = "Right",
                     onEvent = RightPush,
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
    physics.start()
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local bg = display.newImage("arts/fratBG.png",display.contentCenterX,display.contentCenterY)
    sceneGroup:insert(bg)
    local keg = display.newImage("arts/keg.png",display.contentCenterX+40,display.contentCenterY + 300)
    physics.addBody(keg, "static")
    sceneGroup:insert(keg)
    local imageOutline = graphics.newOutline( 2, "arts/stickman.png" )
    stickman = display.newImage("arts/stickman.png",keg.x,display.contentCenterY +20)
    sceneGroup:insert(stickman)
    physics.addBody(stickman,"dynamic",{ outline=imageOutline})
    pivotJoint = physics.newJoint( "pivot", keg, stickman, keg.x, keg.y )
    pivotJoint.isMotorEnabled = true
    b_start    = widget.newButton(bo_start)
    b_start._view._label.size = 64
    sceneGroup:insert(b_start)
    b_left    = widget.newButton(bo_left)
    b_left._view._label.size = 64
    sceneGroup:insert(b_left)
    b_right    = widget.newButton(bo_right)
    b_right._view._label.size = 64
    sceneGroup:insert(b_right)
    goalText = display.newText( "Inebriation: " .. score, display.contentCenterX, 40 )
    goalText:setFillColor(0,0,0)
    goalText.size = 45
    sceneGroup:insert(goalText)
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
