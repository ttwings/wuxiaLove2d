require("lib.messages")
require("lib.Color")
assets = require("lib.cargo").init("assets")

--Object = require("lib.classic")
Camera = require("lib.Camera")
Input = require("lib.input")
Physics = require("lib.windfield")
Richtext = require("lib.richtext")
Class = require("lib.middleclass")

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
    --- assets
    assets = require("lib.cargo").init("assets")
    --- object load
    local object_files = {}
    recursiveEnumerate('objects',object_files)
    requireFiles(object_files)
    --- font init
    font = assets.font.myfont(20)
    love.graphics.setFont(font)    ---替换 print 输出debug 信息
    --- debug output
    testing()
    --- slow animation update use
    slow_amount = 1
    timer = Timer()
    camera = Camera()
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
    current_room = MainStage:new()
    --ScreenManager.init(screens, 'main')
end

function love.update(dt)
    timer:update(dt*slow_amount)
    camera:update(dt*slow_amount)
    if current_room then current_room:update(dt*slow_amount) end    --ScreenManager.update(dt)
end


function love.draw()
    if current_room then current_room:draw() end
    ---@param hook
    --debug.sethook(hook,"c")
    --ScreenManager.draw()
    --debug.sethook()

    graphicsStats()
    --drawHook()
end

--function love.keypressed( key )
--    --ScreenManager.keypressed(key)
--end

function slow(amount,duration)
    slow_amount = amount
    timer:tween(duration,_G,{slow_amount = 1},"in-out-cubic")
end

