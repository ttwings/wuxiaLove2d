require "txt2table"
require "mapWuGuan"
require "printc"
-- require "../lib/printc"

font = love.graphics.newFont("simsun.ttf", 18)
love.graphics.setFont(font)
function arrayDraw(t)
	for i, v in ipairs( t ) do
		for j, c in ipairs( t[i] ) do
			love.graphics.print(c,(j-1)*100,i*20 )
		end
	end
end

function love.draw()
	-- arrayDraw(mapWuGuan)
end

function love.load()
	-- excel2table("","rooms","rooms")
	-- excel2table("","skills","skills")
	-- excel2table("","actors","actors")
	excel2table("","objs","objs")
	-- excel2array("","names","names")
	-- excel2array("","itemStage","itemStage")
	-- excel2array("","actorStage","actorStage")
	-- excel2array("","mapWuGuan","mapWuGuan")
end