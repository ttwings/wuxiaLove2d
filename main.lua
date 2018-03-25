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

Timer = require( 'lib.Timer' )
local ScreenManager = require( "lib/ScreenManager" )
screens = {
    main = require( "MainScreen" ),
    help = require( "HelpScreen" ),
    game = require( "GameScreen" ),
    battle = require("BattleScreen")
}

function love.load( )
    ---替换 print 输出debug 信息
    testing()
    timer = Timer()
    ScreenManager.init(screens, 'main')
end

function love.update(dt)

    ScreenManager.update(dt)

    timer:update(dt)
end


function love.draw()
    debug.sethook(hook,"c")
    ScreenManager.draw()
    debug.sethook()

    graphicsStats()
    drawHook()
end

function love.keypressed( key )
    ScreenManager.keypressed(key)
end

