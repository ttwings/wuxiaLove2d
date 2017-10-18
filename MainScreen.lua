local Screen = require( "lib/Screen" )
local ScreenManager = require("lib/ScreenManager")
local snow = require( "Snow" )
local MainScreen = {}
local bg = love.graphics.newImage("bg.jpeg")
local font = love.graphics.newFont("assets/font/myfont.ttf", 32)
local titlefont = love.graphics.newFont("assets/font/myfont.ttf", 56)
local menu = {}
local index = 1
function MainScreen.new(  )
    love.graphics.setFont(font)
    local self = Screen.new()
    local x, y, w, h = 20, 20, 40, 20
    title = love.graphics.newText(titlefont, "武侠与江湖")
    menu[1] = { color = { 255, 0, 0, 255 }, text = "新的穿越" }
    menu[2] = { color = { 255, 0, 0, 255 }, text = "梦回武林" }
    menu[3] = { color = { 255, 0, 0, 255 }, text = "侠客宝典" }
    menu[4] = { color = { 255, 0, 0, 255 }, text = "归隐山林" }
    -- 下雪
    snow.init(100)
    function self:draw(  )
        love.graphics.draw(bg, 0, 0, 0)
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.draw(title, 300, 40)
        love.graphics.setColor(255, 255, 255, 255)
        for i, v in ipairs(menu) do
            love.graphics.print({ v.color, v.text }, 360, 400 + i * 40)
            if i == index then
                menu[i].color = { 255, 255, 255, 255 }
            else
                menu[i].color = { 0, 0, 0, 255 }
            end
        end

        snow.draw()
    end

    function self:update( dt )
        snow.update(dt)
    end
    local screenStr = { "main", "help", "game", "help" }
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