local Class = require "lib/middleclass"
local anim8 = require "lib/anim8"
require("keymap")
local assets = require("lib.cargo").init("assets")
local mapWuGuan = assets.data.mapWuGuan
---- test bullet
bullet = {}
message = {}
--- 角色数据
---@class Actor
Actor = Class("Actor")
Actor["actorMsg"] = {}
Actor["anim"] = {}
Actor["menu"] = false
Actor.heart = 8
function Actor:init(data)
    self:readData(data)
    self.index = 1
    self.heart = 1
end
function Actor:readData(data)
    for k, v in pairs( data ) do
        self[k] = v
    end
    local actorImg = self["actorImg"] or "actor (1)"
    self:anims(actorImg)
    self["animNow"] = self["anim"]["N"]
end
--------------------------- 键盘控制 ------------------------
local cd = 0
function Actor:key(dt)
    cd = cd + dt
    speed = 4
    --cd=cd-dt
    self.hx = self.x
    self.hy = self.y
    if self.state == "闲逛" then
        if love.keyboard.isDown(keymap.R) then
            self.x = self.x + speed
            -- 调整出招的位置
            self.hx = self.x + 32
            self.animNow = self.anim.E
            self.r = 0
            self.toward = 'E'
        elseif love.keyboard.isDown(keymap.L) then
            self.x = self.x - speed
            self.hx = self.x - 8
            self.animNow = self.anim.W
            self.r = math.pi
            self.toward = 'W'
        end

        if love.keyboard.isDown(keymap.D) then
            self.y = self.y + speed
            self.hy = self.y + 48
            self.animNow = self.anim.S
            self.r = math.pi / 2
            self.toward = 'S'
        elseif love.keyboard.isDown(keymap.U) then
            self.y = self.y - speed
            self.hy = self.y - 8
            self.animNow = self.anim.N
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
    self['animNow']=self["anim"][self.toward]
    self["animNow"]:update(dt)
    bullets.update(dt)
    self:heartbeat(dt)
end
------------------ 更新角色的位置 --------------
--function Actor:atRoom()
--    local rx, ry
--    rx = math.modf(self.x / 128) + 1 or 1
--    ry = math.modf(self.y / 128) + 1 or 1
--    if mapWuGuan[ry] and mapWuGuan[ry][rx] then
--        self.room = mapWuGuan[ry][rx]
--    end
--end
------------------ 更新角色的状态 --------------

function Actor:heartbeat(dt)
    self.heart = self.heart - dt
    if self.heart < 0 then
        -- 心跳
        self.heart = 8
        self.food = self.food - 1
        self.water = self.water - 1
        if self.food < 90 then
            if self.debuff then
                table.insert(self.debuff, "饥饿")
            else
                self.debuff = {}
                table.insert(self.debuff, "饥饿")
            end
        end
        if self.water < 30 then
            table.insert(self.debuff, "口渴")
        end
        self.mp = math.min(self.mp + 1, 100)
        self.hp = math.min(self.hp + 1, 100)
    end
end

------------------ 行走图文件 --------------------

function Actor:anims(name)
    self.image = assets.graphics.Characters[name]
    local image = self.image
    local g = anim8.newGrid(32, 64, image:getWidth(), image:getHeight())
    self["anim"]["S"] = anim8.newAnimation(g('1-4', 1), 0.5)
    self["anim"]["W"] = anim8.newAnimation(g('1-4', 2), 0.5)
    self["anim"]["E"] = anim8.newAnimation(g('1-4', 3), 0.5)
    self["anim"]["N"] = anim8.newAnimation(g('1-4', 4), 0.5)
end

function Actor:drawAnim()
    love.graphics.print(self.name, self.x - 8, self.y - 24)
    self["animNow"]:draw(self.image, self.x, self.y)
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

function Actor:subHp(hp)
    if self.hp - hp > 0 then
        self.hp = self.hp - hp
    else
        self.hp = 0
    end
end

function Actor:subMp(mp)
    if self.mp - mp > 0 then
        self.mp = self.mp - mp
    else
        self.mp = 0
    end
end


