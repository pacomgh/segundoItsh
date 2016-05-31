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
--physics.setDrawMode( "hybrid" )

function scene:create( event )

	function scrollCity( self, event)
		if self.x < -477 then
			self.x = 480
		else
			self.x = self.x - self.speed
		end
	end

	function moveMines( self, event )
		if self.x < -50 then
			self.x = 500
			self.y = math.random( 90, 220 )
			self.speed = math.random( 2, 6 )
			self.amp = math.random( 20, 100 )
			self.angle = math.random( 1, 360 )
		else
			self.x = self.x - self.speed
			self.angle = self.angle + .1
			self.y = self.amp*math.sin( self.angle )+self.initY
		end
	end

	function jetReady( )
		jetSprite.bodyType = "dynamic"
	end

	function activateJets( self, event )
		self:applyForce( 0, -1.5, self.x, self.y )
		print( "run" )
	end

	function touchScreen( event )
		print( "touch" )
		if event.phase == "began" then
			jetSprite.enterFrame = activateJets
			Runtime:addEventListener( "enterFrame", jetSprite )
		end

		if event.phase == "ended" then
			Runtime:removeEventListener( "enterFrame", jetSprite )
		end
	end

	function explode(  )
		explosionSprite.x, explosionSprite.y = jetSprite.x, jetSprite.y
		explosionSprite.isVisible = true
		explosionSprite:play()
		jetSprite.isVisible = false
		timer.performWithDelay( 3000, gameOver, 1 )
	end

	function onCollision( event )
		if event.phase == "began" then
			if jetSprite.collided == false then
				jetSprite.collide = true
				jetSprite.bodyType = "static"
				explode()		
				explosionSprite.isVisible = false
				--composer.gotoScene("restart", "fade", 500)		
				gameOver()
			end
		end
	end

	function gameOver(  )
		composer.gotoScene( "restart", "fade", 500 )
	end

	sceneGroup = self.view
	--circle = display.newCircle( 100, 100, 12 )

	bg = display.newImageRect( "assets/bg.png", 480, 320 )
	bg.x, bg.y = 0, 0
	bg.anchorX, bg.anchorY = 0, 0

	ceiling = display.newImageRect( "assets/invisibleTile.png", 480, 25 )
	ceiling.x, ceiling.y = 0, 0
	ceiling.anchorX, ceiling.anchorY = 0, 0
	physics.addBody( ceiling, "static", {density=.1, bounce=.1, friction=.2} )
	sceneGroup:insert(ceiling)

	floor = display.newImageRect( "assets/invisibleTile.png", 480, 25 )
	floor.x, floor.y = 240, 307
	physics.addBody( floor, "static", {density=.1, bounce=.1, friction=.2} )
	sceneGroup:insert(floor)

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

	dataSheetJet = {width = 50, height = 17, numFrames = 4, sheetContentWidth = 200, sheetContentHeight =17 }
	jet = graphics.newImageSheet( "assets/jet.png", dataSheetJet )
	sequenceDataJet = {name = "movJet", start = 1, count = 4, time = 2000 }
	jetSprite = display.newSprite( jet, sequenceDataJet )
	jetSprite.x, jetSprite.y = 111, 100

	jetSprite:setSequence( "movJet" )
	jetSprite:play()
	jetSprite.collided = false
	physics.addBody( jetSprite, "static", {density=.1, bounce=.1, friction=.2, radius=12} )
	jetIntro = transition.to( jetSprite, { time=2000, x=100, onComplete=jetReady } )

	dataSheetExplosion = {width=24, height=23, numFrames=8, sheetContentWidth=192, sheetContentHeight=23}
	explosion = graphics.newImageSheet( "assets/explosion.png", dataSheetExplosion )
	sequenceDataExplosion = {name = "movExplosion", start = 1, count = 8, time = 2000}
	explosionSprite = display.newSprite( explosion, sequenceDataExplosion )



	mine1 = display.newImageRect( "assets/mine.png", 49, 46 )
	mine1.x, mine1.y = 500, 100
	mine1.speed = math.random( 2, 6 )
	mine1.initY = mine1.y
	mine1.amp = math.random( 20, 100 )
	mine1.angle = math.random( 1, 360 )
	physics.addBody( mine1, "static", {density = .1, bounce = .1, friction = .2, radius = 12 })

	mine2 = display.newImageRect( "assets/mine.png", 49, 46 )
	mine2.x, mine2.y = 500, 100
	mine2.speed = math.random( 2, 6 )
	mine2.initY = mine2.y
	mine2.amp = math.random( 20, 100 )
	mine2.angle = math.random( 1, 360 )
	physics.addBody( mine2, "static", {density = .1, bounce = .1, friction = .2, radius = 12} )
	
	mine3 = display.newImageRect( "assets/mine.png", 49, 46 )
	mine3.x, mine3.y = 500, 100
	mine3.speed = math.random( 2, 6 )
	mine3.initY = mine3.y
	mine3.amp = math.random( 20, 100 )
	mine3.angle = math.random( 1, 360 )
	physics.addBody( mine3, "static", {density = .1, bounce = .1, friction = .2, radius = 12} )
	

	Runtime:addEventListener("touch", touchScreen)

	city1.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city1 )

	city3.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city3)

	city2.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city2 )	

	city4.enterFrame = scrollCity
	Runtime:addEventListener( "enterFrame", city4 )

	mine1.enterFrame = moveMines
	Runtime:addEventListener("enterFrame", mine1)

	mine2.enterFrame = moveMines
	Runtime:addEventListener("enterFrame", mine2)

	mine3.enterFrame = moveMines
	Runtime:addEventListener("enterFrame", mine3)

	Runtime:addEventListener("collision", onCollision)


	sceneGroup:insert( bg )
	sceneGroup:insert( city1 )
	sceneGroup:insert( city3 )
	sceneGroup:insert( city2 )	
	sceneGroup:insert( city4 )
	sceneGroup:insert( jetSprite )
	sceneGroup:insert( mine1 )
	sceneGroup:insert( mine2 )
	sceneGroup:insert( mine3 )
	

end

function scene:destroy( event )
	local seceneGroup = self.view
end



scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )

return scene