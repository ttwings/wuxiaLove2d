local Moan = require("lib.Moan")
-- local Camera = require("assets.camera")
local flux = require("lib.Moan.flux")
local assets = require('lib.cargo').init('assets')
local font = assets.font.myfont(20)
local roomFunc = {}
wuguanRoomFunc = roomFunc

roomFunc.caidi = {}

function roomFunc.load()
    local room = 'caidi' or player.room
    if room and roomFunc[room].load then
        roomFunc[room].load()
    end
end

function roomFunc.update(dt)
    local room = 'caidi' or player.room
    if room and roomFunc[room].update then
        roomFunc[room].update(dt)
    end
end

function roomFunc.draw()
    local room = 'caidi' or player.room
    if room and roomFunc[room].draw then
        roomFunc[room].draw()
    end
end

function roomFunc.keypressed(key)
    local room = 'caidi' or player.room
    if room and roomFunc[room].keypressed then
        roomFunc[room].keypressed()
    end
end





--
local function doChu(actor)
    local me,weapon
    local costj,costq
    me = actor
    if me.jobName ~= "锄草" then
        return Moan.speak("",{"你必须跟馆主领了这工作才能在这里干! \n"})
    end
    if me.isBusy then
        return Moan.speak("",{"你现在正忙着呢! \n"})
    end
    if me.isFighting then
        return Moan.speak("",{"你正在战斗中,无法专心干活!\n"})
    end
    if me.weapon ~= "锄头" then
        return Moan.speak("",{"你想用什么来锄草，用手吗？\n"})
    end
    if me.target ~= "草" then
        return Moan.speak("",{"你要锄什么？\n"})
    end
    costj = math.random(math.floor(me.con/3))
    costq = math.random(math.floor(me.str/3))
    if me.jingli < costj or me.qi < costq then
        me.unconcious()
        return Moan.speak("",{"$N手一松，不小心锄在自己的脚上。\n"})
    end
    me.receiveDamage("jingli",costj)
    me.add("qi",-costq)
    if me.mark["锄"] > 15 + math.random(5) and npcs["CaiYuanGuanShi"].room == me.room then
        me.mark["完了"] = true
        return Moan.speak(npcs["CaiYuanGuanShi"].name,{"干的不错，好了，你可以到大师兄鲁坤那里去覆命(task ok)了！"})
    end
    Moan.speak("",{"你挥起锄头，对着地上的杂草锄了起来。"})
    me.startBusy(1)
    me.mark["锄"] = me.mark["锄"] + 1
    if me.skill.staff < 20 and math.random(10)>6 then
        me.skill.staff = me.skill.staff + math.floor(me.int/10)
        return Moan.speak("",{"你在锄草中对于杖的用法有些体会!\n"})
    end

end


function roomFunc.caidi.load()
    Moan.font = font
    --
    ---- Add font fallbacks for Japanese characters
    --local JPfallback = love.graphics.newFont("assets/JPfallback.ttf", 32)
    --Moan.font:setFallbacks(JPfallback)
    --
    ---- Audio from bfxr (https://www.bfxr.net/)
    --Moan.typeSound = love.audio.newSource("assets/typeSound.wav", "static")
    --Moan.optionOnSelectSound = love.audio.newSource("assets/optionSelect.wav", "static")
    --Moan.optionSwitchSound = love.audio.newSource("assets/optionSwitch.wav", "static")
    --Moan.noImage = love.graphics.newImage("assets/noImage.png")

    --love.graphics.setBackgroundColor(100, 100, 100, 255)
    --math.randomseed(os.time())
    --
    ---- Make some objects
    --p1 = { x=100, y=200 }
    --p2 = { x=400, y=150 }
    --p3 = { x=200, y=300 }
    --
    ---- Create a HUMP camera and let Moan use it
    --camera = Camera(p1.x, p1.y)
    -- Moan.setCamera(camera)

    -- Set up our image for image argument in Moan.speak config table
    -- avatar = love.graphics.newImage("assets/Obey_Me.png")

    -- Put some messages into the Moan queue
    --Moan.speak({"Möan.lua", {255,105,180}}, {"Hello World!"}, {image=avatar})
    --Moan.speak({"Tutorial", {0,191,255}}, {"Möan.lua is a simple to use messagebox library, it includes;", "Multiple choices,--UTF8 text,--Pauses,--Optional camera control,--Onstart/Oncomplete functions,--Complete customization,--Variable typing speeds umongst other things."},
    --        {x=p2.x, y=p2.y, image=avatar, onstart=function() rand() Moan.UI.messageboxPos = "top" Moan.UI.imagePos = "right" end})
    --Moan.speak("Tutorial", {"Typing sound modulates with speed..."}, {onstart=function() Moan.setSpeed("slow") Moan.UI.messageboxPos = "bottom" end, oncomplete=function() Moan.setSpeed("fast") Moan.UI.titleBoxPos = "left" end})
    --Moan.speak("Tutorial", {"Here's some options:"}, {
    --    options={{"Red", function() red() end},
    --             {"Blue", function() blue() end},
    --             {"Green", function() green() end}}})
    --Moan.speak("",{"你必须跟馆主领了这工作才能在这里干! \n"})

end

function roomFunc.caidi.update(dt)
    Moan.update(dt)
end

function roomFunc.caidi.draw()
    Moan.draw()
end
function roomFunc.caidi.keypressed(key)
    Moan.keyreleased(key)
    --if key == "1" then
        doChu(player)
    --end
end


return roomFunc