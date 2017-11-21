-- For this class you want to pass parameters in that have all of the scores
-- nil that aren't for your specific game and this will handle storing and setting
-- the values

local composer = require( "composer" )
local json = require("json")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
--file name to store in
local fileName = "Highscores.json"
--the table for the data
local data = {
   gymScore = 0,
   classScore = 0,
   dormScore = 0,
   CBGScore = 0
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

--displays data to screen
local function displayData(params, sceneGroup)
  if params.gymScore ~= nil then
    local highScoreText = display.newText("Highest Score: " .. data.gymScore, display.contentCenterX, 500)
    sceneGroup:insert(highScoreText)
    local currentScore = display.newText("Current Score: " .. params.gymScore, display.contentCenterX, 550)
    sceneGroup:insert(currentScore)
  elseif params.classScore ~= nil then
    local highScoreText = display.newText("Highest Score: " ..  data.classScore, display.contentCenterX, 500)
    sceneGroup:insert(highScoreText)
    local currentScore = display.newText("Current Score: " .. params.classScore, display.contentCenterX, 550)
    sceneGroup:insert(currentScore)
  elseif params.dormScore ~= nil then
    local highScoreText = display.newText("Highest Score: " .. data.dormScore, display.contentCenterX, 500)
    sceneGroup:insert(highScoreText)
    local currentScore = display.newText("Current Score: " .. params.dormScore, display.contentCenterX, 550)
    sceneGroup:insert(currentScore)
  elseif params.CBGScore ~= nil then
    local highScoreText = display.newText("Highest Score: " .. data.CBGScore, display.contentCenterX, 500)
    sceneGroup:insert(highScoreText)
    local currentScore = display.newText("Current Score: " .. params.CBGScore, display.contentCenterX, 550)
    sceneGroup:insert(currentScore)
  end
end



--updates the data in the table
local function updateData(params)
  if params.gymScore ~= nil and params.gymScore > data.gymScore then
    data.gymScore = params.gymScore
  elseif params.classScore ~= nil and params.classScore > data.classScore then
    data.classScore = params.classScore
  elseif params.dormScore ~= nil and params.dormScore > data.dormScore then
    data.dormScore = params.dormScore
  elseif params.CBGScore ~= nil and params.CBGScore > data.CBGScore then
    data.CBGScore = params.CBGScore
  end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local params = event.params
    readData()
    updateData(params)
    writeData()
    displayData(params, sceneGroup)
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
