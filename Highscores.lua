-- For this class you want to pass parameters in that have all of the scores
-- nil that aren't for your specific game and this will handle storing and setting
-- the values

local composer = require( "composer" )
local json = require("json")
local backButtons = require("objects.menu_button")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
--file name to store in
local fileName = "Highscores.json"
local fileName2 = "Current.json"
--the table for the data
local data = {
   gymScore = 0,
   classScore = 0,
   dormScore = 0,
   CBGScore = 0,
   cafeScore = 0,
   libraryScore = 0,
   partyScore = 0
 }

 local currentData = {
   gymScore = 0,
   classScore = 0,
   dormScore = 0,
   CBGScore = 0,
   cafeScore = 0,
   libraryScore = 0,
   partyScore = 0
 }

--reads in json data and decodes it
local function readData()
  local path = system.pathForFile(fileName, system.DocumentsDirectory)
  local fileHandle = io.open(path,"r") --open file for reading
  if fileHandle then
    data = json.decode(fileHandle:read("*a"))
    io.close( fileHandle )
  end
end

--writes json data to a file
local function writeData()
  local path = system.pathForFile(fileName, system.DocumentsDirectory)
  local fileHandle = io.open(path, "w")
  if fileHandle then
    fileHandle:write(json.encode(data))
    io.close(fileHandle)
  end
end

--writes json data to a file
local function writeCurrentData()
  local path = system.pathForFile(fileName2, system.DocumentsDirectory)
  local fileHandle = io.open(path, "w")
  if fileHandle then
    fileHandle:write(json.encode(currentData))
    io.close(fileHandle)
  end
end

--displays data to screen
local function displayData(params, sceneGroup)
  if params.gymScore ~= nil then
    local highScoreText = display.newText("Highest Score: " .. data.gymScore, display.contentCenterX, 483)
    sceneGroup:insert(highScoreText)
    highScoreText:setFillColor(0,0,0)
    local currentScore = display.newText("Current Score: " .. params.gymScore, display.contentCenterX, 533)
    sceneGroup:insert(currentScore)
    currentScore:setFillColor(0,0,0)
  elseif params.classScore ~= nil then
    local highScoreText = display.newText("Highest Score: " ..  data.classScore, display.contentCenterX, 483)
    sceneGroup:insert(highScoreText)
    highScoreText:setFillColor(0,0,0)
    local currentScore = display.newText("Current Score: " .. params.classScore, display.contentCenterX, 533)
    sceneGroup:insert(currentScore)
    currentScore:setFillColor(0,0,0)
  elseif params.dormScore ~= nil then
    local highScoreText = display.newText("Highest Score: " .. data.dormScore, display.contentCenterX, 483)
    sceneGroup:insert(highScoreText)
    highScoreText:setFillColor(0,0,0)
    local currentScore = display.newText("Current Score: " .. params.dormScore, display.contentCenterX, 533)
    sceneGroup:insert(currentScore)
    currentScore:setFillColor(0,0,0)
  elseif params.CBGScore ~= nil then
    local highScoreText = display.newText("Highest Score: " .. data.CBGScore, display.contentCenterX, 483)
    sceneGroup:insert(highScoreText)
    highScoreText:setFillColor(0,0,0)
    local currentScore = display.newText("Current Score: " .. params.CBGScore, display.contentCenterX, 533)
    sceneGroup:insert(currentScore)
    currentScore:setFillColor(0,0,0)
  elseif params.cafeScore ~= nil then
    local highScoreText = display.newText("Highest Score: " .. data.cafeScore, display.contentCenterX, 483)
    sceneGroup:insert(highScoreText)
    highScoreText:setFillColor(0,0,0)
    local currentScore = display.newText("Current Score: " .. params.cafeScore, display.contentCenterX, 533)
    sceneGroup:insert(currentScore)
    currentScore:setFillColor(0,0,0)
  elseif params.libraryScore ~= nil then
    local highScoreText = display.newText("Highest Score: " .. data.libraryScore, display.contentCenterX, 483)
    sceneGroup:insert(highScoreText)
    highScoreText:setFillColor(0,0,0)
    local currentScore = display.newText("Current Score: " .. params.libraryScore, display.contentCenterX, 533)
    sceneGroup:insert(currentScore)
    currentScore:setFillColor(0,0,0)
  elseif params.partyScore ~= nil then
    local highScoreText = display.newText("Highest Score: " .. data.partyScore, display.contentCenterX, 483)
    sceneGroup:insert(highScoreText)
    highScoreText:setFillColor(0,0,0)
    local currentScore = display.newText("Current Score: " .. params.partyScore, display.contentCenterX, 533)
    sceneGroup:insert(currentScore)
    currentScore:setFillColor(0,0,0)
  end
end



--updates the data in the table
local function updateData(params)
  if params.gymScore ~= nil and (data.gymScore == nil or params.gymScore > data.gymScore) then
    data.gymScore = params.gymScore
  elseif params.classScore ~= nil and (data.classScore == nil or params.classScore > data.classScore) then
    data.classScore = params.classScore
  elseif params.dormScore ~= nil and (data.dormScore == nil or params.dormScore > data.dormScore) then
    data.dormScore = params.dormScore
  elseif params.CBGScore ~= nil and (data.CBGScore == nil or params.CBGScore > data.CBGScore) then
    data.CBGScore = params.CBGScore
  elseif params.cafeScore ~= nil and (data.cafeScore == nil or params.cafeScore > data.cafeScore) then
    data.cafeScore = params.cafeScore
  elseif params.libraryScore ~= nil and (data.libraryScore == nil or params.libraryScore > data.libraryScore) then
    data.libraryScore = params.libraryScore
  elseif params.partyScore ~= nil and (data.partyScore == nil or params.partyScore > data.partyScore) then
    data.partyScore = params.partyScore
  end
end

--inserts the new data
local function updateCurrentData(params)
  currentData.gymScore = params.gymScore
  currentData.classScore = params.classScore
  currentData.dormScore = params.dormScore
  currentData.CBGScore = params.CBGScore
  currentData.cafeScore = params.cafeScore
  currentData.libraryScore = params.libraryScore
  currentData.partyScore = params.partyScore
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local params = event.params
    local bg = display.newImage("arts/blank.png", display.contentCenterX, display.contentCenterY)
    sceneGroup:insert(bg)
    readData()
    updateData(params)
    updateCurrentData(params)
    writeData()
    writeCurrentData()
    displayData(params, sceneGroup)
    button = backButtons.newCampus("Highscores")
    sceneGroup:insert(button.campus)
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
