require("lib.messages")
require("lib.Color")
assets = require("lib.cargo").init("assets")
Gooi = require("lib.gooi")
Camera = require("lib.Camera")
Input = require("lib.input")
Physics = require("lib.windfield")
Class = require("lib.middleclass")
Names = assets.data.names
require("lib.guiDraw")
require("lib.util")
require("globle")
require("lib.behavior3.b3")
requireDirectory("lib/behavior3/core")
requireDirectory("lib/behavior3/actions")
requireDirectory("lib/behavior3/composites")
requireDirectory("lib/behavior3/decorators")
require("Actions")
require("Actor")
require("animations")
--require("Date")
require("keymap")
require("Region")
require("Npcs")

Timer = require( 'lib.Timer' )
screens = {
    main = require( "MainScreen" ),
    new = require("NewScreen"),
    help = require( "HelpScreen" ),
    game = require( "GameScreen" ),
    battle = require("BattleScreen")
}
rooms = {}
function love.load( )
    love.graphics.setDefaultFilter('nearest','nearest')
    --- assets
    assets = require("lib.cargo").init("assets")
    --- object load
    local object_files = {}
    recursiveEnumerate('objects',object_files)
    requireFiles(object_files)
    --- font init
    font = assets.font.myfont(20)
    love.graphics.setFont(font)    ---替换 print 输出debug 信息
    ---gooi ui init
    gooi.desktopMode()
    gooi.shadow()
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

    current_room = nil
    upper_room = current_room
    --MainStage:deactivate()
    gotoRoom("MainStage","MainStage")
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
    --debug.sethook()
    graphicsStats()
    --drawHook()
end

function love.mousereleased(x, y, button) if current_room then current_room:mousereleased()  end end
function love.mousepressed(x, y, button)  if current_room then current_room:mousepressed()  end end

function slow(amount,duration)
    slow_amount = amount
    timer:tween(duration,_G,{slow_amount = 1},"in-out-cubic")
end

