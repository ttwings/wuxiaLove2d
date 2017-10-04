class = require "middleclass"
Bullet = class("bullet")
Bullet.fireCD = 0.2
Bullet.radius = 5
Bullet.speed = 5
Bullet.length = 100
function Bullet:initialize(parent)
	self.parent = parent --实例化时，把坦克传进来，便于计算开炮位置。
	self.rot = self.parent.cannon.rot + math.pi
	self.x = self.parent.x + math.sin(self.rot)*self.parent.cannon.h/2 --简单的数学方法
	self.y = self.parent.y - math.cos(self.rot)*self.parent.cannon.h/2
	self.vx = self.speed * math.sin(self.rot)
	self.vy = -self.speed * math.cos(self.rot)
end

function Bullet:update(dt)
	self.x = self.x + self.vx
	self.y = self.y + self.vy
	local lx,ly = math.abs(self.x - self.parent.x),math.abs(self.y-self.parent.y)
	print( lx.. ":" ..ly)
	if lx<self.length or ly<self.length or self.x > 800 or self.x<0 or self.y<0 or self.y > 600 then --边界判断
		self.destroyed = true
	end
end
function Bullet:draw()
	love.graphics.setColor(255,255,0,100)
	love.graphics.circle("fill",self.x,self.y,self.radius)
end
function initTank()
	tank = {
		x = 400, --放到屏幕中心
		y = 300,
		w = 60,
		h = 100,
		speed = 1,
		rot = 0,
		cannon = {
			w = 10,
			h = 50,
			radius = 20
		},
		fireCD = Bullet.fireCD,
		fireTimer = 0
	}
	target = {
		x = 0,
		y = 0
	}
end
function keyControl()
	local down = love.keyboard.isDown --方便书写，而且会加快一些速度
	if down("a") then
		tank.rot = tank.rot - 0.1
	elseif down("d") then
		tank.rot = tank.rot + 0.1
	elseif down("w") then
		tank.x = tank.x + tank.speed*math.sin(tank.rot) --速度直接叠加，就不加入vx变量了
		tank.y = tank.y - tank.speed*math.cos(tank.rot)
	elseif down("s") then
		tank.x = tank.x - tank.speed*math.sin(tank.rot) --倒车
		tank.y = tank.y + tank.speed*math.cos(tank.rot)
	end
end
function getRot(x1,y1,x2,y2)
	if x1==x2 and y1==y2 then return 0 end
	local angle=math.atan((x2-x1)/(y2-y1))
	if y1-y2<0 then angle=angle-math.pi end
	if angle>0 then angle=angle-2*math.pi end
	return -angle
end
function mouseControl(dt)
	target.x,target.y = love.mouse.getPosition()
	local rot =  getRot(target.x,target.y,tank.x,tank.y)
	tank.cannon.rot = rot --大炮的角度为坦克与鼠标连线的角度
	tank.fireTimer = tank.fireTimer - dt --这里的开火计时器是十分常用的一种方法，需要学会
	if love.mouse.isDown(1) and tank.fireTimer < 0 then
		tank.fireTimer = tank.fireCD
		table.insert(game.objects,Bullet(tank))
	end
end
function updateBullets(dt)
	for i = #game.objects,1 ,-1 do
		local go = game.objects[i]
		go:update(dt)
		if go.destroyed then table.remove(game.objects,i) end
	end
end
function drawTank()
	--车身
	love.graphics.push()
	love.graphics.translate(tank.x,tank.y)
	love.graphics.rotate(tank.rot)
	love.graphics.setColor(128,128,128)
	love.graphics.rectangle("fill",-tank.w/2,-tank.h/2,tank.w,tank.h) --以0，0为中心
	love.graphics.pop()
	--炮塔
	love.graphics.push()
	love.graphics.translate(tank.x,tank.y)
	love.graphics.rotate(tank.cannon.rot)
	love.graphics.setColor(0,255,0)
	love.graphics.circle("fill",0,0,tank.cannon.radius)
	love.graphics.setColor(0,255,255)
	love.graphics.rectangle("fill",-tank.cannon.w/2,0,tank.cannon.w,tank.cannon.h)
	love.graphics.pop()
	--激光
	love.graphics.setColor(255,0,0)
	love.graphics.line(tank.x,tank.y,target.x,target.y)
end
function drawBullets()
	for i,v in ipairs(game.objects) do
		v:draw()
	end
end
function love.load()
	game = {}
	game.objects = {}
	initTank()
end
function love.update(dt)
	keyControl()
	mouseControl(dt)
	updateBullets(dt)
end
function love.draw()
	drawTank()
	drawBullets()
end