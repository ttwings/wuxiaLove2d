local ScreenManager = require( "lib/ScreenManager" )
require("ani")

ani.init("Light1")

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
    ani.draw()
end

function love.update(dt)
	ScreenManager.update(dt)
    ani.update(dt)
end

function love.keypressed( key )
	ScreenManager.keypressed(key)
end

