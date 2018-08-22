local Class = require "lib/middleclass"
local anim8 = require "lib/anim8"
require("keymap")
local assets = require("lib.cargo").init("assets")
local skills = require("assets.data.skills")
local GameScreen = require("GameScreen")
local region = Region
--- 角色数据
--- @class Actor
Actor = Class("Actor",GameObject)
function Actor:init(sets)
    --local data = data or {}
    --for k, v in pairs(data) do
    --    self[k] = v
    --end
    GameObject.init(self,0,0,sets)
    self.grid_x = math.ceil(self.x / 32)
    self.grid_y = math.ceil(self.y / 32)
    self:getAnims(self["actorImg"])
    self.cd = 1
    self.sleep = false
end

--------------------------- 菜单控制 ------------------------
local keyFunc = {}
keyFunc["战斗"] = {}
keyFunc["闲逛"] = {}

keyFunc["战斗"][keymap.select] = function(actor)
    actor.state = "闲逛"
end
keyFunc["闲逛"][keymap.select] = function(actor)
    actor.state = "战斗"
end


keyFunc["闲逛"][keymap.U] = function(actor)
    actor:moveN()
end
keyFunc["闲逛"][keymap.D] = function(actor)
    -- Actions.moveS(actor)
    actor:moveS()
end
keyFunc["闲逛"][keymap.L] = function(actor)
    actor:moveW()
end
keyFunc["闲逛"][keymap.R] = function(actor)
    actor:moveE()
end
keyFunc["闲逛"][keymap.A] = function(actor)
    Actions.get(actor, actor.target)
end
keyFunc["闲逛"][keymap.B] = function(actor)
    DoSomeThing.chu_di(actor)
end


keyFunc["闲逛"][keymap.X] = function(actor)
    Actions.wear(actor, actor.target)
end
keyFunc["闲逛"][keymap.Y] = function(actor)
    Actions.unwear(actor, actor.target)
end
keyFunc["闲逛"][keymap.R1] = function(actor)
    Actions.bagItemUp(actor, actor.target)
end
keyFunc["闲逛"][keymap.L1] = function(actor)
    Actions.bagItemDown(actor, actor.target)
end
keyFunc["战斗"][keymap.B] = function(actor)
    Actions.fire(actor, actor.target)
    actor:attack()
end
keyFunc["战斗"][keymap.U] = function(actor)
    actor:moveN()
end
keyFunc["战斗"][keymap.D] = function(actor)
    -- Actions.moveS(actor)
    actor:moveS()
end
keyFunc["战斗"][keymap.L] = function(actor)
    actor:moveW()
end
keyFunc["战斗"][keymap.R] = function(actor)
    actor:moveE()
end
function Actor:keypressed(key)
    if keyFunc[self.state] and keyFunc[self.state][key] then
        keyFunc[self.state][key](self)
    end
end

-------------- 总体功能 -------------------------
function Actor:draw()
    self:drawAnim()
end

function Actor:update(dt)
    self.image=self["anim"][self.toward]
    self.image:update(dt)
    self:heartbeat(dt)
end
------------------ 更新角色的状态 --------------

function Actor:heartbeat()
    local heart = self.Con - 1
    if heart < 0 then
        -- 心跳
        heart = self.Con
        self.food = math.max(self.food - 1,0)
        self.water = math.max(self.water - 1,0)
        if self.food < 30 then
            self:addCondition("饥饿")
        end
        if self.water < 30 then
            self:addCondition("口渴")
        end
        self.mp = math.min(self.mp + 1, 100)
        self.hp = math.min(self.hp + 1, 100)
    end
end

function Actor:addCondition(con)
    if con == nil then
        print("not condition find")
    end
    if self.condition[con] then
        self.condition[con] = self.condition[con] + 1
    else
        table.insert(self.condition, {[con]=1})
    end
end
------------------ 行走图文件 --------------------

function Actor:getAnims(name)
    self.moveImg = assets.graphics.Characters[name]
    local image = self.moveImg
    local g = anim8.newGrid(32, 64, image:getWidth(), image:getHeight())
    self.anim = {}
    self["anim"]["S"] = anim8.newAnimation(g('1-4', 1), 0.5)
    self["anim"]["W"] = anim8.newAnimation(g('1-4', 2), 0.5)
    self["anim"]["E"] = anim8.newAnimation(g('1-4', 3), 0.5)
    self["anim"]["N"] = anim8.newAnimation(g('1-4', 4), 0.5)
    self.image = self["anim"][self.toward]
end

function Actor:drawAnim()
    --love.graphics.print(self.name, self.x - 8, self.y - 24)
    self.image:draw(self.moveImg, self.x, self.y)
    --love.graphics.draw(self.actorImg, self.x, self.y)
    love.graphics.colorRectangle("fill", self.x, self.y + 50, self.hp, 2, { 255, 0, 0, 255 })
    love.graphics.colorRectangle("fill", self.x, self.y + 52, self.mp, 2, { 0, 0, 255, 255 })
    love.graphics.colorRectangle("fill", self.x, self.y + 54, self.ap, 2, { 0, 255, 0, 255 })
    -- 绘制矩形碰撞体，方便测试
    --love.graphics.rectangle("line",self.x,self.y,32,48)
    -- 绘制真气护盾
    --if self.mp>0 and #self.force>0 then
    --	love.graphics.setColor(100,100,100,100)
    --	love.graphics.circle("fill",self.x+16,self.y+24,24)
    --	love.graphics.setColor(255,255,255,255)
    --end

    -- 绘制阴影 碰撞体
    --love.graphics.setColor(255,200,200,100)
    --love.graphics.circle("fill",self.x+16,self.y+48,16)
    --love.graphics.setColor(255,255,255,255)
    -- 绘制手部位置
    --love.graphics.rectangle('fill',self.x + 32,self.y + 32,32,32)
    --love.graphics.print(self.r..'',self.x,self.y + 32)
end

function Actor:unconcious()
    if self.state == "昏迷" then
        self.turn = self.turn + 100
        print(self.name .. "昏迷了。")
        return true
    end
end

function Actor:startBusy(turn)
    self.turn = self.turn + turn
    print(self.name .. "晕了")
end
function Actor:canPass(d_grid_x,d_grid_y)
    local grid_x = self.grid_x + d_grid_x
    local grid_y = self.grid_y + d_grid_y
    for i, v in pairs(npcs) do
        if v.grid_x == grid_x and v.grid_y == grid_y then
            return false
        end
    end
    return true
end

function Actor:move(d_grild_x,d_grild_y)
    -- if self:can_pass(d_grild_x,d_grild_y) then
        self.grid_x = self.grid_x + d_grild_x
        self.grid_y = self.grid_y + d_grild_y
        local xx,yy = self.grid_x * 32,self.grid_y * 32
        timer:tween(0.2, self, { x = xx, y = yy }, 'in-linear')
    -- end
end

function Actor:moveS()
    self.toward = "S"
    self.image = self["anim"][self.toward]
    self:move(0,1)
end

function Actor:moveN()
    self.toward = "N"
    self.image = self["anim"][self.toward]
    self:move(0,-1)
end

function Actor:moveE()
    self.toward = "E"
    self.image = self["anim"][self.toward]
    self:move(1,0)
end

function Actor:moveW()
    self.toward = "W"
    self.image = self["anim"][self.toward]
    self:move(-1,0)
end

function Actor:getHandGrid()
    local ax,ay = 0,0
    if self.toward == "N" then
        ax = self.grid_x
        ay = self.grid_y - 1
    end
    if self.toward == "S" then
        ax = self.grid_x
        ay = self.grid_y + 1
    end
    if self.toward == "W" then
        ax = self.grid_x - 1
        ay = self.grid_y
    end
    if self.toward == "E" then
        ax = self.grid_x + 1
        ay = self.grid_y
    end
    return ax,ay
end

function Actor:attack()
    if self.skill == nil or self.skill == "" then
        self.skill = "罗汉拳"
    end
    local ax,ay = self:getHandGrid()
    local skill = skills["罗汉拳"]
    local skill_x,skill_y = ax * 32,ay * 32
    animations.add(skill.anim,skill_x,skill_y)
    animations.add(skill.anim,skill_x + 32,skill_y + 32)
    messages.add(skill.name)
    -- GameScreen.cam:shake(0.1,4)
end

function Actor:pickup()
    local ax,ay = self:getHandGrid()
    local objs = region.objs
    for k, v in pairs(objs) do
        if objs.gx == ax and objs.gy == ay then
            table.insert(self.bag,v)
            return "pick up " .. k
        end
    end
    return "nothing find"
end

function Actor:use()

    local obj = {}
    local sets = {}
    if objType(self.target) == "Food" then
        sets = Foods:readData(self.target)
        obj = Food:new(0,0,sets)
    end
end

function Actor:eat()
    sets = Foods:readData(self.target)
    local obj = Food:new(0,0,sets)
    self.food = math.min(self.food + obj.food,self.max_food)
    self.action = string.format("你拿起%s,吃了起来",obj.name)
end

