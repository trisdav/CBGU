
-----------------------------------------------------------------------------------------
--
-- Class.lua
--      In this class the user will have to keep nervous energy stable by using fidget
-- spinner. At regular intervals the teacher will add random characters to a white
-- board. The user will have to tap the characters in sequence on a mock-up keyboard.
--
--
-- Created by Tristan Davis on 11/07/17
-- Last edited by Tristan Davis 11/9/17
-- Last edited by Tristan Davis 11/10/17
--	Last edited 11-16-17
-- Last edited 11/23/17
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local physics = require("physics")
local backButtons = require("objects.menu_button")
local extras = require("objects.extras")
local audio = require("audio")
local blahblahblah = audio.loadSound("arts/165539_1038806-lq.mp3")
--	composer.removeScene("Class")

--------------------------------------------------------------------------
-------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
--------------------------------------------------------------------------
-------
    local galphabetSheetOptions = 
        {
            -- Alpha, Beta, Gama, Delta, Epsilon, Zeta, Eta, Theta, Iota, Kappa, Lambda, Mu, Nu,
            -- Xi, Omicron, Pi, Rho, Sigma Tau, Upsilon, Phi, Chi, Psi, Omega
            frames =
            {
                -- Frame 1, Alpha
                {
                    x = 0,
                    y = 0,
                    width = 83,
                    height = 76
                },
                -- Frame 2
                {
                    x = 120,
                    y = 0,
                    width = 83,
                    height = 76
                },
                -- Frame 3
                {
                    x = 223,
                    y = 0,
                    width = 83,
                    height = 76
                },
                -- Frame 4
                {
                    x = 339,
                    y = 0,
                    width = 83,
                    height = 76
                },
                -- Frame 5
                {
                    x = 453,
                    y = 0,
                    width = 83,
                    height = 76
                },
                -- Frame 6
                {
                    x = 576,
                    y = 0,
                    width = 83,
                    height = 76
                },
                -- Frame 7
                {
                    x = 2,
                    y = 135,
                    width = 83,
                    height = 76
                },
                -- Frame 8
                {
                    x = 116,
                    y = 133,
                    width = 83,
                    height = 76
                },
                -- Frame 9
                {
                    x = 230,
                    y = 135,
                    width = 83,
                    height = 76
                },
                -- Frame 10
                {
                    x = 343,
                    y = 135,
                    width = 83,
                    height = 76
                },
                -- Frame 11
                {
                    x = 450,
                    y = 134,
                    width = 83,
                    height = 76
                },
                -- Frame 12
                {
                    x = 562,
                    y = 134,
                    width = 96,
                    height = 76
                },
                -- Frame 13
                {
                    x = 0,
                    y = 269,
                    width = 83,
                    height = 76
                },
                -- Frame 14
                {
                    x = 121,
                    y = 269,
                    width = 83,
                    height = 76
                },
                -- Frame 15
                {
                    x = 228,
                    y = 266,
                    width = 83,
                    height = 78
                },
                -- Frame 16
                {
                    x = 344,
                    y = 270,
                    width = 85,
                    height = 74
                },
                -- Frame 17
                {
                    x = 458,
                    y = 269,
                    width = 83,
                    height = 76
                },
                -- Frame 18
                {
                    x = 576,
                    y = 269,
                    width = 83,
                    height = 76
                },
                -- Frame 19
                {
                    x = 1,
                    y = 405,
                    width = 83,
                    height = 76
                },
                -- Frame 20
                {
                    x = 100,
                    y = 405,
                    width = 83,
                    height = 76
                },
                -- Frame 21
                {
                    x = 225,
                    y = 405,
                    width = 83,
                    height = 76
                },
                -- Frame 22
                {
                    x = 335,
                    y = 405,
                    width = 83,
                    height = 76
                },
                -- Frame 23
                {
                    x = 455,
                    y = 405,
                    width = 83,
                    height = 76
                },
                -- Frame 24
                {
                    x = 576,
                    y = 405,
                    width = 83,
                    height = 76
                }
            }
        }


local galphabetSheet = graphics.newImageSheet("arts/galphabet.png", galphabetSheetOptions)

local ansKey = {}; -- These are the sprites of the answer keys.
local indicatorKey = {}; -- These are used to indicate progress.
local energyUpdateTimer;
local blah = 1; -- The teacher chatter will be channel 1.
local whir = 2; -- The fidget chatter will be channel 2.
local taps = 3; -- The keyboard chatter will be channel 3.
local teacher = display.newGroup(); -- Teacher sprite.


--------------- Velocity bar -------------------
local numKeys = 5;
local energyBar;
local myFidget;
local tired = {};
local tally = 0;

local function updateVel(event)
    energyBar:setProgress(myFidget.angularVelocity/5580) --5,600 approx max angular vel
    if(energyBar:getProgress() > .5) then
        for i = 1, 3, 1 do
            tired[i].isVisible = false;
        end
    elseif(energyBar:getProgress() < .6 and energyBar:getProgress() > .4) then
        tired[1].isVisible = true;
        tired[2].isVisible = false;
        elseif(energyBar:getProgress() < .4 and energyBar:getProgress() > .2) then
            tired[1].isVisible = false;
            tired[2].isVisible = true;
            tired[3].isVisible = false;
            elseif(energyBar:getProgress() <  .2) then
                tired[2].isVisible = false;
                tired[3].isVisible = true;
            end
end

-- Teacher arm animation.
local function swingArm(event)
    transition.to(teacher.arm, {time = 500, rotation = 60});
    transition.to(teacher.arm, {time = 500, delay = 500, rotation = 10});
end
local function firstSwing()
    transition.to(teacher.arm, {time = 500, rotation = 60});
    transition.to(teacher.arm, {time = 500, delay = 500, rotation = 10});
    timer.performWithDelay(1000, swingArm, 60);
end
-------------- Match character functions ----------
local currKey;
local boardKeys = {};
local active = true
local function genKeys(event)
    teacher.head:play();
    firstSwing();
    audio.play(blahblahblah, {channel = blah, loops = 1 })
    for i = 1, numKeys, 1 do
        boardKeys[i] = math.random(1,24);
    end

    for i = 1, numKeys, 1 do
        ansKey[i]:setFrame(boardKeys[i]);
        ansKey[i].isVisible = true;
        indicatorKey[i].isVisible = true;
    end
    currKey = 1;

end
local function checkKey(event)
    if(active == true) then
        if(event.phase == "ended") then
            --print(event.target.id .. " == " .. boardKeys[currKey])
            if(event.target.id == boardKeys[currKey]) then
                indicatorKey[currKey]:setSequence("green"); -- Green
                currKey = currKey + 1;
                tally = tally + 1;
                if(currKey > numKeys) then
                    currKey = 1;
                    for i = 1, numKeys, 1 do
                        ansKey[i].isVisible = false
                        indicatorKey[i].isVisible = false;
                        indicatorKey[i]:setSequence("red")
                    end
                    teacher.head:pause();
                    audio.stop(blah);
                    timer.performWithDelay(2000, genKeys);
                end
            end
        end
    end
end




-------- Create keyboard ---------
function addKeyboard(grp)
        -- Initialize the image
         key = {}
         keyImage = {}
        --Create background for the keys
        local greyRect = display.newRect(360, display.contentHeight - 100, display.contentWidth, 600)
        greyRect:setFillColor(.6,.6,.6)
        grp:insert(greyRect)
        -- Create the button part of the key.
        for btnIndex = 1, 24, 1 do
            key[btnIndex] = widget.newButton( { x = 50, y = 1030,
                                                id = btnIndex,
                                                shape = "roundedRect",
                                                cornerRadius = 10,
                                                fillColor = {default = {.6,.6,.6, 1}, over = {.9,.9,.9, .4} },
                                                strokeColor = {default = {.9,.9,.9, 1}, over = {1,1,1, .4} },
                                                strokeWidth = 6,
                                                width = 85,
                                                height = 85
                                                } )
            if(btnIndex <= 7) then
                key[btnIndex].x = 60 + (100 * (btnIndex - 1));
                key[btnIndex].y = 930;
            elseif (btnIndex > 7 and btnIndex <= 14) then
                key[btnIndex].x = 60 + (100 * ((btnIndex - 1) -(7)));
                key[btnIndex].y = 930 + 95;
            elseif (btnIndex > 14 and btnIndex <= 21) then
                key[btnIndex].x = 60 + (100 * ((btnIndex - 1) -(14)));
                key[btnIndex].y = 930 + 95 * 2;
            elseif (btnIndex > 14) then
                key[btnIndex].x = 260 + (100 * ((btnIndex - 1) -(21)));
                key[btnIndex].y = 930 + 95 * 3;
            end
            grp:insert(key[btnIndex])
        end

        -- Create the letter part of the key.
        for keyIndex = 1, 24, 1 do
            local theName = "Key: " .. keyIndex;
            keyImage[keyIndex] = display.newSprite(galphabetSheet, {name = theName, start = 1, count = 24})
            keyImage[keyIndex]:setFrame(keyIndex)
            keyImage[keyIndex]:scale(.9,.9)
            
            if(keyIndex <= 7) then
                keyImage[keyIndex].x = 60 + (100 *(keyIndex - 1));
                keyImage[keyIndex].y = 930;
            elseif (keyIndex > 7 and keyIndex <= 14) then
                keyImage[keyIndex].x = 60 + (100 * ((keyIndex - 1) -(7)));
                keyImage[keyIndex].y = 930 + 95;
            elseif (keyIndex > 14 and keyIndex <= 21) then
                keyImage[keyIndex].x = 60 + (100 * ((keyIndex - 1) -(14)));
                keyImage[keyIndex].y = 930 + 95 * 2;
            elseif (keyIndex > 14) then
                keyImage[keyIndex].x = 260 + (100 * ((keyIndex - 1) -(21)));
                keyImage[keyIndex].y = 930 + 95 * 3;
            end
            grp:insert(keyImage[keyIndex])
        end
        for i = 1, 24, 1 do
            key[i]:addEventListener("touch", checkKey);
        end
end

local function spin(event)

    currentOmega = myFidget.angularVelocity;
    myFidget.angularVelocity = 250 + currentOmega
end


local function gameOver()
    active = false;
    timer.cancel(energyUpdateTimer)
    audio.stop(blah);
    teacher.head:pause();
    myFidget:removeEventListener("tap", spin)
    physics.stop();
    local params = {};
    params.classScore = tally;
    local button = backButtons.newHscore("Class", -- The name of the current scene
                                            params) -- Parameters, e.g. params.cafeteriaScore
end

local function startGame(bar)
    timer.performWithDelay((1000 * 60 ), gameOver); -- This game is timed.
    bar.timeScale = (1); -- Default time is 1 minute.
    bar:play();
end
        

-- local forward references should go here
--------------------------------------------------------------------------
-------
-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    physics.start()
    --physics.setDrawMode("hybrid")
    -- Add background
    local bg = display.newImage("arts/cafeteriaBG1.png", 360, 640)
    sceneGroup:insert(bg);
    -- Add time indicator
    local timeImageSheet = graphics.newImageSheet("arts/barfill.png", extras.getBarFrames())
    local timeSprite = display.newSprite(timeImageSheet, extras.getBarSequence())
    timeSprite.anchorY = .5;
    timeSprite.anchorX = 0;
    timeSprite.x = 65;
    timeSprite.y = 111;
    timeSprite:scale(1.164,1.5)

    -- add whiteboard
    local board = display.newImage("arts/whiteboard.png")
    board.x = display.contentCenterX - 50;
    board.y = display.contentCenterY - 250;
    board:scale(1.4,1.4)
    sceneGroup:insert(board);

    -- Add teacher
    --local head;
    --local body;
    --local arm;
    teacher.head, teacher.body, teacher.arm = extras.getTeacherSprite();
    -- Head manipulations.
    teacher.head.xScale = -1;
    teacher.head.anchorY = 1; 
    teacher.head.y = -208;
    teacher.head.x = 20;
    -- Arm manipulations.
    teacher.arm.x = 20;
    teacher.arm.y = -125;
    teacher.arm.anchorX = 1;
    teacher:insert(teacher.head);
    teacher:insert(teacher.body);
    teacher:insert(teacher.arm);
    teacher.x = display.contentCenterX + 250;
    teacher.y = display.contentCenterY - 150;
    teacher:scale(.5,.5)
    sceneGroup:insert(teacher);

    -- Add students
    local students = display.newImage("arts/students.png");
    students.x = display.contentCenterX;
    students.y = display.contentCenterY;
    students:scale(1.4,1.4)
    sceneGroup:insert(students);
    -- Add fidget spinner
    physics.setGravity(0,0)
    local myOptions = {
                        width = 200, height = 200
    }
    local currentOmega = 0;
    myFidget = display.newImage("arts/educational_instrument.png" )
    myFidget.x = display.contentCenterX
    myFidget.y = display.contentCenterY
    physics.addBody(myFidget, "dynamic", {isSensor = true})
    myFidget.angularDamping = .2
    myFidget:addEventListener("tap", spin)

    sceneGroup:insert(myFidget)
    -- Add keyboard
    addKeyboard(sceneGroup)
    -- Position fidget spinner
    myFidget.x = display.contentCenterX - 200;
    myFidget.y = display.contentCenterY + 100;
	myFidget.angularVelocity = 5500
 
    -- Create the energy bar.
    energyBar = widget.newProgressView(
    {
        x = 5,
        y = 400,
        width = 700,
        isAnimated = true
    })
    energyBar:rotate(270)
    energyUpdateTimer = timer.performWithDelay(500, updateVel, 0)

    -- Initialize answer key
    -- Initialize white board for ans key
    for i = 1, 10, 1 do
        ansKey[i] = display.newSprite(galphabetSheet, {name = theName, start = 1, count = 24})
        ansKey[i]:scale(.7,.7)
    end
    
    -- Draw answer keys
    for i = 1, 5, 1 do
        -- Background indicator of progress.
        indicatorKey[i] = extras.getRedGreenSprite();
        indicatorKey[i]:setSequence("red")
        indicatorKey[i].x = (130*i) - 50;
        indicatorKey[i].y = 220;
        indicatorKey[i]:scale(.8,.8);
        indicatorKey[i].isVisible = false;
        -- The keys
        ansKey[i].isVisible = false;
        ansKey[i].x = (130 * i) - 50;
        ansKey[i].y = 220;
        sceneGroup:insert(indicatorKey[i]);
        indicatorKey[i]:toFront();
        sceneGroup:insert(ansKey[i]);
        ansKey[i]:toFront();
    end
    for i = 6, 10, 1 do
        ansKey[i].isVisible = false;
        ansKey[i].x = 130 + (130 * (i%6)) - 50;
        ansKey[i].y = 300;
        sceneGroup:insert(ansKey[i]);
        ansKey[i]:toFront();
    end
    timer.performWithDelay(2000, genKeys)
    tired[1] = display.newImage("arts/tiredOverlay.png");
    tired[2] = display.newImage("arts/tiredOverlay2.png");
    tired[3] = display.newImage("arts/tiredOverlay3.png")

    sceneGroup:insert(timeSprite) -- Insert time sprite here to keep layered properly.

    for i = 1, 3, 1 do
        tired[i].x = display.contentCenterX;
        tired[i].y = display.contentCenterY;
        sceneGroup:insert(tired[i]);
        tired[i]:toFront()
        tired[i].isVisible = false;
    end
    sceneGroup:insert(energyBar)
    startGame(timeSprite);

    -- audio things
    audio.setVolume(.1, {channel = blah})
-- Initialize the scene here.
end
-- "scene:show()"
function scene:show( event )
    local phase = event.phase

    if ( phase == "will" ) then
    -- Called when the scene is still off screen (but is about to come on screen.)
    elseif ( phase == "did" ) then

       -- noteBook:scale(.5, .5)
    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    end
end
-- "scene:hide()"
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
    -- Called immediately after scene goes off screen.
    end
end
-- "scene:destroy()"
function scene:destroy( event )
    local sceneGroup = self.view
	display.remove(myFidget);
    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end
--------------------------------------------------------------------------
-------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
--------------------------------------------------------------------------
-------
return scene