Class=require "lib/middleclass"
anim8=require "lib/anim8"
require "assets/data/actors"
require "assets/data/mapWuGuan"
require("bullets")
require("lib.messages")
require( "assets/data/skills" )
require("lib.Color")
require("keymap")
require("Actions")
---- test bullet
bullet={}
message={}
Actor=Class("actor")
Actor["actorMsg"]={}
Actor["anim"]={}
Actor["menu"]=false
function Actor:initialize(data)
	self:readData(data)
end
function Actor:readData(data)
	for k,v in pairs( data ) do
		self[k]=v
	end
	local actorImg=self["actorImg"] or "002-Fighter02.png"
	self:image(actorImg)
	self:anims()
	self["animNow"]=self["anim"]["moveDown"]
end

-- 坐标移动
function Actor:move(x,y,dt)
	local speed = 25600
	local dx,dy=x-self.x,y-self.y
	local round=dx^2+dy^2
	if round<4 then return end
	if math.abs(dx)>math.abs(dy) then
		self.x = self.x + math.sign(dx)*speed*dt
	elseif math.abs(dx)<math.abs(dy) then
		self.y = self.y + math.sign(dy)*speed*dt
	elseif math.abs(dx)==math.abs(dy) then
		self.x = self.x + math.sign(dx)*speed*dt
		self.y = self.y + math.sign(dy)*speed*dt
	end
end

--------------------------- love2d 绘制部分 ---------------
function Actor:drawMsg()
	if self.actorMsg~=nil then
		for i = 1, #self.actorMsg do
			love.graphics.print(self.actorMsg[i], 20, 400+i*20)
		end
	end
end
-- 背包绘制
function Actor:drawBag()
	if self.bag~=nil then
		for i = 1, #self.bag do
			love.graphics.print(self.bag[i], 1220, 400+i*20)
		end
	end
end

--------------------------- 键盘控制 ------------------------

cd=0
function Actor:key(dt)
	cd = cd + dt
	speed = 600
	--cd=cd-dt
	if love.keyboard.isDown(keymap.R) then
		self.x = self.x + dt*speed
		self.animNow=self.anim.moveRight
		self.r = 0
	elseif love.keyboard.isDown(keymap.L) then
		self.x = self.x - dt*speed
		self.animNow=self.anim.moveLeft
		self.r = math.pi
	end

	if love.keyboard.isDown(keymap.D) then
		self.y = self.y + dt*speed
		self.animNow=self.anim.moveDown
		self.r = math.pi/2
	elseif love.keyboard.isDown(keymap.U) then
		self.y = self.y - dt*speed
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
	actions.eat(actor,actor.target)
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
	messages.draw()
end

function Actor:update(dt)
	-- self:key(dt)
	self:atRoom()
	self["animNow"]:update(dt)
	bullets.update(dt)
	messages.update(dt)
	self:heartbeat(dt)
end
------------------ 更新角色的位置 --------------
function Actor:atRoom()
	local rx,ry
	rx = math.modf(self.x/256)+1 or 1
	ry = math.modf(self.y/256)+1 or 1
	if mapWuGuan[ry][rx] then
		self.room=mapWuGuan[ry][rx]
	end
end
------------------ 更新角色的状态 --------------
local heart = 0
function Actor:heartbeat(dt)
	heart = heart + dt
	if heart > actor.Str/4 then
		heart = 0
		self.food = self.food - 1
		self.water = self.water - 1
		if self.food < 90 then
			self.debuff[1] = "饥饿"
		end
		if self.water < 30 then
			self.debuff[2] = "口渴"
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
	self["animNow"]:draw(self.image,self.x/2,self.y/2)
end
--------------------------- 获得物品 ---------------------------
function getObj()
	if self.target~=nil then
    	table.insert( self.misc,self.target)
		print( #self.misc .. ":"..self.misc[#self.misc] )
   end
end
