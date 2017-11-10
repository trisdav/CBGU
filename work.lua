local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
        local boss = display.newRect(330, 70, 50, 50)
        local door = display.newRect(300, 200, 50, 350)
        local computer = display.newRect (120, 170, 200, 150)

        computer.r = 0
        computer.g = 0
        computer.b = 1

        computer:setFillColor(computer.r, computer.g, computer.b)
        local x = math.random(1000, 5000)
-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

if ( phase == "will" ) then

        --computer:setFillColor(0,0,1) --This is the temp watching a video color, red will be the work color

    elseif ( phase == "did" ) then

local function bossMoveing()

     function listener2(bossLeaves)
        print("You have entered the BossLeaves fcn" .. tostring(obj))
       
        transition.to(boss, {time = 2000, x = 300})
        timer.performWithDelay(2000 + math.random(x), listener1)

    end    

        function listener1(bossEnters)

        print("You have entered the bossEnters Fcn" .. tostring(obj))
        
        transition.to(boss, {time = 1500, x = 150}) 

        timer.performWithDelay (3500, listener2) --Boss Leaves   
     end
     timer.performWithDelay( math.random(x), listener1) --Boss enters
end

    bossMoveing()

        local function onObjectTap(event)

        if computer.b == 1 then
        computer.r = 1
        computer.g = 0
        computer.b = 0
        computer:setFillColor(computer.r, computer.g, computer.b)
   else
        computer.r = 0
        computer.g = 0
        computer.b = 1
        event.target:setFillColor(computer.r, computer.g, computer.b)
     end
 end

computer:addEventListener("tap", onObjectTap)



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