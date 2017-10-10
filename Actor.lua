Class=require "lib/middleclass"
anim8=require "lib/anim8"
require "assets/data/actors"
require "assets/data/mapWuGuan"
require("bullets")
require("lib.messages")
---- test bullet
bullet={}
message={}
Actor=Class("actor")
Actor["actorMsg"]={}
-- fly Msg
local flyMsg={x=400,y=400,text="飞行测试信息",cd}
local flyMsgs={}
Actor["anim"]={}
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

-- 房间移动
function Actor:moveRoom(roomName)
	local dt=love.timer.getDelta()
	local roomX,roomY = rooms[1]["x"],rooms[1]["y"]
	local x = tonumber(roomX)
	local y = tonumber(roomY)
	move(self,x,y,dt)
	if (roomX-x+roomY-y)<16 then
		self["房间"]=roomName
	end
end
-- 区域移动
function Actor:moveRegion(regionName)
	self["区域"]=regionName
end
-- 观察
function Actor:look(msg)
	self["看"]=msg
	table.insert(self["actorMsg"],self["名称"].."看到"..msg)
end

-- 说话
function Actor:say(msg)
	self["说"]=msg
	table.insert(self["actorMsg"],self["名称"].."："..msg)
end
-- -- 思考
-- function Actor:think(actor,msg)
-- 	actor["想"]=msg
-- 	table.insert(actorMsg,actor["名称"].."心想"..msg)
-- end
-- -- 听到
-- function Actor:listen(actor,msg)
-- 	actor["听"]=msg
-- 	table.insert(actorMsg,actor["名称"].."听到"..msg)
-- end
-- -- 写出
-- function Actor:wirte(actor,msg)
-- 	actor["写"]=msg
-- 	table.insert(actorMsg,actor["名称"].."写下"..msg)
-- end
-- -- 得到
-- function Actor:get(actor,msg)
-- 	table.insert(actor["bag"],msg)
-- 	table.insert(actorMsg,actor["名称"].."得到"..msg)
-- end
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
	speed = 600
	--cd=cd-dt
	if love.keyboard.isDown("f") then
        self.x = self.x + dt*speed
        self.animNow=self.anim.moveRight
		self.r = 0
    	elseif love.keyboard.isDown("s") then
    		self.x = self.x - dt*speed
    		self.animNow=self.anim.moveLeft
			self.r = 3.1415
    end

    if love.keyboard.isDown("d") then
    	self.y = self.y + dt*speed
    	self.animNow=self.anim.moveDown
		self.r = 3.1415/2
    	elseif love.keyboard.isDown("e") then
    		self.y = self.y - dt*speed
    		self.animNow=self.anim.moveUp
			self.r = 3.1415*1.5
    end

    -- if love.keyboard.isDown("j") then


    -- end
	local bullet = {x=self.x/2,y=self.y/2,x0=self.x/2,y0=self.y/2,w=4,h=4,r=self.r or 0,color={255,0,0,100},range=100,speed=1000,cd=0.5}
	local message = {text="暴击",x=self.x/2,y=self.y/2,x0=self.x/2,y0=self.y/2,w=4,h=4,r=self.r or 0,color={255,255,0,255},range=100,speed=100,cd=0.5}
	cd = cd + dt
	local text = string.format("%s%s%s%s%s",bullet.x/2,bullet.y/2,bullet.x0/2,bullet.y0/2,#bullets)
	if love.keyboard.isDown("k") and cd > message.cd then
    	-- table.insert(self.actorMsg,self["名称"] .. "测试信息")
    	-- fly msg test
    	--local msg={x=self.x,y=self.y,text="测试信息111",cd=3}
		--table.insert(flyMsgs,msg)
		bullets.add(bullet)
		messages.add(message)
		--print(text)
		cd = 0
    end
end

function Actor:keypressed(key)
	local key = love.keypressed
	-- Exit test
	if key("escape") then
		love.event.quit()
	end
	-- Reset translation
	if key("j") then
		if self.target~=nil then
    		table.insert( self.misc,self.target)
			print( #self.misc .. ":"..self.misc[#self.misc] )
    	end
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
local cd
function getObj()
	if self.target~=nil then
    	table.insert( self.misc,self.target)
		print( #self.misc .. ":"..self.misc[#self.misc] )
   end
end
