---
--- Created by ttwings.
--- DateTime: 2017/10/9 1:11
---
messages = {}
local message = {text="",x,y,speed,range,color}
messages.update = function(dt)
    local vx,vy
    local lx,ly
    local b
    for i = #messages,1,-1 do
        b = messages[i]
        vx = 0
        vy = b.speed *dt
        b.x = b.x + vx
        b.y = b.y - vy
        lx = b.x - b.x0
        ly = b.y - b.y0
        if ly^2>b.range^2 then
            table.remove(messages,i)
        end
    end
end

messages.draw = function()
    for i = #messages,1,-1 do
        local b = messages[i]
        local wide = #b.text
        love.graphics.setColor(b.color)
        love.graphics.print(b.text,b.x-40,b.y)
        love.graphics.setColor({255,255,255,255})
    end
end

messages.add = function(bullet)
    table.insert(messages,bullet)
end

return messages