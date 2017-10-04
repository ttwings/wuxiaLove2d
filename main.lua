local ScreenManager = require( "lib/ScreenManager" )
screens = {
	main=require( "MainScreen" ),
	help=require( "HelpScreen" ),
	game=require( "GameScreen" )
}

function love.load( )
	ScreenManager.init(screens,'main')
end

function love.draw()
	ScreenManager.draw()
end

function love.update(dt)
	ScreenManager.update(dt)
end

function love.keypressed( key )
	ScreenManager.keypressed(key)
end

