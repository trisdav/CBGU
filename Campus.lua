local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

--time variables
local day = 1 --80 days in a semester
local semester = 1
local hour = 6
--character variables
local hunger = 100
local energy = 100
local GPA = 4.0
local IQ = 105
local money = 0

--Max and min variables
local maxHunger = 100
local maxEnergy = 100
local maxGPA = 4.0
local minGPA = 1.5
local maxIQ = 140
local minIQ = 71

local params = { goalsScore = 0}

--holds the images of the first 4 buildings
local options =
{
    frames =
    {
      {x = 248, y = 112, width = 1212, height = 1072}, --cafeteria frame
      { x = 2004, y = 200, width = 1112, height = 944}, --Fraternity frame
      { x = 304, y = 1728, width = 1192, height = 1196}, --Library Frame
      { x = 1656, y = 1964, width = 1480, height = 860}, -- store frame
    }
}

local Buildings1 = graphics.newImageSheet("arts/Buildings1.jpg", options)

--holds the images of the next 2 buildings
local options2 =
{
  frames =
  {
    { x = 1012, y = 1828, width = 1152, height = 1080}, -- gym Frame
    { x = 1164, y = 0, width = 1012, height = 1336}, -- dorms frame
  }
}

local Buildings2 = graphics.newImageSheet("arts/Buildings2.jpg", options2)

--event handler for class button
local function classButtonEvent(event)
  composer.gotoScene("Class")
end

--event handler for library button
local function libraryButtonEvent(event)
  print("Hello")
end

--event handler for work button
local function workButtonEvent(event)
  print("Hello")
end

--event handler for gym button
local function gymButtonEvent(event)
  composer.gotoScene("Gym")
end

--event handler for party button
local function partyButtonEvent(event)
  print("Hello")
end

--event handler for cbg button
local function cbgButtonEvent(event)
  print("Hello")
  composer.gotoScene("CBG")
end

--event handler for dorm button
local function dormButtonEvent(event)
  print("Hello")
end

--event handler for cafeteria button
local function cafeteriaButtonEvent(event)
  composer.gotoScene("Cafeteria")
end

--event handler for store button
local function storeButtonEvent(event)
  print("Hello")
end

--event handler for inventory button
local function inventoryButtonEvent(event)
  print("Hello")
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    classButton = display.newRect( display.contentCenterX, display.contentCenterY, 100, 100 )
    classButton:setFillColor(1,0,0)
    classButton:addEventListener("tap", classButtonEvent)

    libraryButton = display.newImageRect(Buildings1, 3, 150, 150)
    libraryButton.alpha = .9
    libraryButton.x = 600
    libraryButton.y = 900
    libraryButton:rotate(90)
    libraryButton:addEventListener("tap", libraryButtonEvent)

    workButton = display.newRect( display.contentCenterX - 200, display.contentCenterY-300, 100, 100 )
    workButton:setFillColor(1,0,1)
    workButton:addEventListener("tap", workButtonEvent)

    gymButton = display.newImageRect(Buildings2, 1, 150, 150)
    gymButton.alpha = 0.93
    gymButton.x = 115
    gymButton.y = 600
    gymButton:rotate(90)
    gymButton:addEventListener("tap", gymButtonEvent)

    partyButton = display.newImageRect(Buildings1, 2, 150, 150)
    partyButton.alpha = .9
    partyButton.x = 88
    partyButton.y = 890
    partyButton:rotate(90)
    partyButton:addEventListener("tap", partyButtonEvent)

    cbgButton = display.newRect( display.contentCenterX + 200, display.contentCenterY, 100, 100 )
    cbgButton:setFillColor(0,0,1)
    cbgButton:addEventListener("tap", cbgButtonEvent)

    dormButton = display.newImageRect(Buildings2, 2, 150, 150)
    dormButton.alpa = .9
    dormButton.x = 88
    dormButton.y = 1107
    dormButton:rotate(90)
    dormButton:addEventListener("tap", dormButtonEvent)

    cafeteriaButton = display.newImageRect(Buildings1, 1, 150, 150)
    cafeteriaButton.alpha = .9
    cafeteriaButton.x = 600
    cafeteriaButton.y = 1107
    cafeteriaButton:rotate(90)
    cafeteriaButton:addEventListener("tap", cafeteriaButtonEvent)

    local background = display.newImage("arts/blank.png", display.contentCenterX, display.contentCenterY)

    --storeButton = display.newRect( display.contentCenterX, display.contentCenterY +200, 100, 100 )
    --storeButton:setFillColor(1,.2,0)
    --storeButton:addEventListener("tap", storeButtonEvent)

    --inventoryButton = display.newRect( display.contentCenterX -200, display.contentCenterY +200, 100, 100 )
    --inventoryButton:setFillColor(.5,.2,.5)
    --inventoryButton:addEventListener("tap", inventoryButtonEvent)

    sceneGroup:insert(background)
    sceneGroup:insert(classButton)
    sceneGroup:insert(libraryButton)
    sceneGroup:insert(workButton)
    sceneGroup:insert(gymButton)
    sceneGroup:insert(partyButton)
    sceneGroup:insert(cbgButton)
    sceneGroup:insert(dormButton)
    sceneGroup:insert(cafeteriaButton)
    --sceneGroup:insert(storeButton)
    --sceneGroup:insert(inventoryButton)

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
