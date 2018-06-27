local Class = require "lib/middleclass"
local anim8 = require "lib/anim8"
require("keymap")
local assets = require("lib.cargo").init("assets")
--- 角色数据
---@class Actor
Actor = Class("Actor")
function Actor:init(data)
    self:readData(data)
end
function Actor:readData(data)
    for k, v in pairs( data ) do
        self[k] = v
    end
    local actorImg = self["actorImg"]
    self:getAnims(actorImg)
end
--------------------------- 键盘控制 ------------------------
local cd = 0
function Actor:key(dt)
    cd = cd + dt
    speed = 8
    --cd=cd-dt
    self.hx = self.x
    self.hy = self.y
    if self.state == "闲逛" then
        if love.keyboard.isDown(keymap.R) then
            self.x = self.x + speed
            -- 调整出招的位置
            self.hx = self.x + 32
            self.image = self.anim.E
            self.r = 0
            self.toward = 'E'
        elseif love.keyboard.isDown(keymap.L) then
            self.x = self.x - speed
            self.hx = self.x - 8
            self.image = self.anim.W
            self.r = math.pi
            self.toward = 'W'
        end

        if love.keyboard.isDown(keymap.D) then
            self.y = self.y + speed
            self.hy = self.y + 48
            self.image = self.anim.S
            self.r = math.pi / 2
            self.toward = 'S'
        elseif love.keyboard.isDown(keymap.U) then
            self.y = self.y - speed
            self.hy = self.y - 8
            self.image = self.anim.N
            self.r = math.pi * 1.5
            self.toward = 'N'
        end
    end

end

--------------------------- 菜单控制 ------------------------
local keyFunc = {}
keyFunc["战斗"] = {}
keyFunc["闲逛"] = {}

keyFunc["战斗"][keymap.select] = function(actor)
    actor.state = "闲逛"
    --ScreenManager.switch("game")
end
keyFunc["闲逛"][keymap.select] = function(actor)
    actor.state = "战斗"
    --ScreenManager.switch("battle")
end
keyFunc["闲逛"][keymap.A] = function(actor)
    Actions.get(actor, actor.target)
end
keyFunc["闲逛"][keymap.B] = function(actor)
    Actions.eat(actor, actor.target)
    for i, v in pairs(_G) do
        print("test _G")
        print(i ..":".. tostring(v))
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
end
keyFunc["战斗"][keymap.U] = function(actor)
    Actions.moveN(actor)
end
keyFunc["战斗"][keymap.D] = function(actor)
    Actions.moveS(actor)
end
keyFunc["战斗"][keymap.L] = function(actor)
    Actions.moveW(actor)
end
keyFunc["战斗"][keymap.R] = function(actor)
    Actions.moveE(actor)
end
function Actor:keypressed(key)
    if keyFunc[self.state] and keyFunc[self.state][key] then
        keyFunc[self.state][key](self)
    end
end

-------------- 总体功能 -------------------------
function Actor:draw()
    bullets.draw()
    --messages.draw()
end

function Actor:update(dt)
    self.image=self["anim"][self.toward]
    self.image:update(dt)
    bullets.update(dt)
    self:heartbeat(dt)
end
------------------ 更新角色的状态 --------------

function Actor:heartbeat()
    local heart = self.Con - 1
    if heart < 0 then
        -- 心跳
        heart = self.Con
        self.food = self.food - 1
        self.water = self.water - 1
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

function Actor:addCondition(actor,con)
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
    self.image = self["anim"]["N"]
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
    self.state = "昏迷"
    self.turn = self.turn + 100
    print(self.name .. "昏迷了。")
end

function Actor:startBusy(turn)
    self.turn = self.turn + turn
    print(self.name .. "晕了")
end


