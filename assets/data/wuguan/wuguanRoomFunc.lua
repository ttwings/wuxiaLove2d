local assets = require('lib.cargo').init('assets')
local doSomeThing = require("DoSomeThing")
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


function roomFunc.caidi.load()

end

function roomFunc.caidi.update(dt)

end

function roomFunc.caidi.draw()

end
function roomFunc.caidi.keypressed(key)
    --if key == "1" then
    if player.message == nil then
        player.message = {}
    end
    table.insert(player.message,doSomeThing.doChu(player))
    --end
end


return roomFunc