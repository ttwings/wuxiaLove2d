local Screen = require( "lib/Screen" )
local ScreenManager = require("lib/ScreenManager")
local assets = require("lib.cargo").init("assets")
local snow = require( "Snow" )
local MainScreen = {}
local bg = love.graphics.newImage("bg.jpeg")
local font = assets.font.myfont(32)
local titlefont = assets.font.myfont(56)
local menu = {}
local index = 1
function MainScreen.new(  )
    --love.graphics.setFont(font)
    local self = Screen.new()
    local title = love.graphics.newText(titlefont, "武侠与江湖")
    local menuText = love.graphics.newText(font)
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
            menuText:set({ v.color, v.text })
            love.graphics.draw(menuText, 360, 400 + i * 40)
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
    local screenStr = { "game", "help", "main", "battle" }
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