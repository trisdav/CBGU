
-----------------------------------------------------------------------------------------
--
-- sceneLecture.lua
--      In this scene the user will drag his finger across a note pad at the bottom of the 
-- screen to get points. The default distance is 50,000.
--
--
-- Created by Tristan Davis on 10/08/17
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local widget = require("widget")
local scene = composer.newScene()
local physics = require("physics")

--------------------------------------------------------------------------
-------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
--------------------------------------------------------------------------
-------
-- local forward references should go here
local noteDimX = 600;
local noteDimY = 360;
local noteCenterX = display.contentCenterX;
local noteCenterY = display.contentCenterY + 145;
local textBox;
local distanceMod = 1; --This modifies how far you have to move to get a point.
local trailColor = { r = .5, g = 0, b = 0, a = 1};
local strokeWidth = 5;
local speed = 1000;
local mod = .2;
local dX;
local dY;
local lastX;
local lastY;
local linePts = {};
local line;
local lineGroup = display.newGroup();
local xp = 0;
function xppp()
    xp = xp +1;
end


function scribble(event)
    if(dX == nil or dY == nil) then
        dX = 0;
        dY = 0;
    end
    if (event.phase == "began") then
        print("began")
        lastX = event.xStart
        lastY = event.yStart
        table.insert(linePts, event.xStart);
        table.insert(linePts, event.yStart);
    end    
    if (event.phase == "moved") then
        print("Moved")
        if(math.abs(lastX - event.x) +  math.abs(lastY - event.y) > 1) then
            table.insert(linePts, event.x)
            table.insert(linePts, event.y)
            --if line ~= nil then line:removeSelf() end
            line = display.newLine(unpack(linePts));
            lineGroup:insert(line);
            lineGroup:toFront();
            line:setStrokeColor(1, 0, 0, 1);
            line.strokeWidth = 4;
        end
        lastX = event.x;
        lastY = event.y;
        dX =  dX + math.abs(event.xStart - event.x);
        dY =  dY + math.abs(event.yStart - event.y);        
        if((dX + dY) > 1000 * distanceMod) then
            xppp();
            dX = 0;
            dY = 0;
        end
    end
    if(event.phase == "ended") then
        print("ended")
        linePts = {};
    end
end

function turnPage(event)
    if(lineGroup ~= nil) then
        lineGroup:removeSelf();
        lineGroup = nil;
        lineGroup = display.newGroup();
    end
end
--------------------------------------------------------------------------
-------
-- "scene:create()"
function scene:create( event )
    physics.start()
    local sceneGroup = self.view
    local phase = event.phase
    local turnPageButton;
    local myFidget = fidget:new()
    sceneGroup:insert(myFidget)
    myFidget.x = display.contentCenterX + 20;
    myFidget.y = display.contentCenterY - 400;


-- Initialize the scene here.
end
-- "scene:show()"
function scene:show( event )
    local phase = event.phase
    turnPageButton = widget.newButton(     {
        label = "Turn page",
        onRelease = turnPage,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 600,
        height = 160,
        cornerRadius = 2,
        fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    });
    turnPageButton._view._label.size = 64
    turnPageButton.x = display.contentCenterX;
    turnPageButton.y = display.contentCenterY;
    if ( phase == "will" ) then
    -- Called when the scene is still off screen (but is about to come on screen.)
    elseif ( phase == "did" ) then
        print("precall")
        noteBook = display.newImageRect("Architecture-Index-Card.png", noteDimX, noteDimY)
        noteBook:addEventListener("touch", scribble)
        noteBook.x = noteCenterX
        noteBook.y = noteCenterY + 200
        noteBook:scale(1,1)

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