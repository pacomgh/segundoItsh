-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

composer = require "composer"
scene = composer.newScene()

--physics.setDrawMode( "hybrid" )

function scene:create( event )
	local seceneGroup = self.view
	
	local bg = display.newImageRect( "assets/restart.png", 480, 320  )
	bg.x, bg.y = 0, 0
	bg.anchorX, bg.anchorY = 0, 0
	seceneGroup:insert( bg )

	city2 = display.newImageRect( "assets/city2.png", 480, 102 )
	city2.x, city2.y = 240, 280
	seceneGroup:insert( city2 )	

end


scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )

return scene