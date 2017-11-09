local composer = require( "composer" )

local scene = composer.newScene()

-- These are options for the transition to the class scene
local classTrans = {
                    effect = "fade",
                    time = 400
                    }

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
--event handler for class button
local function classButtonEvent(event)
  print("Going to class...")
  composer.gotoScene("Class", classTrans)
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
  print("Hello")
end

--event handler for party button
local function partyButtonEvent(event)
  print("Hello")
end

--event handler for cbg button
local function cbgButtonEvent(event)
  print("Hello")
end

--event handler for dorm button
local function dormButtonEvent(event)
  print("Hello")
end

--event handler for cafeteria button
local function cafeteriaButtonEvent(event)
  print("Hello")
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

    libraryButton = display.newRect( display.contentCenterX - 200, display.contentCenterY - 200, 100, 100 )
    libraryButton:setFillColor(1,1,0)
    libraryButton:addEventListener("tap", classButtonEvent)

    workButton = display.newRect( display.contentCenterX - 200, display.contentCenterY, 100, 100 )
    workButton:setFillColor(1,0,1)
    workButton:addEventListener("tap", workButtonEvent)

    gymButton = display.newRect( display.contentCenterX, display.contentCenterY - 200, 100, 100 )
    gymButton:setFillColor(0,1,0)
    gymButton:addEventListener("tap", gymButtonEvent)

    partyButton = display.newRect( display.contentCenterX + 200, display.contentCenterY - 200, 100, 100 )
    partyButton:setFillColor(0,1,1)
    partyButton:addEventListener("tap", partyButtonEvent)

    cbgButton = display.newRect( display.contentCenterX + 200, display.contentCenterY, 100, 100 )
    cbgButton:setFillColor(0,0,1)
    cbgButton:addEventListener("tap", cbgButtonEvent)

    dormButton = display.newRect( display.contentCenterX + 200, display.contentCenterY +200, 100, 100 )
    dormButton:setFillColor(1,.2,.5)
    dormButton:addEventListener("tap", dormButtonEvent)

    cafeteriaButton = display.newRect( display.contentCenterX + 200, display.contentCenterY +200, 100, 100 )
    cafeteriaButton:setFillColor(1,.2,.5)
    cafeteriaButton:addEventListener("tap", cafeteriaButtonEvent)

    storeButton = display.newRect( display.contentCenterX, display.contentCenterY +200, 100, 100 )
    storeButton:setFillColor(1,.2,0)
    storeButton:addEventListener("tap", storeButtonEvent)

    inventoryButton = display.newRect( display.contentCenterX -200, display.contentCenterY +200, 100, 100 )
    inventoryButton:setFillColor(.5,.2,.5)
    inventoryButton:addEventListener("tap", inventoryButtonEvent)

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
