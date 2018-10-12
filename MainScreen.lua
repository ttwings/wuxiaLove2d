local Screen = require( "lib/Screen" )
local ScreenManager = require("lib/ScreenManager")
local assets = require("lib.cargo").init("assets")
require( "Snow" )
require("objects.GameObject")
require("objects.InfoPanel")
local MainScreen = {}
local bg = love.graphics.newImage("bg.jpg")
local font = assets.font.myfont(32)
local menu = {}
local index = 1

---
function MainScreen.new(  )

    local self = Screen.new()

    local menu_text = Richtext:new({"武侠 {q1}世界{q2},{q3}大文本.", 300, text_style }, init_color )
    local title = Richtext:new({"{q1}武侠与江湖",200,text_style},init_color)
    local menuText = love.graphics.newText(font)
    menu[1] = { color = { 1, 0, 0, 1 }, text = "新的穿越" }
    menu[2] = { color = { 1, 0, 0, 1 }, text = "梦回武林" }
    menu[3] = { color = { 1, 0, 0, 1 }, text = "侠客宝典" }
    menu[4] = { color = { 1, 0, 0, 1 }, text = "归隐山林" }
    -- 下雪
    Snow:new(0,0,{n = 100})
    local food =  {name = "劣质金疮药",type = "物品 / 药丸",material = "药",quality= 9,dur = 1,dur_max = 2,weight = 0.1,use_type = "气血",use = "-50",value = 10,des = "治疗外伤的良药。但可惜的是放的时间太长了，反倒是起了相反的效果"}
    local book = {name = "罗汉拳秘籍",type = "书籍 / 秘籍",material = "纸",quality= 5,dur = 1,dur_max = 4,weight = 0.5,use_type = "习得",use = "罗汉拳",value = 3000,des = "一本武林秘籍，记载着少林寺罗汉拳。"}
    local panel = InfoPanel:new(nil,100,100,food)
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
        panel:draw()
    end

    function self:update( dt )
        Snow:update(dt)
        panel:update(dt)
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