-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

composer = require "composer"
scene = composer.newScene()
widget = require "widget"
physics = require "physics"
physics.start( )

function scene:create( event )

	function scrollCity( self, event)
		if self.x < -477 then
			self.x = 480
		else
			self.x = self.x - self.speed
		end
	end

	function moveMines( self, event )
		if (self.x < -50) then
			self.x = 500
			self.y = math.random( 90, 220 )
			self.speed = math.random( 2, 6 )
			self.amp = math.random( 20, 100 )
			self.angle = math.random( 1, 360 )
		else
			self.x = self.x - self.speed
			self.angle = self.angle + .1
			self.y = self.amp+math.sin( self.angle )+self.initY
		end
	end

	sceneGroup = self.view
	--circle = display.newCircle( 100, 100, 12 )

	bg = display.newImageRect( "assets/bg.png", 480, 320 )
	bg.x, bg.y = 0, 0
	bg.anchorX, bg.anchorY = 0, 0

	city1 = display.newImageRect( "assets/city1.png", 480, 228 )
	city1.x, city1.y = 240, 206
	city1.speed = 1	

	city3 = display.newImageRect( "assets/city1.png", 480, 228 )
	city3.x, city3.y = 720, 206
	city3.speed = 1

	city2 = display.newImageRect( "assets/city2.png", 480, 102 )
	city2.x, city2.y = 240, 280
	city2.speed = 2

	city4 = display.newImageRect( "assets/city2.png", 480, 102 )
	city4.x, city4.y = 720, 280
	city4.speed = 2

	city1.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city1 )

	city3.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city3)

	city2.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city2 )	

	city4.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city4 )

	dataSheetJet = {width = 50, height = 17, numFrames = 4, sheetContentWidth = 200, sheetContentHeight =17 }
	jet = graphics.newImageSheet( "assets/jet.png", dataSheetJet )
	sequenceDataJet = {name = "movJet", start = 1, count = 4, time = 2000 }
	jetSprite = display.newSprite( jet, sequenceDataJet )
	jetSprite.x, jetSprite.y = 111, 100

	jetSprite:setSequence( "movJet" )
	jetSprite:play()



	mine1 = display.newImageRect( "assets/mine.png", 49, 46 )
	mine1.x, mine1.y = 500, 100
	mine1.speed = math.random( 2, 6 )
	mine1.initY = mine1.y
	mine1.amp = math.random( 20, 100 )
	mine1.angle = math.random( 1, 360 )
	physics.addBody( mine1, "static", {density = .1, bounce = .1, friction = .2, radius = 12 })
	sceneGroup:insert( mine1 )

	mine1.enterFrame = moveMines
	Runtime:addEventListener("enterFrame", mine1)


	sceneGroup:insert( bg )
	sceneGroup:insert( city1 )
	sceneGroup:insert( city3 )
	sceneGroup:insert( city2 )	
	sceneGroup:insert( city4 )
	sceneGroup:insert( jetSprite )
	sceneGroup:insert( mine1 )
	

end

function scene:destroy( event )
	local seceneGroup = self.view
end



scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )

return scene