require("lib.messages")
require("lib.Color")
require("lib.guiData")
require("lib.guiDraw")
require("lib.drawTool")
require("assets.data.actors")
require("assets.data.mapWuGuan")
require("assets.data.skills" )
require("assets.data.rooms")
require("assets.data.objs")
require("animations")
require("bullets")
require("keymap")
require("Actions")
require("Actor")
require("animations")
require("Date")
require("bullets")
require("region")
require("Npc")
local ScreenManager = require( "lib/ScreenManager" )
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
end

function love.update(dt)
	ScreenManager.update(dt)
end

function love.keypressed( key )
	ScreenManager.keypressed(key)
end

