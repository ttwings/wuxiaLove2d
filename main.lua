local ScreenManager = require( "lib/ScreenManager" )
require("animations")
require("lib.messages")
screens = {
	main=require( "MainScreen" ),
	help=require( "HelpScreen" ),
	game=require( "GameScreen" )
}

function love.load( )
	love.keyboard.setKeyRepeat(true)
	ScreenManager.init(screens,'main')
end

function love.draw()
	ScreenManager.draw()
	--messages.draw()
end

function love.update(dt)
	ScreenManager.update(dt)
	--messages.update(dt)
end

function love.keypressed( key )
	ScreenManager.keypressed(key)
end

