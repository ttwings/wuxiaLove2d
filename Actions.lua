---
--- Created by ttwings.
--- DateTime: 2017/10/19 19:52
---

actions={}
actions.eat = function(actor,target)
    if not objs[target] then return end
    if objs[target].actionA == "吃" or "喝" then
        actor.food = actor.food + objs[target].food
        actor.water = actor.water + objs[target].water
        local x,y,x0,y0
        x = actor.x/2
        y = actor.y/2
        x0 = x
        y0 = y
        local text = objs[target].messageA
        local name = actor.name
        if name == "段誉" then
            name = "你"
        end
        text = string.gsub(text,"$N",name)
        actor.action = text
        --- 移除物品测试  数据移除，图像仍然显示
        for i=#region.objs,1,-1 do
            local objName = region.objs[i].name
            if objName == target then
                table.remove(region.objs,i)
            end
        end
    end

end

actions.fire = function(actor,target)
    local bullet = skills[actor.skill1[1]]
    bullet.x=actor.x/2
    bullet.y=actor.y/2
    bullet.x0=actor.x/2
    bullet.y0=actor.y/2
    bullet.w=4
    bullet.h=4
    bullet.r=actor.r
    --bullet.damage=5
    actor.mp = actor.mp - bullet.mp
    bullets.add(bullet)
    cd = 0
end