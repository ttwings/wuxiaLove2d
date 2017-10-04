

local font26,font12,font120
local tab={}
local rt=require("richtext")
function love.load()
	font26 = love.graphics.newFont( 26 )
	font12 = love.graphics.newFont( 12 )
	font120 = love.graphics.newFont( 120 )
	rt:setFont(font26)
	rt:setPadding({20,5,10,5})
	rt:setMargin({4,2,4,2})
	rt:set(
		{33,34,32,230},"TEST",{230,240,220}
		)
end

function round(num, idp)
	if idp and idp>0 then
		local mult = 10^idp
		return math.floor(num * mult + 0.5) / mult
	end
	return math.floor(num + 0.5)
end


function printTab( tab )
	local x,y=10,180
	local dy=26
	for k,v in ipairs(tab) do
		love.graphics.print(v, x, y+k*dy, 0)
	end
end


local start,ends
local dr=""
local buffer=""
local cacheSize=0
local t=0
local tx=0
function love.draw( dt )
	love.graphics.setColor( 255, 255, 255, 150 )
	love.graphics.setFont(font26)
	love.graphics.print("delta t:"..t, 10, 10, 0)
	love.graphics.print(buffer,10,100,0)
	love.graphics.setColor( 255, 255, 255, 255 )
	rt:drawCanvas(0,50)
end

function love.update( dt )
	t=t+dt
	tx=tx+dt
	if tx>0.07 then
		rt:update(function()
		rt:set({33,34,32,230},round(t,3),{t*255,math.random(255),math.random(255),255})
		rt:draw()
		end)
		tx=tx-0.07
	end
	if t>1 then
		rt:wrap()
		t=t-1 
	end
end
