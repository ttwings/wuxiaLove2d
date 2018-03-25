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

---替换 print 输出debug 信息
testing()
---
local font = love.graphics.newFont("assets/font/myfont.ttf", 20)


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
    love.graphics.setFont(font)
    ScreenManager.init(screens, 'main')

end

function love.draw()
    ScreenManager.draw()
    local stats = love.graphics.getStats()
    local i = 1
    local str = string.format("texture memory used: %.2f MB", stats.texturememory / 1024 / 1024)
    for k, v in pairs(stats) do
        if k == "texturememory" then
           v =  string.format("%d MB", stats.texturememory / 1024 / 1024)
        end
        str = k .. ":" .. v
        love.graphics.print(k .. ":" .. v, 1080, i * 20 )
        i = i + 1
    end

end

function love.update(dt)
    ScreenManager.update(dt)
    timer:update(dt)
end

function love.keypressed( key )
    ScreenManager.keypressed(key)
end

