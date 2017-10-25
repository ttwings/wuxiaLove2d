function colorRec(r,c)
	if c==nil then c={r=255,g=255,b=255,a=255} end
	love.graphics.setColor(c.r,c.g,c.b,c.a)
	love.graphics.rectangle("fill", r.x, r.y, r.w, r.h)
	love.graphics.setColor(255,255,255,255)
end
-- 绘制矩阵
function drawRectangle(r)
	love.graphics.rectangle("fill", r.x, r.y, r.w, r.h)
end
-- 绘制圆
function drawCircle(c)
	love.graphics.circle("fill", c.x, c.y, c.r)
end
--显示血条
function colorHp(r)
	love.graphics.rectangle("line",r.x,r.y-16,r.w,8)
	now = math.max(0,r.now)
	color = {r=255-now*255/r.max,g=now*255/r.max,b=0,a=255}
	love.graphics.setColor(color.r,color.g,color.b,color.a)
	love.graphics.rectangle("fill",r.x,r.y-16,now*r.w/r.max,8)
	love.graphics.setColor(255,255,255,255)
end

-- 矩形碰撞检测
function aabb(a,b)
	if a.x+a.w<b.x then return false end
	if a.x>b.x+b.w then return false end
	if a.y+a.h<b.y then return false end
	if a.y>b.y+b.h then return false end
	return true
end
-- 圆形碰撞检测
function cc(c1,c2)
	rr=math.pow(c1.r+c2.r,2)
	ll=math.pow(c1.x-c2.x,2)+math.pow(c1.y-c2.y,2)
	if rr>ll then return true end
	return false
end
-- 移动
function move(b,dt)
	b.x = b.x + b.vx*dt
	b.y = b.y + b.vy*dt
end
-- local bullets={}
-- local bullet={x,y,w,h}
-- 子弹飞行
local shootDele = 8
function fireBullet(p,bullets)
	if p.fire then
		if shootDele>0 then
	    	shootDele=shootDele-1
		else
			shootDele=1
			--散弹效果
			local bullet1={x=p.x,y=p.y,w=200,h=200,vx=0,vy=0,cd=5000}
			-- local bullet2={x=p.x+p.w/2-5,y=p.y,w=1,h=1,vx=400,vy=-400,l=90}
			-- local bullet3={x=p.x+p.w/2-5,y=p.y,w=1,h=1,vx=400,vy=0,l=80}
			-- local bullet4={x=p.x+p.w/2-5,y=p.y,w=1,h=1,vx=0,vy=-400,l=70}
			-- local bullet5={x=p.x+p.w/2-5,y=p.y,w=1,h=1,vx=-400,vy=0,l=60}
			-- local bullet6={x=p.x+p.w/2-5,y=p.y,w=1,h=1,vx=0,vy=400,l=50}
			-- local bullet7={x=p.x+p.w/2-5,y=p.y,w=1,h=1,vx=400,vy=400,l=40}
			-- local bullet8={x=p.x+p.w/2-5,y=p.y,w=1,h=1,vx=-400,vy=400,l=30}

			table.insert(bullets,bullet1)
			-- table.insert(bullets,bullet2)
			-- table.insert(bullets,bullet3)
			-- table.insert(bullets,bullet4)
			-- table.insert(bullets,bullet5)
			-- table.insert(bullets,bullet6)
			-- table.insert(bullets,bullet7)
			-- table.insert(bullets,bullet8)
		end
	end
end
-- 绘制子弹
function drawBullets(b)
	for i=#b,1,-1 do
		v=b[i]
		love.graphics.rectangle("fill",v.x,v.y,v.w,v.h)
	end
end
-- 更新子弹
function updataBullet(b,e,dt)

	if b~=nil then
		for i=#b,1,-1 do
			v=b[i]
			v.cd=v.cd+dt
			move(v,dt)
			if aabb(v,e) then
		    	e.now = e.now-1
		   		table.remove(b,i)
			end
			if v.cd>50 then
				v.cd=0
		    	table.remove(b,i)
			end
		end
	end
end

-- 激光
-- p={x,y,w,h}
function drawLight(p,e)
	if p.light then
		local l={x=p.x,y=p.y-500,w=2,h=500}
		local c={r=100,g=0,b=255,a=245}
		colorRec(l,c)
		if aabb(l,e) then
		    e.now = e.now -1
		end
	end
end
-- 获取块
function getTile(img,x,y,w,h)
	local quad = love.graphics.newQuad(x*w,y*h,w,h,img:getDimensions())
	return quad
end
-- 绘制块
function drawTile(img,tx,ty,tw,th,x,y)
	local quad = love.graphics.newQuad(tx*tw,ty*th,tw,th,img:getDimensions())
	love.graphics.draw(img,quad,x,y)
end

return drawTool