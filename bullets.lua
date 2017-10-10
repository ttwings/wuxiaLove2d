---
--- Created by ttwings.
--- DateTime: 2017/10/8 23:01
---
bullets = {}
local bullet = {x0,y0,x,y,w,h,r=0,speed,range,color}

bullets.update = function(dt)
    local vx,vy
    local lx,ly
    local b
    for i = #bullets,1,-1 do
        b = bullets[i]
        vx = b.speed * math.cos(b.r)*dt
        vy = b.speed * math.sin(b.r)*dt
        b.x = b.x + vx
        b.y = b.y + vy
        lx = b.x - b.x0
        ly = b.y - b.y0
        if (lx^2 + ly^2)>b.range^2 then
            table.remove(bullets,i)
        end
        local text = string.format("%d:%d",lx^2 + ly^2,b.range^2)
        print(text)

    end


end

bullets.draw = function()
    for i = #bullets,1,-1 do
        local b = bullets[i]
        --local vx,vy
        --vx = b.speed * math.cos(b.r)
        --vy = b.speed * math.sin(b.r)
        --b.x = b.x + vx
        --b.y = b.y + vy
        love.graphics.setColor(b.color)
        love.graphics.rectangle("fill",b.x+16,b.y+16,b.w,b.h)
        love.graphics.circle("line",b.x0+16,b.y0+16,b.range)
        love.graphics.setColor({255,255,255,255})
        --love.graphics.rectangle("fill",200,200,200,200)
    end
end

bullets.add = function(bullet)
    table.insert(bullets,bullet)
end

return bullets