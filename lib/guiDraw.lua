local lg=love.graphics
local lp=love.graphics.print
local lf=love.graphics.printf
require "lib/guiData"
require "assets/data/rooms"
require("assets.data.Color")
local font = love.graphics.newFont("assets/font/myfont.ttf", 20)
local text = love.graphics.newText(font,"")
local gui = {}
function guiDraw()
	local color={}
	for i, v in pairs( guiData ) do
		if v.visible and v.type=="txt"then
			gui.text(v)
		elseif v.visible and v.type=="image" then
			gui.image(v)
		elseif v.visible and v.type=="barHP" then
			gui.barHP(v)
		elseif v.visible and v.type=="barMP" then
			gui.barMP(v)
		elseif v.visible and v.type=="barAP" then
			gui.barAP(v)
		elseif v.visible and v.type=="barFood" then
			gui.barFood(v)
		elseif v.visible and v.type=="barWater" then
			gui.barWater(v)
		elseif v.visible and v.type=="long" then
			gui.long(v)
		elseif v.visible and v.type=="dialog" then
			gui.dialog(v)
		elseif v.visible and v.type=="map" then
			gui.map(v)
		elseif v.visible and v.type=="shop" then
			gui.shop(v)
		elseif v.visible and v.type=="skill" then
			gui.skill(v)
		elseif v.visible and v.type=="bag" then
			gui.bag(v)
		end
	end
end
--  不同的gui部件。
gui.text = function(v)
	local color=Color[v.color] or {255,255,255,255}
	text:set({color,v.contant})
	love.graphics.draw(text,v.x,v.y)
end
gui.image = function(v)
	local dir="assets/graphics/Faces/"
	local image = love.graphics.newImage(dir .. v.image)
	love.graphics.draw(image,v.x,v.y)
end
gui.barHP = function(v)
	local maxHP=v.max
	-- lg.print(v["contant"])
	local color=Color[v.color] or {255,255,255,255}
	text:set({color,v.title ..":"})
	love.graphics.draw(text,v.x,v.y)
	bar(v.now,maxHP,v.x+50,v.y+26,color)
end
gui.barMP = function(v)
	local maxMP=v.max
	local color=Color[v.color] or {255,255,255,255}
	text:set({color,v.title ..":"})
	love.graphics.draw(text,v.x,v.y)
	bar(v.now,maxMP,v.x+50,v.y+26,color)
end
gui.barAP = function(v)
	local max=v.max
	local color=Color[v.color] or {255,255,255,255}
	text:set({color,v.title ..":"})
	love.graphics.draw(text,v.x,v.y)
	bar(v.now,max,v.x+50,v.y+26,color)
end
gui.barFood = function(v)
	local maxFood = v.max
	local color=Color[v.color] or {255,255,255,255}
	text:set({color,v.title ..":"})
	love.graphics.draw(text,v.x,v.y)
	bar(v.now,maxFood,v.x+50,v.y+26,color)
end
gui.barWater = function(v)
	local max = v.max
	local color=Color[v.color] or {255,255,255,255}
	text:set({color,v.title ..":"})
	love.graphics.draw(text,v.x,v.y)
	bar(v.now,max,v.x+50,v.y+26,color)
end
gui.long = function(v)
	local alpha = v.alpha or 128
	local color=Color[v.color] or {255,255,255,255}
	love.graphics.setColor(0, 0, 0, alpha)
	love.graphics.rectangle("fill", v.x, v.y, v.width, v.height,10)
	love.graphics.setColor(255, 255, 255, 255)
	text:setf({color,v.contant},v.width,"left")
	love.graphics.draw(text,v.x,v.y)
end
gui.dialog = function(v)
	local dir="assets/graphics/Faces/"
	local image = love.graphics.newImage(dir .. v.image)
	love.graphics.draw(image,v.x-image:getWidth(),v.y)
	local alpha = v.alpha or 128
	local color=Color[v.color] or {255,255,255,255}
	love.graphics.setColor(0, 0, 0, alpha)
	love.graphics.rectangle("fill", v.x, v.y, v.width, v.height,10)
	love.graphics.setColor(255, 255, 255, 255)
	text:setf({color,v.contant},v.width,"left")
	love.graphics.draw(text,v.x,v.y)
end
gui.map = function(v)
	local alpha = v.alpha or 128
	local color=Color[v.color] or {255,255,255,255}
	love.graphics.print(v.title or "地图", v.x, v.y)
	love.graphics.setColor(0, 0, 0, alpha)
	love.graphics.rectangle("fill", v.x, v.y+20, v.width, v.height,10)
	love.graphics.setColor(255, 255, 255, 255)
end
gui.shop = function(v)

	local alpha = v.alpha or 200
	local color=Color[v.color] or {255,255,255,255}
	-- 底色
	love.graphics.setColor(0, 0, 0, alpha)
	love.graphics.rectangle("fill", v.x, v.y, v.width, v.height,10)
	-- 边框
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle("line",v.x,v.y,v.width,v.height/4,10)
	love.graphics.rectangle("line",v.x,v.y,100,v.height/4,10)
	love.graphics.rectangle("line",v.x,v.y+100,v.width,v.height/4,10)
	love.graphics.rectangle("line",v.x,v.y+200,v.width,v.height/4,10)
	love.graphics.rectangle("line",v.x,v.y+300,v.width,v.height/4,10)
	-- 文字信息
	--love.graphics.setColor(255,255,255,255)
	love.graphics.print(v.title or "商铺", v.x+108, v.y)
	-- 图片 头像、物品图标
	local dir="assets/graphics/Faces/"
	local image = love.graphics.newImage(dir .. "41.png") -- 41.png 是一个商人头像
	love.graphics.draw(image,v.x+7,v.y+7)
end
gui.skill = function(v)
	local alpha = v.alpha or 128
	local color=Color[v.color] or {0,0,0,255}
	love.graphics.setColor(0, 0, 0, alpha)
	love.graphics.rectangle("fill", v.x, v.y, v.width, v.height,10)
	love.graphics.setColor(255, 255, 255, 255)
	text:setf({color,v.contant},v.width,v.align)
	love.graphics.draw(text,v.x,v.y+4)
end
gui.bag = function(v)
	local alpha = v.alpha or 128
	local color=Color[v.color] or {0,0,0,255}
	love.graphics.setColor(0, 0, 0, alpha)
	love.graphics.rectangle("fill", v.x, v.y, v.width, v.height,10)
	love.graphics.setColor(255, 255, 255, 255)
	--text:setf({color,v.contant},v.width,v.align)
	--love.graphics.draw(text,v.x,v.y+4)
	love.graphics.print(v.title,v.x,v.y-20)
	bagItem(v.contant,v.x,v.y)
end

--  table data
function guiUpdata(actor,dt)
	guiData["头像"].image=actor.faceImg
	-- guiData["姓名"].contant=actor["姓名"]
	-- guiData["名称"].contant=actor["名称"]
	guiData["名称"].contant=actor.name
	guiData["称号"].contant=actor.epithet
	guiData["世家"].contant=actor.clan

	-- gui["身份"].contant=actor["身份"]
	guiData["气血"].now=actor.hp
	guiData["真气"].now=actor.mp
	guiData["精力"].now=actor.ep
	guiData["食物"].now = actor.food
	guiData["饮水"].now = actor.water
	--- pos
	guiData["区域"].contant=actor.region
	guiData["地图"].title=actor.region
	guiData["房间"].contant=actor.room
	local text = string.format("%d:%d",actor.x,actor.y)
	guiData["坐标"].contant =  text
	if rooms[actor.room] and #actor.room>2 then
		guiData["描述"].contant=rooms[actor.room]["description"]
	elseif objs[actor.target] then
		guiData["描述"].contant=objs[actor.target].description
	elseif actors[actor.target] then
		guiData["描述"].contant=actors[actor.target].description
	else
		guiData["描述"].contant=""
	end

	guiData["对话"].image=actor.faceImg
	guiData["商铺"].image = actor.faceImg
	guiData["发现"].contant=actor.target
	guiData["信息"].contant=actor.action
	guiData["口袋"].contant = actor.misc --- table value

end
-- rec eg: hp,mp
function bar(now,max,x,y,color)
	love.graphics.rectangle("line",x,y-18,128,8,4)
	local now = math.max(0,now)
	love.graphics.setColor(color)
	love.graphics.rectangle("fill",x,y-18,now*128/max,8,4)
	love.graphics.setColor(255,255,255,255)
	love.graphics.print(now,x+130,y-24)
end
-- circle eg: food , water
function circleFood(now,max,x,y)
	love.graphics.circle("line",x,y-16,32)
	local nowHP = math.max(0,now)
	local color = {r=255-nowHP*255/max,g=nowHP*255/max,b=0,a=255}
	love.graphics.setColor(color.r,color.g,color.b,color.a)
	love.graphics.circle("fill",x,y-16,nowHP*32/max)
	love.graphics.setColor(255,255,255,255)
end
--- bag
function bagItem(bag,x,y)
	local bag = bag or actor.misc or {"物品1","物品2"}
	local contant = ""
	for i, v in ipairs(bag) do
		love.graphics.print(v,x,y+i*20-20)
	end
end