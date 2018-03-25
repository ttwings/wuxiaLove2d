---
--- Created by ttwings.
--- DateTime: 2017/10/19 19:52
---
module('Actions', package.seeall)
local assets = require("lib.cargo").init("assets")
local armors = assets.data.armors
local skills = assets.data.skills
local stuff = assets.data.stuffData
local objs = assets.data.objs

function eat(actor, target)
    if not objs[target] then
        return
    end
    if objs[target].actionA == "吃" or "喝" then
        actor.food = actor.food + objs[target].food
        actor.water = actor.water + objs[target].water
        --- message
        local text = objs[target].messageA
        local name = actor.name
        if name == "段誉" then
            name = "你"
        end
        text = string.gsub(text, "$N", name)
        actor.action = text
        --- 移除物品测试  数据移除，图像仍然显示
        for i = #region.objLayer.objects, 1, -1 do
            local objName = region.objLayer.objects[i].name
            if objName == target then
                table.remove(region.objLayer.objects, i)
                table.insert(actor.misc, target)
            end
        end
    end

end
---@type actor actorData
function fire(actor, target)
    local bullet = skills["罗汉拳"]
    print("临时使用 罗汉拳")
    bullet.x = actor.hx
    bullet.y = actor.hy
    bullet.x0 = actor.hx
    bullet.y0 = actor.hy
    bullet.w = 4
    bullet.h = 4
    bullet.r = actor.r
    --bullet.damage=5
    actor.mp = actor.mp - bullet.mp
    --actor:subMp(bullet.mp)
    bullets.add(bullet)
    --    cd = 0
end

function wear(actor, target)
    if armors[target] and armors[target].type == "衣服" then
        if actor.equip[2] == "无" then
            actor.equip[2] = target
            local msg = armors[target].messageC or "$N将$n穿在身上！"
            msg = string.gsub(msg, "$N", actor.name)
            msg = string.gsub(msg, "$n", target)
            messages.add(msg)
        else
            table.insert(actor.misc, actor.equip[2])
            actor.equip[2] = target
        end
    end
end
---@param actor actorData
---@param target actorData
function unwear(actor, target)
    if actor ~= "无" then
        table.insert(actor.misc, actor.equip[2])
        actor.equip[2] = "无"
    end
end

local function bagItemUp(actor, target)
    if #actor.misc > 0 then
        if actor.index > 1 then
            actor.index = actor.index - 1
        end
        actor.target = actor.misc[actor.index]
    end
    print(actor.target)
end

local function bagItemDown(actor, target)
    if #actor.misc > 0 then
        if actor.index < #actor.misc then
            actor.index = actor.index + 1
        end
        actor.target = actor.misc[actor.index]
    end
    print(actor.target)
end

function find(actor, target)
    local objs = region.objs
    for i = #objs, 1, -1 do
        local objName = objs[i].name
        local bx, by = objs[i].x, objs[i].y
        local ax, ay = actor.x / 2, actor.y / 2
        local distance = math.abs(bx - ax) + math.abs(by - ay)
        if (distance < 100) then
            actor.target = objName
            actor.tx = bx
            actor.ty = by
            break
        else
            actor.target = ""
        end
    end
end

---@param target stuff 采集原材料
function gather(actor, target)
    if stuff[target] then
        if #actor.misc < 11 then
            message.add("采集到" .. target)
            table.insert(actor.misc, target)
        end
    end
end

---@param target obj 捡到物品
function get(actor,target)
    if objs[target] then
        if #actor.misc < 11 then
            --message.add("采集到" .. target)
            table.insert(actor.misc, target)
        end
    end
end

function moveN(actor, dt)
    actor.toward = 'N'
    actor.turn = gameTurn + 1
    local xx, yy
    yy = actor.y - 32
    xx = actor.x
    timer:tween(0.2, actor, { x = xx, y = yy }, 'in-linear')
end

function moveS(actor, dt)
    actor.toward = 'S'
    actor.turn = actor.turn + 1
    local xx, yy
    yy = actor.y + 32
    xx = actor.x
    timer:tween(0.2, actor, { x = xx, y = yy }, 'in-linear')
end

function moveW(actor, dt)
    actor.toward = 'W'
    actor.turn = actor.turn + 1
    local xx, yy
    yy = actor.y
    xx = actor.x - 32
    timer:tween(0.2, actor, { x = xx, y = yy }, 'in-linear')
end

function moveE(actor, dt)
    actor.toward = 'E'
    actor.turn = actor.turn + 1
    local xx, yy
    yy = actor.y
    xx = actor.x + 32
    timer:tween(0.2, actor, { x = xx, y = yy }, 'in-linear')
end

function moveE(actor, dt)
    actor.toward = 'E'
    actor.turn = actor.turn + 1
    local xx, yy
    yy = actor.y
    xx = actor.x + 32
    timer:tween(0.2, actor, { x = xx, y = yy }, 'in-linear')
end

function moveEN(actor, dt)
    actor.toward = 'EN'
    actor.turn = actor.turn + 1
    local xx, yy
    yy = actor.y - 32
    xx = actor.x + 32
    timer:tween(0.2, actor, { x = xx, y = yy }, 'in-linear')
end

function moveES(actor, dt)
    actor.toward = 'ES'
    actor.turn = actor.turn + 1
    local xx, yy
    yy = actor.y + 32
    xx = actor.x + 32
    timer:tween(0.2, actor, { x = xx, y = yy }, 'in-linear')
end

function moveWN(actor, dt)
    actor.toward = 'E'
    actor.turn = actor.turn + 1
    local xx, yy
    yy = actor.y - 32
    xx = actor.x - 32
    timer:tween(0.2, actor, { x = xx, y = yy }, 'in-linear')
end

function moveWS(actor, dt)
    actor.toward = 'E'
    actor.turn = actor.turn + 1
    local xx, yy
    yy = actor.y + 32
    xx = actor.x - 32
    timer:tween(0.2, actor, { x = xx, y = yy }, 'in-linear')
end

function wait(actor, turn)
    actor.turn = actor.turn + turn
end

function lockTarget(actor, target)
    local tx = target.x
    local ty = target.y
    local ax = actor.x
    local ay = actor.y
    actor.toward = math.getDirection(ax, ay, tx, ty)
end