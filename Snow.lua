----------------- 下雪动画 ----------------
local snow={}
local circles={}
function snow.init(n)
	local n = n or 40
	local w = 1280
	local h = 800
	for i=1,n do
		local x,y = math.random(1, w),math.random(1, h)
		local radius = math.random(6, 14)
		local color = {255,255,255,10}
		circle = {x=x,y=y,r=radius,color=color}
		table.insert(circles, circle)
	end
end

function snow.draw()
	for i,v in ipairs(circles) do
		love.graphics.setColor(v.color)
		love.graphics.circle("fill",v.x,v.y,v.r-1)
		love.graphics.circle("fill",v.x,v.y,v.r-2)
		love.graphics.circle("fill",v.x,v.y,v.r-3)
		love.graphics.circle("fill",v.x,v.y,v.r-4)
		love.graphics.circle("fill",v.x,v.y,v.r-5)
		love.graphics.circle("fill",v.x,v.y,v.r-6)
	end
	love.graphics.setColor(255, 255, 255, 255)
end

cd=0
function snow.update(dt)
	cd=cd+1
	if cd<5 then return end
	cd=0
	for i = #circles,1,-1 do
		v=circles[i]
		v.x = v.x + math.random(-1, 1)
		v.y = v.y + v.r*0.3
		v.color[4] = v.color[4] + math.random(-2, 2)
		if v.y>800 then
		    v.y=-10
		    v.x=v.x+math.random(-10, 10)
		end
	end
end

return snow