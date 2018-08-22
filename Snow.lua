----------------- 下雪动画 ----------------
Snow = Class("Snow",GameObject)
local circles={}
function Snow:init(x,y,sets)
	self.x = x
	self.y = y
	local sets = sets or {}
	for k, v in pairs(sets) do
		self[k] = v
	end
	self.dead = false
	self.cd = 0
	local n = self.n or 40
	local w = 1280
	local h = 720
	for i=1,n do
		local x,y = math.random(1, w),math.random(1, h)
		local radius = math.random(6, 14)
		local color = {1,1,1,math.random(0.1,0.5)}
		circle = {x=x,y=y,r=radius,color=color}
		table.insert(circles, circle)
	end
end

function Snow:draw()
	for _,v in ipairs(circles) do
		love.graphics.setColor(v.color)
		love.graphics.circle("fill",v.x,v.y,v.r-1)
		love.graphics.circle("fill",v.x,v.y,v.r-2)
		love.graphics.circle("fill",v.x,v.y,v.r-3)
		love.graphics.circle("fill",v.x,v.y,v.r-4)
		love.graphics.circle("fill",v.x,v.y,v.r-5)
		love.graphics.circle("fill",v.x,v.y,v.r-6)
	end
	-- love.graphics.setColor(1, 1, 1, 1)
end


function Snow:update(dt)
	--self.cd=self.cd+1
	--if self.cd<5 then return end
	--cd=0
	for i = #circles,1,-1 do
		v=circles[i]
		--v.x = v.x + math.random(-1, 1)
		v.y = v.y + v.r*0.1
		--v.color[4] = math.random(0.1, 0.3)
		if v.y>800 then
		    v.y=-10
		    v.x=v.x+math.random(-10, 10)
		end
	end
end

return Snow