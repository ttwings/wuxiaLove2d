require("lib.messages")
require("lib.Color")
Camera = require("lib.gamera")
require("lib.guiData")
require("lib.guiDraw")
require("lib.drawTool")
require("lib.util")
require("assets.data.actors")
require("assets.data.mapWuGuan")
require("assets.data.skills" )
require("assets.data.rooms")
require("assets.data.objs")
require("Actions")
require("Actor")
require("animations")
require("bullets")
require("Date")
require("keymap")
require("region")
require("Npc")
__TESTING = true
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
	love.graphics.setColor(Color["紫色"])
	love.graphics.drawLightning(400,0,400,400,100,1)
	lg.setColor(Color.WHITE)
end

function love.update(dt)
	ScreenManager.update(dt)
end

function love.keypressed( key )
	ScreenManager.keypressed(key)
end

