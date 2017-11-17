
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
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local physics = require("physics")
display.setDefault("background", 1, 1, 1)
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


--------------- Velocity bar -------------------
local numKeys = 5;
local energyBar;
local myFidget;
local tired = {};

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

----------- Energy bar stuff ----------

-------------- Match character functions ----------
local currKey;
local boardKeys = {};
local active = true
local function genKeys(event)
    for i = 1, numKeys, 1 do
        boardKeys[i] = math.random(1,24);
    end

    for i = 1, numKeys, 1 do
        ansKey[i]:setFrame(boardKeys[i]);
        ansKey[i].isVisible = true;
    end
    currKey = 1;

end
local function checkKey(event)
    if(active == true) then
        if(event.phase == "ended") then
            print(event.target.id .. " == " .. boardKeys[currKey])
            if(event.target.id == boardKeys[currKey]) then
                currKey = currKey + 1;
                if(currKey > numKeys) then
                    currKey = 1;
                    for i = 1, numKeys, 1 do
                        ansKey[i].isVisible = false
                    end
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


-- local forward references should go here
--------------------------------------------------------------------------
-------
-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    physics.start()
    -- Add fidget spinner
    myFidget = fidget:new()
    sceneGroup:insert(myFidget)
    -- Add keyboard
    addKeyboard(sceneGroup)
    -- Position fidget spinner
    myFidget.x = display.contentCenterX - 200;
    myFidget.y = display.contentCenterY + 100;
	myFidget.angularVelocity = 5500
 
    -- Create the time bar.
    local timeBar = widget.newProgressView(
        {
            x = display.contentCenterX,
            y = 870,
            width = 800,
            isAnimated = true
        }
    )
    timeBar:setProgress( 0.5 )
    -- Create the energy bar.
    energyBar = widget.newProgressView(
    {
        x = 5,
        y = 400,
        width = 700,
        isAnimated = true
    })
    energyBar:rotate(270)
    local energyUpdateTimer = timer.performWithDelay(500, updateVel, 0)

    -- Initialize answer key
    -- Initialize white board for ans key
    local whiteBoard = display.newRect(display.contentCenterX, display.contentCenterY - 300, 400, 200)
    whiteBoard:setFillColor(1,1,1)
    sceneGroup:insert(whiteBoard)
    for i = 1, 10, 1 do
        ansKey[i] = display.newSprite(galphabetSheet, {name = theName, start = 1, count = 24})
        ansKey[i]:scale(.7,.7)
    end
    
    for i = 1, 5, 1 do
        ansKey[i].isVisible = false;
        ansKey[i].x = (130 * i) - 50;
        ansKey[i].y = 150;
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
    for i = 1, 3, 1 do
        tired[i].x = display.contentCenterX;
        tired[i].y = display.contentCenterY;
        sceneGroup:insert(tired[i]);
        tired[i]:toFront()
        tired[i].isVisible = false;
    end

    sceneGroup:insert(timeBar)
    sceneGroup:insert(energyBar)


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