require("lib.messages")
require("lib.Color")
Camera = require("lib.gamera")
require("lib.guiData")
require("lib.guiDraw")
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
require("Region")
require("Npc")
__TESTING = true
Timer = require( 'lib.Timer' )
local ScreenManager = require( "lib/ScreenManager" )
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

