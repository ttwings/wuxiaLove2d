local rt={}
rt.padding = {0,0,0,0}	-- top,left,bottom,right
rt.margin = {0,0,0,0}	-- top,left,bottom,right
rt.tempcanvas = love.graphics.newCanvas( )
rt.canvas = love.graphics.newCanvas( )
rt.cursor = 0

function rt:setFont(font)
	self.richtext = love.graphics.newText(font)
end

function rt:setPadding(padding)
	self.padding=padding
end

function rt:setMargin(margin)
	self.margin=margin
end

function rt:set(color,text,bgcolor)
	self.richtext:set({color,text})
	self.bgcolor = bgcolor
end

function rt:draw(x,y)
	if x==nil then x=self.cursor end
	if y==nil then y=0 end
	love.graphics.setColor( self.bgcolor )
	love.graphics.rectangle( "fill", 
		x,
		y,
		self.richtext:getWidth()+self.padding[4]+self.padding[2],
		self.richtext:getHeight()+self.padding[3]+self.padding[1] )
	love.graphics.setColor( 255,255,255,255 )
	love.graphics.draw(self.richtext,x+self.padding[2],y+self.padding[1])
	self.cursor = x+self.richtext:getWidth()
	+self.padding[4]+self.padding[2]
	+self.margin[4]+self.margin[2]
end

function rt:wrap()
	love.graphics.setCanvas(self.tempcanvas)
	love.graphics.clear()
	love.graphics.draw(self.canvas,0,self:getHeight())
	love.graphics.setCanvas(self.canvas)
	love.graphics.clear()
	love.graphics.draw(self.tempcanvas)
	love.graphics.setCanvas()
	self.cursor = 0
end

function rt:update(func)
	love.graphics.setCanvas(self.canvas)
	func()
	love.graphics.setCanvas()
end

function rt:getHeight()
	return self.richtext:getHeight()
	+self.padding[3]+self.padding[1]
	+self.margin[3]+self.margin[1]
end

function rt:getWidth()
	return self.richtext:getHeight()
	+self.padding[4]+self.padding[2]
	+self.margin[4]+self.margin[2]
end

function rt:drawCanvas(x,y)
	love.graphics.draw(self.canvas,x,y)
end	


return rt
