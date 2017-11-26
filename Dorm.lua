local composer = require( "composer" )
local widget = require("widget")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local sheepTable = {}
local sheepNumber = 0
local score = 0
local backgroundSound = audio.loadStream( "arts/snoring.wav" )

--to pass to highscores scene
local options = {
  effect = "fade",
  time = 1000,
  params = {
    gymScore = nil,
    classScore = nil,
    dormScore = score,
    CBGScore = nil
           }
}

local scoreText = display.newText("Score: "..score, display.contentCenterX, 40 )
scoreText:setFillColor(0,0,0)

--removes sheep from screen
local function removeSheep()
  for i = #sheepTable, 1, -1 do
    display.remove(sheepTable[i])
  end
end

--listener for the answer choices
function answerChoiceListener(event)
  --clean up everything
  display.remove(back)
  display.remove(questionText)
  display.remove(choice1)
  display.remove(choice2)
  display.remove(choice3)
  display.remove(answerText1)
  display.remove(answerText2)
  display.remove(answerText3)
  if order == 1 and event.target.id == "choice1" then
    score = score + sheepNumber
    scoreText.text = "Score: "..score
    runGame()
  elseif order == 2 and event.target.id == "choice1" then
    score = score + sheepNumber
    scoreText.text = "Score: "..score
    runGame()
  elseif order == 3 and event.target.id == "choice2" then
    score = score + sheepNumber
    scoreText.text = "Score: "..score
    runGame()
  elseif order == 4 and event.target.id == "choice3" then
    score = score + sheepNumber
    scoreText.text = "Score: "..score
    runGame()
  elseif order == 5 and event.target.id == "choice2" then
    score = score + sheepNumber
    scoreText.text = "Score: "..score
    runGame()
  elseif order == 6 and event.target.id == "choice3" then
    score = score + sheepNumber
    scoreText.text = "Score: "..score
    runGame()
  else
    audio.pause(snoringAudio)
    options.params.dormScore = score
    composer.gotoScene("Highscores", options)
    composer.removeScene("Dorm")
  end
end

--gets the answer from the user
local function questionAndAnswer()
  back = display.newImage("arts/smallBlank.png", display.contentCenterX, display.contentCenterY - 350)
  questionText = display.newText("How many sheep were there?", display.contentCenterX, display.contentCenterY - 500)
  questionText:setFillColor(0,0,0)
  order = math.random(1,6)
  c2 = sheepNumber - math.random(1,4)
  c1 = sheepNumber + math.random(1,4)
  --the rest of this function is just determing which square each answer choice is in
  if order == 1 then
    --choice 1
    choice1 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX -200, display.contentCenterY - 300)
    choice1:setFillColor((217/255), (217/255), (217/255))
    choice1.id = "choice1"
    answerText1 = display.newText(""..sheepNumber,display.contentCenterX -200, display.contentCenterY - 300)
    answerText1:setFillColor(0,0,0)
    choice1:addEventListener("tap", answerChoiceListener)
    --choice 2
    choice2 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX, display.contentCenterY - 300)
    choice2:setFillColor((217/255), (217/255), (217/255))
    choice2.id = "choice2"
    answerText2 = display.newText(""..c2, display.contentCenterX, display.contentCenterY - 300)
    answerText2:setFillColor(0,0,0)
    choice2:addEventListener("tap", answerChoiceListener)
    --choice 3
    choice3 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX +200, display.contentCenterY - 300)
    choice3:setFillColor((217/255), (217/255), (217/255))
    choice3.id = "choice3"
    answerText3 = display.newText(""..c1, display.contentCenterX +200, display.contentCenterY - 300)
    answerText3:setFillColor(0,0,0)
    choice3:addEventListener("tap",answerChoiceListener)
  elseif order == 2 then
    --choice 1
    choice1 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX -200, display.contentCenterY - 300)
    choice1:setFillColor((217/255), (217/255), (217/255))
    choice1.id = "choice1"
    answerText1 = display.newText(tostring(sheepNumber), display.contentCenterX -200, display.contentCenterY - 300)
    answerText1:setFillColor(0,0,0)
    choice1:addEventListener("tap", answerChoiceListener)
    --choice 2
    choice2 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX, display.contentCenterY - 300)
    choice2:setFillColor((217/255), (217/255), (217/255))
    choice2.id = "choice2"
    answerText3 = display.newText(tostring(c1), display.contentCenterX, display.contentCenterY - 300)
    answerText3:setFillColor(0,0,0)
    choice2:addEventListener("tap",answerChoiceListener)
    --choice 3
    choice3 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX +200, display.contentCenterY - 300)
    choice3:setFillColor((217/255), (217/255), (217/255))
    choice3.id = "choice3"
    answerText2 = display.newText(tostring(c2), display.contentCenterX +200, display.contentCenterY - 300)
    answerText2:setFillColor(0,0,0)
    choice3:addEventListener("tap",answerChoiceListener)
  elseif order == 3 then
    --choice 1
    choice1 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX -200, display.contentCenterY - 300)
    choice1:setFillColor((217/255), (217/255), (217/255))
    choice1.id = "choice1"
    answerText2 = display.newText(tostring(c2), display.contentCenterX -200, display.contentCenterY - 300)
    answerText2:setFillColor(0,0,0)
    choice1:addEventListener("tap",answerChoiceListener)
    --choice 2
    choice2 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX, display.contentCenterY - 300)
    choice2:setFillColor((217/255), (217/255), (217/255))
    choice2.id = "choice2"
    answerText1 = display.newText(tostring(sheepNumber), display.contentCenterX, display.contentCenterY - 300)
    answerText1:setFillColor(0,0,0)
    choice2:addEventListener("tap",answerChoiceListener)
    --choice 3
    choice3 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX +200, display.contentCenterY - 300)
    choice3:setFillColor((217/255), (217/255), (217/255))
    choice3.id = "choice3"
    answerText3 = display.newText(tostring(c1), display.contentCenterX +200, display.contentCenterY - 300)
    answerText3:setFillColor(0,0,0)
    choice3:addEventListener("tap",answerChoiceListener)
  elseif order == 4 then
    --choice 1
    choice1 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX -200, display.contentCenterY - 300)
    choice1:setFillColor((217/255), (217/255), (217/255))
    choice1.id = "choice1"
    answerText2 = display.newText(tostring(c2), display.contentCenterX -200, display.contentCenterY - 300)
    answerText2:setFillColor(0,0,0)
    choice1:addEventListener("tap",answerChoiceListener)
    --choice 2
    choice2 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX, display.contentCenterY - 300)
    choice2:setFillColor((217/255), (217/255), (217/255))
    choice2.id = "choice2"
    answerText3 = display.newText(tostring(c1), display.contentCenterX, display.contentCenterY - 300)
    answerText3:setFillColor(0,0,0)
    choice2:addEventListener("tap",answerChoiceListener)
    --choice 3
    choice3 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX +200, display.contentCenterY - 300)
    choice3:setFillColor((217/255), (217/255), (217/255))
    choice3.id = "choice3"
    answerText1 = display.newText(tostring(sheepNumber), display.contentCenterX +200, display.contentCenterY - 300)
    answerText1:setFillColor(0,0,0)
    choice3:addEventListener("tap",answerChoiceListener)
  elseif order == 5 then
    --choice 1
    choice1 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX -200, display.contentCenterY - 300)
    choice1:setFillColor((217/255), (217/255), (217/255))
    choice1.id = "choice1"
    answerText3 = display.newText(tostring(c1), display.contentCenterX -200, display.contentCenterY - 300)
    answerText3:setFillColor(0,0,0)
    choice1:addEventListener("tap",answerChoiceListener)
    --choice 2
    choice2 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX, display.contentCenterY - 300)
    choice2:setFillColor((217/255), (217/255), (217/255))
    choice2.id = "choice2"
    answerText1 = display.newText(tostring(sheepNumber), display.contentCenterX, display.contentCenterY - 300)
    answerText1:setFillColor(0,0,0)
    choice2:addEventListener("tap",answerChoiceListener)
    --choice 3
    choice3 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX +200, display.contentCenterY - 300)
    choice3:setFillColor((217/255), (217/255), (217/255))
    choice3.id = "choice3"
    answerText2 = display.newText(tostring(c2), display.contentCenterX +200, display.contentCenterY - 300)
    answerText2:setFillColor(0,0,0)
    choice3:addEventListener("tap",answerChoiceListener)
  elseif order == 6 then
    --choice 1
    choice1 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX -200, display.contentCenterY - 300)
    choice1:setFillColor((217/255), (217/255), (217/255))
    choice1.id = "choice1"
    answerText3 = display.newText(tostring(c1), display.contentCenterX -200, display.contentCenterY - 300)
    answerText3:setFillColor(0,0,0)
    choice1:addEventListener("tap",answerChoiceListener)
    --choice 2
    choice2 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX, display.contentCenterY - 300)
    choice2:setFillColor((217/255), (217/255), (217/255))
    choice2.id = "choice2"
    answerText2 = display.newText(tostring(c2), display.contentCenterX, display.contentCenterY - 300)
    answerText2:setFillColor(0,0,0)
    choice2:addEventListener("tap",answerChoiceListener)
    --choice 3
    choice3 = display.newImage("arts/evenSmallerBlank.png", display.contentCenterX +200, display.contentCenterY - 300)
    choice3:setFillColor((217/255), (217/255), (217/255))
    choice3.id = "choice3"
    answerText1 = display.newText(tostring(sheepNumber), display.contentCenterX +200, display.contentCenterY - 300)
    answerText1:setFillColor(0,0,0)
    choice3:addEventListener("tap",answerChoiceListener)
  end
end

--spawns sheep images inside of the dream bubble
local function spawnSheep()
  sheepNumber = math.random(5, 20)
  local i
  for i = 1 , sheepNumber do
    local index = #sheepTable + 1
    x = math.random(119, 641)
    y = math.random(139, 589)
    sheepTable[index] = display.newImage("arts/sheep2.png", x, y)
  end
end

--handles running the game
function runGame()
    spawnSheep()
    local t = timer.performWithDelay(5000, removeSheep)
    local t2 = timer.performWithDelay(5100, questionAndAnswer)
end

--starts the game
local function startGame(event)
  runGame()
  display.remove( b_start )
  snoringAudio = audio.play(backgroundSound, { channel=1, loops=-1})
end

--button to start game
local bo_start = { left = display.contentCenterX/2, --center = width/2
                  top = display.contentCenterY/4,
                  id = "Start",
                  label = "Start Game",
                  onEvent = startGame,
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
    local background = display.newImage("arts/dorm.jpg",display.contentCenterX, display.contentCenterY)
    sceneGroup:insert(background)
    b_start = widget.newButton( bo_start )
    b_start._view._label.size = 64
    sceneGroup:insert(b_start)
    sceneGroup:insert(scoreText)
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
