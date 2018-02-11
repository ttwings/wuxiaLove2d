---
--- Created by ttwings.
--- DateTime: 2017/10/11 0:37
---

require("ani")
animations = {}

animations.add = function (aniName,x,y,w,h,dur)
    local animation = ani.init(aniName,x,y,w,h,dur)
    table.insert(animations,animation)
end

animations.update = function(dt)
    for i = #animations,1,-1 do
        local a = animations[i]
        a.update(dt)
        if not a.animation.isPlay then
            table.remove(animations,i)
            --print(#animations)
        end
    end
end

animations.draw = function()
    for i = #animations,1,-1 do
        local a = animations[i]
        a.draw()
    end
end

return animations