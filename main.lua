require("lib.messages")
require("lib.Color")
assets = require("lib.cargo").init("assets")

--Object = require("lib.classic")
Class = require("lib.middleclass")
Camera = require("lib.gamera")
Input = require("lib.input")
Physics = require("lib.windfield")
Richtext = require("lib.richtext")
require("lib.guiDraw")
require("lib.util")

require('globle')

require("lib.behavior3.b3")
requireDirectory("lib/behavior3/core")
requireDirectory("lib/behavior3/actions")
requireDirectory("lib/behavior3/composites")
requireDirectory("lib/behavior3/decorators")
require("Actions")
require("Actor")
require("animations")
require("Date")
require("keymap")
require("Region")
require("Npcs")

Timer = require( 'lib.Timer' )
local ScreenManager = require( "lib/ScreenManager" )
screens = {
    main = require( "MainScreen" ),
    new = require("NewScreen"),
    help = require( "HelpScreen" ),
    game = require( "GameScreen" ),
    battle = require("BattleScreen")
}

function love.load( )
    --- font
    assets = require("lib.cargo").init("assets")
    font = assets.font.myfont(20)
    love.graphics.setFont(font)    ---替换 print 输出debug 信息
    love.keyboard.setKeyRepeat(true)
    testing()
    timer = Timer()
    --- Input
    input = Input()
    input:bind("e","up")
    input:bind("d","down")
    input:bind("f","right")
    input:bind("s","left")
    input:bind("g","back")
    input:bind("h","start")
    input:bind("j","d-left")
    input:bind("l","d-right")
    input:bind("i","d-up")
    input:bind("k","d-down")

    ScreenManager.init(screens, 'main')
end

function love.update(dt)

    ScreenManager.update(dt)

    timer:update(dt)
end


function love.draw()
    ---@param hook
    --debug.sethook(hook,"c")
    ScreenManager.draw()
    --debug.sethook()

    graphicsStats()
    --drawHook()
end

function love.keypressed( key )
    ScreenManager.keypressed(key)
end

