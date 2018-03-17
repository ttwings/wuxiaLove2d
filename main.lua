require("lib.messages")
require("lib.Color")
Camera = require("lib.gamera")
require("lib.guiDraw")
require("lib.util")
require("lib.behavior3.b3")
requireDirectory("lib/behavior3/core")
requireDirectory("lib/behavior3/actions")
requireDirectory("lib/behavior3/composites")
requireDirectory("lib/behavior3/decorators")
require("Actions")
require("Actor")
require("animations")
require("bullets")
require("Date")
require("keymap")
require("Region")
require("Npcs")

testing()
Timer = require( 'lib.Timer' )

local ScreenManager = require( "lib/ScreenManager" )
--- testing print
print("test")
screens = {
    main = require( "MainScreen" ),
    help = require( "HelpScreen" ),
    game = require( "GameScreen" ),
    battle = require("BattleScreen")
}

function love.load( )
    timer = Timer()
    ScreenManager.init(screens, 'main')
end

function love.draw()
    ScreenManager.draw()
end

function love.update(dt)
    ScreenManager.update(dt)
    timer:update(dt)
end

function love.keypressed( key )
    ScreenManager.keypressed(key)
end

