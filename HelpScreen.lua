local Screen = require( "lib/Screen" )
local HelpScreen = {}
local bg = assets.graphics.Backgrounds.bg
local font = love.graphics.newFont("assets/font/msyh.ttf", 24)
local titlefont = love.graphics.newFont("assets/font/msyh.ttf", 48)
local index = 1
function HelpScreen.new(  )
	love.graphics.setFont(font)
	local self=Screen.new()
	title = love.graphics.newText(titlefont,"侠客宝典")
	function self:draw(  )
		love.graphics.draw(bg, 0, 0, 0)
		love.graphics.setColor(0, 0, 0, 255)
		love.graphics.draw(title, 300, 40)
		love.graphics.setColor(255,255,255, 255)
	end

	function self:update( dt )

	end

	function self:keypressed(key)
		if key=="e" and index>1 then
		    index = index -1
		elseif key=="d" and index<4 then
		    index = index + 1
		elseif key=="j" or "k" then
			print(key)
		end
	end
	return self
end
return HelpScreen