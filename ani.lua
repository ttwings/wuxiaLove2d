require "lib/animation"
-- ani 动画测试
ani = {}

ani.init = function (img,x,y,w,h,dur)
	local w,h,sw,sh,dur,offx,offy
	w = w or 192
	h = h or 192
	dur = dur or 0.05
	local path = "assets/graphics/Animations/"..img..".png"
	local img = love.graphics.newImage(path)
	sw,sh = img:getDimensions()
	ani.animation = love.graphics.newAnimation(img,1,1,w,h,0,0,sw,sh,dur)
	ani.animation.mode = 1
	ani.x = x -80
	ani.y = y -80
	return ani
end


ani.update = function (dt)
	ani.animation:update(dt)
end

ani.draw = function (r,sx,sy,offx,offy)
	ani.animation:draw(ani.x,ani.y,r,sx,sy,offx,offy)
end
