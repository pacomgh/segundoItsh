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

	function onPlayBtnRelease( )
	 	
	 	composer.gotoScene( "nivelUno", "fade", 700 )

	 end 
		
	local playBtn
	sceneGroup = self.view
	--circle = display.newCircle( 100, 100, 12 )

	local bg = display.newImageRect( "assets/start.png", 480, 320 )
	bg.x, bg.y = 0, 0
	bg.anchorX, bg.anchorY = 0, 0

	playBtn = widget.newButton{
		width = 154, height = 40,
		--if we'll use an assets we must use default and overfile instruction
		--if we'll use a text we must use only default and over
		defaultFile = "assets/button.png",
		overFile =  "assets/button-over.png",
		onRelease = onPlayBtnRelease
	 } 

	playBtn.x = 236
	playBtn.y = 286

	sceneGroup:insert( bg )
	sceneGroup:insert( playBtn )

end


function scene:destroy( event )
	--if we have physichs librarie we must do this
	--package.loaded[physics] = nil
	--physics = nil

	local sceneGroup = self.view

end


scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )

return scene