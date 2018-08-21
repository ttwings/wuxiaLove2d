require "lib/animation"
local Class = require("lib.middleclass")
-- ani 动画测试
ani = Class("ani")

function ani:init(img,x,y,w,h,dur)
	local w,h,sw,sh,dur,offx,offy
	w = w or 192
	h = h or 192
	dur = dur or 0.05
	local path = "assets/graphics/Animations/"..img..".png"
	local img = love.graphics.newImage(path)
	sw,sh = img:getDimensions()
	self.animation = love.graphics.newAnimation(img,1,1,w,h,0,0,sw,sh,dur)
	self.animation.mode = 1
	self.x = x -80
	self.y = y -80
	return self
end


function ani:update(dt)
	self.animation:update(dt)
end

function ani:draw(r,sx,sy,offx,offy)
	self.animation:draw(self.x,self.y,r,sx,sy,offx,offy)
end
