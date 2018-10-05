local Screen = require( "lib/Screen" )
local ScreenManager = require("lib/ScreenManager")
local assets = require("lib.cargo").init("assets")
require( "Snow" )
require("objects.GameObject")
local MainScreen = {}
local bg = love.graphics.newImage("bg.jpeg")
local font = assets.font.myfont(32)
local titlefont = assets.font.myfont(56)
local menu = {}
local index = 1
function MainScreen.new(  )

    local self = Screen.new()
    --local title = love.graphics.newText(titlefont, "武侠与江湖")
    local init_color = {1,1,1,1}
    local text_style = {}
    text_style.black = {0, 0, 0}
    text_style.green = {0, 1, 0}
    text_style.red = {1, 0, 0}
    text_style.big = assets.font.myfont(56)
    local menu_text = Richtext:new({"武侠 {green}世界{red},{big}大文本.", 300, text_style }, init_color )
    local title = Richtext:new({"{big}{black}武侠与江湖",200,text_style})
    local menuText = love.graphics.newText(font)
    menu[1] = { color = { 1, 0, 0, 1 }, text = "新的穿越" }
    menu[2] = { color = { 1, 0, 0, 1 }, text = "梦回武林" }
    menu[3] = { color = { 1, 0, 0, 1 }, text = "侠客宝典" }
    menu[4] = { color = { 1, 0, 0, 1 }, text = "归隐山林" }
    -- 下雪
    Snow:new(0,0,{n = 100})
    function self:draw(  )
        love.graphics.draw(bg, 0, 0, 0)
        love.graphics.setColor(0, 0, 0, 1)
        --love.graphics.draw(title, 300, 40)
        title:draw(300,40)
        love.graphics.setColor(1, 1, 1, 1)
        for i, v in ipairs(menu) do
            menuText:set({ v.color, v.text })
            love.graphics.draw(menuText, 360, 400 + i * 40)
            if i == index then
                menu[i].color = { 1, 1, 1, 1 }
            else
                menu[i].color = { 0, 0, 0, 1 }
            end
        end
        Snow:draw()
        menu_text:draw(200,200)
    end

    function self:update( dt )
        Snow:update(dt)
    end
    local screenStr = { "new","game", "help", "main" }
    function self:keypressed(key)
        if key == keymap.U and index > 1 then
            index = index - 1
        elseif key == keymap.D and index < 4 then
            index = index + 1
        elseif key == keymap.A then
            ScreenManager.switch(screenStr[index])
        end
    end
    return self
end


return MainScreen