local Class=require "lib/middleclass"
local anim8=require "lib/anim8"
require("keymap")
---- test bullet
bullet={}
message={}
--- 角色数据
---@class Actor
Actor=Class("Actor")
Actor["actorMsg"]={}
Actor["anim"]={}
Actor["menu"]=false

function Actor:init(data)
	self:readData(data)
	self.index = 1
end
function Actor:readData(data)
	for k,v in pairs( data ) do
		self[k]=v
	end
	local actorImg=self["actorImg"] or "actor (1).png"
	self:image(actorImg)
	self:anims()
	self["animNow"]=self["anim"]["moveDown"]
end
--------------------------- 键盘控制 ------------------------
local cd=0
function Actor:key(dt)
	cd = cd + dt
	speed = 16
	--cd=cd-dt
	if love.keyboard.isDown(keymap.R) then
		self.x = self.x + speed
		self.animNow=self.anim.moveRight
		self.r = 0
	elseif love.keyboard.isDown(keymap.L) then
		self.x = self.x - speed
		self.animNow=self.anim.moveLeft
		self.r = math.pi
	end

	if love.keyboard.isDown(keymap.D) then
		self.y = self.y + speed
		self.animNow=self.anim.moveDown
		self.r = math.pi/2
	elseif love.keyboard.isDown(keymap.U) then
		self.y = self.y - speed
		self.animNow=self.anim.moveUp
		self.r = math.pi*1.5
	end
end
--------------------------- 菜单控制 ------------------------
local keyFunc={}
keyFunc["战斗"] = {}
keyFunc["闲逛"] = {}

keyFunc["战斗"][keymap.select] = function(actor)
	actor.state = "闲逛"
end
keyFunc["闲逛"][keymap.select] = function(actor)
	actor.state = "战斗"
end
keyFunc["闲逛"][keymap.A] = function(actor)
	actions.find(actor,actor.target)
end
keyFunc["闲逛"][keymap.B] = function(actor)
	actions.eat(actor,actor.target)
end
keyFunc["闲逛"][keymap.X] = function(actor)
	actions.wear(actor,actor.target)
end
keyFunc["闲逛"][keymap.Y] = function(actor)
	actions.unwear(actor,actor.target)
end
keyFunc["闲逛"][keymap.R1] = function(actor)
	actions.bagItemUp(actor,actor.target)
end
keyFunc["闲逛"][keymap.L1] = function(actor)
	actions.bagItemDown(actor,actor.target)
end
keyFunc["战斗"][keymap.B] = function(actor)
	actions.fire(actor,actor.target)
end
function Actor:keypressed(key)
	if keyFunc[self.state] and keyFunc[self.state][key] then
		keyFunc[self.state][key](self)
	end
end

-------------- 总体功能 -------------------------
function Actor:draw()
	--Actor:drawMsg()
	--Actor:drawBag()
	--Actor:drawFly()
	bullets.draw()
	--messages.draw()
end

function Actor:update(dt)
	-- self:key(dt)
	self:atRoom()
	self["animNow"]:update(dt)
	bullets.update(dt)
	self:heartbeat(dt)
end
------------------ 更新角色的位置 --------------
function Actor:atRoom()
	local rx,ry
	rx = math.modf(self.x/128)+1 or 1
	ry = math.modf(self.y/128)+1 or 1
	if mapWuGuan[ry] and mapWuGuan[ry][rx] then
		self.room=mapWuGuan[ry][rx]
	end
end
------------------ 更新角色的状态 --------------
local heart = 0
function Actor:heartbeat(dt)
	heart = heart + dt
	if heart > self.Str/4 then
		heart = 0
		self.food = self.food - 1
		self.water = self.water - 1
		if self.food < 90 then
			if self.debuff then
				table.insert(self.debuff,"饥饿")
			else
				self.debuff = {}
				table.insert(self.debuff,"饥饿")
			end
		end
		if self.water < 30 then
			table.insert(self.debuff,"口渴")
		end
		self.mp = math.min(self.mp + 1,100)
		self.hp = math.min(self.hp + 1,100)
	end
end


------------------ 行走图文件 --------------------
function Actor:image(name)
	local path = "assets/graphics/Characters/"
	self.image=love.graphics.newImage(path .. name)
end

function Actor:anims()
	local image = self.image
	local g = anim8.newGrid(32,48,image:getWidth(),image:getHeight())
	self["anim"]["moveDown"] = anim8.newAnimation(g('1-4',1),0.3)
	self["anim"]["moveLeft"] = anim8.newAnimation(g('1-4',2),0.3)
	self["anim"]["moveRight"] = anim8.newAnimation(g('1-4',3),0.3)
	self["anim"]["moveUp"] = anim8.newAnimation(g('1-4',4),0.3)
end

function Actor:drawAnim()
	love.graphics.print(self.name,self.x - 8,self.y - 24)
	self["animNow"]:draw(self.image,self.x,self.y)
end