local composer = require( "composer" )
local json = require("json")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

--time variables
local day = 1 --20 days in a semester
local semester = 1
local hour = 6
--character variables
local hunger = 100
local energy = 100
local GPA = 4.0
local IQ = 105
local health = 100
--local money = 0

--Max and min variables
local maxHunger = 100
local maxEnergy = 100
local maxGPA = 4.0
local minGPA = 1.5
local maxIQ = 140
local minIQ = 71

local fileName = "Current.json"

--used for time errors when trying to go to a new scene
local errorText = display.newText("", display.contentCenterX, display.contentCenterY)
errorText:setFillColor(1,0,0)

local hungerText = display.newText("Hunger: "..hunger, 110,70 )
local energyText = display.newText("Energy: "..energy, 340,70 )
local IQText = display.newText("IQ: "..IQ, 550,70 )
local dayText = display.newText("Day: "..day, 55,20 )
local hourText = display.newText("Hour: "..hour, 200,20 )
local semesterText = display.newText("Semester: "..semester, 390,20 )
local healthText = display.newText("Health: "..health, 600,20)

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

local currentData = {
  gymScore = nil,
  classScore = nil,
  dormScore = nil,
  CBGScore = nil,
  cafeScore = nil,
  libraryScore = nil,
  partyScore = nil
}

local Buildings2 = graphics.newImageSheet("arts/Buildings2.jpg", options2)

--returns to the main menu
local function gameOver()
  composer.gotoScene("s_main_menu")
  composer.removeScene("Campus")
end

--reads in json data and decodes it
local function readData()
  local path = system.pathForFile(fileName, system.DocumentsDirectory)
  local fileHandle = io.open(path,"r") --open file for reading
  if fileHandle then
    currentData = json.decode(fileHandle:read("*a"))
    io.close( fileHandle )
  end
end

--writes json data to a file
local function writeCurrentData()
  local path = system.pathForFile(fileName, system.DocumentsDirectory)
  local fileHandle = io.open(path, "w")
  if fileHandle then
    fileHandle:write(json.encode(currentData))
    io.close(fileHandle)
  end
end

--handles time advancing
local function updateTime(hours)
  hour = hour + hours
  hourText.text = "Hour: "..hour
  if hour >= 24 then
    day = day + 1
    dayText.text = "Day: "..day
    hour = hour - 24
    hourText.text = "Hour: "..hour
    if day == 21 then
      semester = semester + 1
      semesterText.text = "Se;mester: "..semester
    end
  end
end

local function checkHealth()
  if health <= 0 then
    gameOver()
  elseif health >= 100 then
    health = 100
  end
  healthText.text = "Health: "..health
end

--removes the text on the screen
local function removeErrorText()
  errorText.text = ""
end

--event handler for class button
local function classButtonEvent(event)
  if hour >= 6 and hour < 18 then
    updateTime(2)
    hunger = hunger - 25
    if hunger <= 0 then
      hunger = 0
      health = health - 1
      checkHealth()
    end
    hungerText.text = "Hunger: "..hunger
    energy = energy -25
    if energy <= 0 then
      energy = 0
      health = health - 1
      checkHealth()
    end
    energyText.text = "Energy: "..energy
    composer.gotoScene("Class")
  else
    errorText.text = "Only available between 6:00 and 18:00"
    local t = timer.performWithDelay( 1500, removeErrorText)
  end
end

--event handler for library button
local function libraryButtonEvent(event)
  updateTime(2)
  hunger = hunger - 25
  if hunger <= 0 then
    hunger = 0
    health = health - 1
    checkHealth()
  end
  hungerText.text = "Hunger: "..hunger
  energy = energy -25
  if energy <= 0 then
    energy = 0
    health = health - 1
    checkHealth()
  end
  energyText.text = "Energy: "..energy
  health = health - 25
  checkHealth()
  composer.gotoScene("Library")
end

--event handler for work button
local function workButtonEvent(event)
  print("Hello")
end

--event handler for gym button
local function gymButtonEvent(event)
  updateTime(2)
  hunger = hunger - 25
  if hunger <= 0 then
    hunger = 0
    health = health - 1
    checkHealth()
  end
  hungerText.text = "Hunger: "..hunger
  energy = energy -25
  if energy <= 0 then
    energy = 0
    health = health - 1
    checkHealth()
  end
  energyText.text = "Energy: "..energy
  IQ = IQ - 10
  IQText.text = "IQ: "..IQ
  composer.gotoScene("Gym")
end

--event handler for party button
local function partyButtonEvent(event)
  print("Hello")
end

--event handler for cbg button
local function cbgButtonEvent(event)
  if hour >= 6 and hour < 22  then
    updateTime(4)
    hunger = hunger - 25
    if hunger <= 0 then
      hunger = 0
      health = health - 1
      checkHealth()
    end
    hungerText.text = "Hunger: "..hunger
    energy = energy -25
    if energy <= 0 then
      energy = 0
      health = health - 1
      checkHealth()
    end
    IQ = IQ - 10
    IQText.text = "IQ: "..IQ
    composer.gotoScene("CBG")
  else
    errorText.text = "Only available between 6:00 and 22:00"
    local t = timer.performWithDelay( 1500, removeErrorText)
  end
end

--event handler for dorm button
local function dormButtonEvent(event)
    updateTime(8)
    IQ = IQ - 1
    IQText.text =  "IQ: "..IQ
    energy = energy + 60
    if energy > 100 then
      energy = 100
    end
    energyText.text = "Energy: "..energy
    hunger = hunger - 50
    if hunger <= 0 then
      hunger = 0
      health = health - 1
      checkHealth()
    end
    hungerText.text = "Hunger: "..hunger
    composer.gotoScene("Dorm")
end

--event handler for cafeteria button
local function cafeteriaButtonEvent(event)
  if hour >= 6 and hour < 20 then
    updateTime(2)
    composer.gotoScene("Cafeteria")
  else
    errorText.text = "Only available between 6:00 and 20:00"
    local t = timer.performWithDelay( 1500, removeErrorText)
  end
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
    classButton = display.newImage("arts/classBuilding.png", display.contentCenterX, display.contentCenterY+450)
    classButton:addEventListener("tap", classButtonEvent)

    libraryButton = display.newImageRect(Buildings1, 3, 150, 150)
    libraryButton.alpha = .9
    libraryButton.x = 600
    libraryButton.y = 1020
    libraryButton:rotate(90)
    libraryButton:addEventListener("tap", libraryButtonEvent)

    --workButton = display.newRect( display.contentCenterX - 200, display.contentCenterY-300, 100, 100 )
    --workButton:setFillColor(1,0,1)
    --workButton:addEventListener("tap", workButtonEvent)

    gymButton = display.newImageRect(Buildings2, 1, 150, 150)
    gymButton.alpha = 0.93
    gymButton.x = 115
    gymButton.y = 700
    gymButton:rotate(90)
    gymButton:addEventListener("tap", gymButtonEvent)

    partyButton = display.newImageRect(Buildings1, 2, 150, 150)
    partyButton.alpha = .9
    partyButton.x = 88
    partyButton.y = 1020
    partyButton:rotate(90)
    partyButton:addEventListener("tap", partyButtonEvent)

    cbgButton = display.newImage("arts/cbgmap.png" ,display.contentCenterX + 200, display.contentCenterY + 50 )
    cbgButton:addEventListener("tap", cbgButtonEvent)

    dormButton = display.newImageRect(Buildings2, 2, 150, 150)
    dormButton.alpa = .9
    dormButton.x = 88
    dormButton.y = 1190
    dormButton:rotate(90)
    dormButton:addEventListener("tap", dormButtonEvent)

    cafeteriaButton = display.newImageRect(Buildings1, 1, 150, 150)
    cafeteriaButton.alpha = .9
    cafeteriaButton.x = 600
    cafeteriaButton.y = 1190
    cafeteriaButton:rotate(90)
    cafeteriaButton:addEventListener("tap", cafeteriaButtonEvent)

    local background = display.newImage("arts/Map.png", display.contentCenterX, display.contentCenterY +100)

    --storeButton = display.newRect( display.contentCenterX, display.contentCenterY +200, 100, 100 )
    --storeButton:setFillColor(1,.2,0)
    --storeButton:addEventListener("tap", storeButtonEvent)

    --inventoryButton = display.newRect( display.contentCenterX -200, display.contentCenterY +200, 100, 100 )
    --inventoryButton:setFillColor(.5,.2,.5)
    --inventoryButton:addEventListener("tap", inventoryButtonEvent)

    sceneGroup:insert(background)
    sceneGroup:insert(classButton)
    sceneGroup:insert(libraryButton)
    --sceneGroup:insert(workButton)
    sceneGroup:insert(gymButton)
    --sceneGroup:insert(partyButton)
    sceneGroup:insert(cbgButton)
    sceneGroup:insert(dormButton)
    sceneGroup:insert(cafeteriaButton)
    --sceneGroup:insert(storeButton)
    --sceneGroup:insert(inventoryButton)

    sceneGroup:insert(hungerText)
    sceneGroup:insert(energyText)
    sceneGroup:insert(dayText)
    sceneGroup:insert(IQText)
    sceneGroup:insert(hourText)
    sceneGroup:insert(semesterText)
    sceneGroup:insert(healthText)
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        readData()
        if currentData.gymScore ~= nil then
          health = health + (currentData.gymScore * 2)
          checkHealth()
          currentData.gymScore = nil
          writeCurrentData()
        elseif currentData.classScore ~= nil then
          IQ = IQ + currentData.classScore
          IQText.text = "IQ: "..IQ
          currentData.classScore = nil
          writeCurrentData()
        elseif currentData.dormScore ~= nil then
          health = health + math.ceil(currentData.dormScore)
          checkHealth()
          currentData.dormScore = nil
          writeCurrentData()
        elseif currentData.CBGScore ~= nil then
          health = health + math.ceil(currentData.CBGScore/4)
          checkHealth()
          currentData.CBGScore = nil
          writeCurrentData()
        elseif currentData.cafeScore ~= nil then
          hunger = hunger + math.ceil(currentData.cafeScore/2)
          if hunger >= 100 then
            hunger = 100
          end
          hungerText.text = "Hunger: "..hunger
          energy = energy + math.ceil(currentData.cafeScore/2)
          if energy >= 100 then
            energy = 100
          end
          energyText.text = "Energy: "..energy
          health = math.ceil(currentData.cafeScore/10)
          checkHealth()
          currentData.cafeScore = nil
          writeCurrentData()

        elseif currentData.libraryScore ~= nil then
          IQ = IQ + currentData.libraryScore
          IQText.text = "IQ: "..IQ
          currentData.libraryScore = nil
          writeCurrentData()
        elseif currentData.partyScore ~= nil then

        end
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
