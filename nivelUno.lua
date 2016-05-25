-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

composer = require "composer"
scene = composer.newScene()
widget = require "widget"


function scene:create( event )

	function scrollCity( self, event)
		if self.x < -477 then
			self.x = 480
		else
			self.x = self.x - self.speed
		end
	end

	sceneGroup = self.view
	--circle = display.newCircle( 100, 100, 12 )

	bg = display.newImageRect( "assets/bg.png", 480, 320 )
	bg.x, bg.y = 0, 0
	bg.anchorX, bg.anchorY = 0, 0

	city1 = display.newImageRect( "assets/city1.png", 480, 228 )
	city1.x, city1.y = 240, 210
	city1.speed = 1
	city2 = display.newImageRect( "assets/city2.png", 480, 102 )
	city2.x, city2.y = 240, 280
	city2.speed = 2

	city3 = display.newImageRect( "assets/city1.png", 480, 228 )
	city3.x, city3.y = 720, 210
	city3.speed = 1

	city4 = display.newImageRect( "assets/city2.png", 480, 102 )
	city4.x, city4.y = 720, 280
	city4.speed = 2

	city1.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city1 )

	city2.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city2 )

	city3.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city3)

	city4.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city4 )

	dataSheetJet = {width = 50, height = 17, numFrames = 4, sheetContentWidth = 200, sheetContentHeight =17 }
	jet = graphics.newImageSheet( "assets/jet.png", dataSheetJet )
	sequenceDataJet = {name = "movJet", start = 1, count = 4, time = 2000 }
	jetSprite = display.newSprite( jet, sequenceDataJet )
	jetSprite.x, jetSprite.y = 111, 100

	jetSprite:setSequence( "movJet" )
	jetSprite:play()


	sceneGroup:insert( bg )
	sceneGroup:insert( city1 )
	sceneGroup:insert( city2 )
	sceneGroup:insert( city3 )
	sceneGroup:insert( city4 )
	sceneGroup:insert( jetSprite )
	

end

function scene:destroy( event )
	local seceneGroup = self.view
end



scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )

return scene