local composer = require( "composer" )
local menuButton = require("objects.menu_button")
local backButtons = require("objects.menu_button")
local widget = require("widget")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
	
	local page =1
	local pages = {}
	local pageGroup = display.newGroup()
	local score = 0
	local flipsound = audio.loadStream("arts/pageFlip.wav")
	local studySound = audio.loadStream("arts/study.wav")
    local params = {}

	
	local function study(event)
		event.target:removeSelf()
		audio.play(studySound)
		score = score +1
		pages[page] = nil
		goalText.text = "Score: " .. score
	end

	local function nextPage()
		if(pages[page] ~= nil) then
		pages[page].isVisible = false
		pages[page]:removeEventListener("tap",study)
	end
	page = page+1
	audio.play(flipsound)
		book:setSequence("nextPage")
		book:play()
		if pages[page] ~= nil then
			pages[page].isVisible = true
			pages[page]:addEventListener("tap",study)
		elseif(math.random(1,3) <2) then
		 		local rect = display.newRect(math.random(80,640),math.random(200,800),math.random(50,300),math.random(50,300))
		 		rect:setFillColor(1,.7,.7,.5)
		 		table.insert(pages,page,rect)
		 		pageGroup:insert(rect)
		 		rect:addEventListener("tap",study)
		 	end
		end

		local function prevPage()
			if(pages[page]~=nil) then
				pages[page].isVisible = false
				pages[page]:removeEventListener("tap",study)
			end
			book:setSequence("lastPage")
		 	book:play()
			page = page-1
			audio.play(flipsound)
			if(pages[page]~= nil) then
				pages[page].isVisible = true
				pages[page]:addEventListener("tap",study)
			end
		end
	    	local function flipPage(event)
		if(event.phase == "began") then
			
		elseif (event.phase == "ended") then
		 if ((event.x - event.xStart) < -50) then
		 	nextPage()
		 elseif((event.x-event.xStart) > 50) then
		 	prevPage()
		 	
		 end
		end
	end
	local function gameOver()
		pageGroup:removeSelf()
		pages =nil
		pageGroup=nil
  		params.libraryScore = score
  		book:removeEventListener("touch", flipPage)

    local button = backButtons.newHscore("Library", -- The name of the current scene
                                            params) -- Parameters, e.g. params.cafeteriaScore
    button.hscore.isVisible = false;
    local function exitVis(event)
        button.hscore.isVisible = true;
    end
    timer.performWithDelay(100, exitVis)
    -- TODO: Add a button to return to campus.
end


local function startGame(event)
  if(event.phase == "ended") then
    display.remove(b_start)
    timer.performWithDelay((1000 * 30) * 1, gameOver); -- This game is timed. 1 minute
    transition.to(timeBar, {x = 65, xScale = 0, time = (1000 * 30) * 1})
    book:addEventListener("touch", flipPage)

  end

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



--ends the minigame


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    b_start = widget.newButton(bo_start)
    b_start._view._label.size = 64

    -- Code here runs when the scene is first created but has not yet appeared on screen
    local options =
{
    --required parameters
    width = 720,
    height = 1080,
    numFrames = 8,
}
local booksheet = graphics.newImageSheet( "arts/books.png", options)
local sequenceData =
{
   { name="nextPage",
    frames = {1,2,3,4,5,6,7,8,1},
    time=300,
    loopCount = 1,
	},
	{name = "lastPage", frames = {1,8,7,6,5,4,3,2,1}, time = 300, loopCount =1}
}
 book = display.newSprite(sceneGroup, booksheet, sequenceData)
book.x = display.contentCenterX
book.y = display.contentCenterY
goalText = display.newText( "Score: " .. score, display.contentCenterX, 40 )
    goalText:setFillColor(1,1,1)
    goalText.size = 45
    sceneGroup:insert(goalText)
    timeBar = display.newImage("arts/barfill.png", 355, 110)
    timeBar:scale(1.16,1.3)
    sceneGroup:insert(timeBar)
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
    	

        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
    	book:play()
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