-- id                               string                           角色ID
-- name                             string                           名称
-- fname                            string                           姓
-- lname                            string                           名
-- nickname                         string                           绰号
-- title                            string                           头衔
-- unique                           boolean                          独特
-- country                          string                           国家
-- description                      string                           描述
-- gender                           string                           性别
-- sect                             string                           门派
-- age                              int                              年龄
-- turn                             int                              回合
-- exp                              int                              历练
-- faith                            string                           信仰
-- moral                            int                              道德
-- attitude                         string                           态度
-- reputation                       int                              声望
-- force                            int                              内力
-- strike                           int                              攻击
-- dodge                            int                              躲闪
-- parry                            int                              招架
-- skill                            tableString[k:#1(string)|v:#2(int)]   技能
-- mapSkill                         tableString[k:#1(string)|v:#2(string)]   装备技能
-- Str                              int                              臂力
-- Con                              int                              根骨
-- Dex                              int                              身法
-- Int                              int                              悟性
-- Wis                              int                              五感
-- Cha                              int                              容貌
-- Luc                              int                              福源
-- maxHP                            int                              最大气血
-- maxMP                            int                              最大真气
-- maxAP                            int                              最大精力
-- maxEP                            int                              最大精神
-- hp                               int                              气血
-- mp                               int                              真气
-- ap                               int                              体力
-- ep                               int                              精神
-- weapon                           string                           武器
-- armor                            tableString[k:#seq|v:#1(string)]   防具
-- misc                             tableString[k:#seq|v:#1(string)]   杂物
-- state                            string                           状态
-- action                           string                           动作
-- region                           string                           区域
-- room                             string                           房间
-- obj                              string                           发现物品
-- target                           string                           遇见角色
-- food                             string                           食物
-- water                            string                           饮水
-- money                            int                              金钱
-- x                                int                              坐标x
-- y                                int                              坐标y
-- tx                               int                              tiled坐标x
-- ty                               int                              tiled坐标y
-- actorImg                         string                           行走图
-- anim                             tableString[k:#1(string)|v:#2(int)]   动画
-- image                            tableString[k:#1(string)|v:#2(int)]   图像
-- faceImg                          string                           头像
-- toward                           string                           朝向
-- condition                        tableString[k:#1(string)|v:#2(int)]   状态
-- isBusy                           boolean                          忙碌中
-- isFighting                       boolean                          战斗中
-- jobName                          mapString[name=string,number=int,state=string,obj=string]   工作名称
-- mark                             tableString[k:#1(string)|v:#2(int)]   标记
-- encumbrance                      int                              负重
-- message                          tableString[k:#seq|v:#1(string)]   讯息






Class = require "lib/middleclass"
local anim8 = require "lib/anim8"
require("keymap")
local assets = require("lib.cargo").init("assets")
local font = assets.font.myfont(20)
love.graphics.setFont(font)
local skills = require("assets.data.skills")
local region = Region


require("objects.Food")
GameObject = require("objects.GameObject")
--- 角色数据
--- @class Actor
--- @param area Area
--- @param x number
--- @param y number
--- @param opts table
--- @field id string
--- @field fname string 姓
--- @field lname string 名
--- @field name string 姓名

Actor = Class("Actor",GameObject)
function Actor:init(area,x,y,opts)
    --GameObject.init(self,area,x,y,opts)
    self.x = x or 0
    self.y = y or 0
    self.grid_x = math.ceil(self.x / 32)
    self.grid_y = math.ceil(self.y / 32)
    self.actorImg = assets.graphics.characters.actor_001
    --self:getAnims(self["actorImg"] or "actor (1)")
    self.id = UUID()
    self.fname = ""
    self.lname = ""
    self.name = ""
    self.gender = ""
    self.age = 16
    self.nickname = ""
    self.country = ""
    self.family = ""
    self.sect = ""
    self.title = ""
    self.turn = 0
    self.cd = 1
    self.sleep = false
    self.max_food = 100
    self.max_water = 100
    self.condition = {}
    self.isOpenBag = false
    self:bagInit()
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
    -- Actions.get(actor, actor.target)
    actor:eat()
end
keyFunc["闲逛"][keymap.B] = function(actor)
    -- DoSomeThing.chu_di(actor)
    if actor.isOpenBag then
        actor.isOpenBag = false
    else
        actor.isOpenBag = true
    end
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
    if self.isOpenBag then
        self:openBag()
    end
end

function Actor:update(dt)
    self.image=self["anim"][self.toward]
    self.image:update(dt)
    self:heartbeat(dt)

end
------------------ 更新角色的状态 --------------
local heart = 0
function Actor:heartbeat()
    heart = heart + 1
    if heart > 600 then
        heart = 0
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

function Actor:getObj()
    local id = self.target
    local objs = require("assets.data.objs")
    if objs[id] then
        if bojs[id] == "food" then
            local food = Food:getFromId(id)
            table.insert(bag,food)
        end
    end
end

function Actor:findObj()
    local ax,ay = self:getHandGrid()
    local objs = region.objs
    for k, v in pairs(objs) do
        if objs.gx == ax and objs.gy == ay then
            self.target = objs.id
            return self.target
        end
    end
end

function Actor:bagInit()
    self.bag = {}
    self.bagSize = 20
    self.bagIndex = 1
    self.bag[1] = Food:new(0,0,{id = "米饭"})
    self.bag[2] = Food:new(0,0,{id = "米饭"})
end

function Actor:eat()
     local item = self.bag[self.bagIndex]
     if item.action.eat then
        item:eatby(self)
     end
end

function Actor:openBag()
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle("fill",self.x,self.y,200,200,8)
    love.graphics.setColor(1,1,1,1)
    for i, v in ipairs(self.bag) do
        love.graphics.draw(v.img,self.x + i*32,self.y)
        love.graphics.print(v.name,self.x,self.y + i * 20)
    end
end

