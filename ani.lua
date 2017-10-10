require "lib/animation"
-- ani 动画测试
ani = {}

ani.init = function (img,w,h,dur)
	local w,h,sw,sh,dur,offx,offy
	w = w or 192
	h = h or 192
	dur = dur or 0.05
	local path = "assets/graphics/Animations/"..img..".png"
	local img = love.graphics.newImage(path)
	sw,sh = img:getDimensions()
	ani.animation = love.graphics.newAnimation(img,1,1,w,h,0,0,sw,sh,dur)
	-- ani.animation.mode = 1
end


ani.update = function (dt)
	ani.animation:update(dt)
end

ani.draw = function (x,y,r,sx,sy,offx,offy)
	local x,y
	x = ani.animation.x or 400
	y = ani.animation.y or 300
	ani.animation:draw(x,y,r,sx,sy,offx,offy)
end
