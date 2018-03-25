local assets = require('lib.cargo').init('assets')
local font = assets.font.myfont(20)
local actors = assets.data.actorDataNew
local rooms = assets.data.rooms
local objs = assets.data.objs
--local font = love.graphics.newFont("assets/font/myfont.ttf", 20)
--love.graphics.setFont(font)
local guiData = require("lib.guiData")
local text = love.graphics.newText(font,"")
local gui = {}
---@param actor Actor
function guiUpdata(actor,dt)
	--- 人物基本信息
	guiData["头像"].image=actor.faceImg
	guiData["名称"].contant=actor.name
	guiData["称号"].contant=actor.epithet
	guiData["世家"].contant=actor.clan
	-- gui["身份"].contant=actor["身份"]
	--- 人物基本状态
	guiData["气血"].now=actor.hp
	guiData["真气"].now=actor.mp
	guiData["精力"].now=actor.ap
	guiData["气血"].max=actor.maxHP
	guiData["真气"].max=actor.maxMP
	guiData["精力"].max=actor.maxAP
	guiData["食物"].now = actor.food
	guiData["饮水"].now = actor.water

	--- 世界位置，区域位置
	guiData["区域"].contant=actor.region
	guiData["地图"].title=actor.region
	guiData["房间"].contant=actor.room
	--- 状态机
	guiData["行为"].contant = actor.state
	guiData["增益"].contant = {{name="开心",num=12,color = Color["绿色"]}}
	guiData["减益"].contant = {{name="伤心",num=122,color = Color["浅红"]}}

	local text = string.format("%d:%d",actor.x,actor.y)
	guiData["坐标"].contant =  text
	--- 目标信息
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
	guiData["口袋"].contant = actor.misc or {}--- table value
	guiData["装备"].contant = actor.equip
	guiData["技能"].contant = {actor.mainHand,actor.offHand,actor.parry,actor.dodge}
	guiData["钱币"].contant = actor.money

	guiData["回合"].contant = {players={actor},enemys={enemy}}

	--- 更新飞行消息
	messages.update(dt)
end

function guiDraw()
	for i, v in pairs( guiData ) do
		if v.visible and gui[v.type] then
			gui[v.type](v)
		end
	end
	messages.draw()
	--- 绘制时间信息
	date.draw()
end
--  不同的gui部件。
gui.txt = function(v)
	local color=Color[v.color] or {255,255,255,255}
	text:set({color,v.contant})
	love.graphics.draw(text,v.x,v.y)
end
gui.image = function(v)
	--local dir="assets/graphics/Faces/"
	--local image = love.graphics.newImage(dir .. v.image)
	local image = assets.graphics.Faces[v.image]
	love.graphics.draw(image,v.x,v.y)
end
gui.barHP = function(v)
	local color=Color[v.color] or {255,255,255,255}
	text:set({color,v.title ..":"})
	love.graphics.draw(text,v.x,v.y)
	bar(v.now,v.max,v.x+50,v.y+26,color)
end
gui.barMP = function(v)
	local color=Color[v.color] or {255,255,255,255}
	text:set({color,v.title ..":"})
	love.graphics.draw(text,v.x,v.y)
	bar(v.now,v.max,v.x+50,v.y+26,color)
end
gui.barAP = function(v)
	local color=Color[v.color] or {255,255,255,255}
	text:set({color,v.title ..":"})
	love.graphics.draw(text,v.x,v.y)
	bar(v.now,v.max,v.x+50,v.y+26,color)
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
gui.state = function(v)
	local debuff = v.debuff or {"state1","state2"}
	local color=Color[v.color] or {255,255,255,255}

	for i, s in ipairs(debuff) do
		--love.graphics.print(s,v.x,v.y + i * 20-20)
		text:set({color,s})
		love.graphics.draw(text,v.x,v.y + i * 20-20)
	end
end
gui.colorText = function(v)
	buffs(v.contant,v.x,v.y)
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
	local image = assets.graphics.Faces[v.image]
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
	text:setf({color,v.title or "地图"},v.width,"center")
	love.graphics.draw(text,v.x,v.y)
	--love.graphics.print(v.title or "地图", v.x, v.y)
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
	--love.graphics.print(v.title or "商铺", v.x+108, v.y)
	text:set({{255,255,255},v.title})
	love.graphics.draw(text,v.x+108, v.y)
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
	--text:setf({color,v.contant[1]},v.width,v.align)
	--love.graphics.draw(text,v.x,v.y+4)
	skillItem(v.contant,v.x,v.y)
end
gui.bag = function(v)
	local alpha = v.alpha or 128
	local color=Color[v.color] or {0,0,0,255}
	love.graphics.setColor(0, 0, 0, alpha)
	love.graphics.rectangle("fill", v.x, v.y, v.width, v.height,10)
	love.graphics.setColor(255, 255, 255, 255)
	text:set({{255,255,255},v.title})
	love.graphics.draw(text,v.x,v.y-20)
	bagItem(v.contant,v.x,v.y)
end
gui.equip = function(v)
	local alpha = v.alpha or 128
	local color=Color[v.color] or {0,0,0,255}
	love.graphics.setColor(0, 0, 0, alpha)
	love.graphics.rectangle("fill", v.x, v.y, v.width, v.height,10)
	love.graphics.setColor(255, 255, 255, 255)
	text:set({{255,255,255},v.title})
	love.graphics.draw(text,v.x,v.y-20)
	equipItem(v.contant,v.x,v.y)
end
gui.money = function(v)
	local alpha = v.alpha or 128
	local color=Color[v.color] or {0,0,0,255}
	love.graphics.setColor(0, 0, 0, alpha)
	love.graphics.rectangle("fill", v.x, v.y, v.width, v.height,10)
	love.graphics.setColor(255, 255, 255, 255)
	--love.graphics.print(v.title,v.x,v.y-20)
	text:set({{255,255,255},v.title})
	love.graphics.draw(text,v.x,v.y-20)
	moneyItem(v.contant,v.x,v.y)
end
gui.turn = function(v)
	local alpha = v.alpha or 128
	local color=Color[v.color] or {0,0,0,255}
	love.graphics.setColor(0, 0, 0, alpha)
	love.graphics.rectangle("fill", v.x, v.y, v.width, v.height,10)
	love.graphics.setColor(255, 255, 255, 255)
	--love.graphics.print(v.title,v.x,v.y-20)
	timeLine(v.contant,v.x,v.y)
end
--- 条形图，如气血、真气、精力、食物、饮水
function bar(now,max,x,y,color)
	love.graphics.rectangle("line",x,y-18,128,8,4)
	local now = math.max(0,now)
	love.graphics.setColor(color)
	love.graphics.rectangle("fill",x,y-18,now*128/max,8,4)
	love.graphics.setColor(255,255,255,255)
	local color=color or {255,255,255,255}
	text:set({color,tostring(now)})
	love.graphics.draw(text,x+130,y-24)
end
--- 背包绘制
function bagItem(bag,x,y)
	local bag = bag or actor.misc or {}
	local item = {"[一]","[二]","[三]","[四]","[五]","[六]","[七]","[八]","[九]"}

	for i, v in ipairs(bag) do
		--love.graphics.print(item[i]..v,x,y+i*20-20)
		local color=v.color or {255,255,255,255}
		text:set({color,v})
		love.graphics.draw(text,x,y+i*20-20)
	end
end
--- 装备绘制
function equipItem(equips,x,y)
	local equips = equips or {"布巾","白色茶花丝衣","无","琉璃折扇","镶金龙纹腰带","鞋"}
	local item = {"[头]","[身]","[背]","[手]","[腰]","[足]"}
	for i, v in ipairs(equips) do
		local t = string.format("%s%s",item[i],v)
		--love.graphics.print(text,x,y+i*20-20)
		local color=v.color or {255,255,255,255}
		text:set({color,t})
		love.graphics.draw(text,x,y+i*20-20)
	end
end
--- 金钱绘制
function moneyItem(money,x,y)
	local m = tonumber(money) or 12345
	local g1,g2 = math.modf(m/1000),math.modf(m%1000)
	local t = string.format("%18d贯%6d钱",g1,g2)
	--love.graphics.print(text,x,y)
	local color = {255,255,0}
	text:set({color,t})
	love.graphics.draw(text,x,y)
end

--- 技能绘制
function skillItem(skills,x,y)
	local skills = skills or {"罗汉拳"}
	local item = {"[主手]","[副手]","[招架]","[身法]","[内功]","[绝招]"}
	for i, v in ipairs(skills) do
		local t= string.format("%s%s",item[i],v)
		--love.graphics.print(text,x+(i-1)*200,y+8)
		local color = {255,255,0}
		text:setf({color,t},200,"center")
		love.graphics.draw(text,x+(i-1)*200,y+8)
	end
end

--- buffs 绘制
function buffs(buffs,x,y)
	for p, v in pairs(buffs) do
		local t = {v.color,v.name}
		text:set(t)
		love.graphics.draw(text,x,y)
	end
end

--- TimeLine draw
function timeLine(contant,x,y)
	local tabelPlayers = contant.players or {}
	local tableEnemys = contant.enemys or {}
	local tableNpcs = contant.npcs or {}
	love.graphics.rectangle("fill",x + gameTurn%600,y,4,4,2)
	--love.graphics.print("回合".. gameTurn,x + gameTurn%600,y-20)
	local t = {{255,255,255},"回合".. gameTurn}
	text:set(t)
	love.graphics.draw(text,x + gameTurn%600,y-20)

	for _, v in pairs(tabelPlayers) do
		love.graphics.setColor(0,255,0)
		love.graphics.rectangle("fill",x + v.turn%600,y,4,4,2)
		text:set({{0,255,0},v.name .. v.turn})
		love.graphics.draw(text,x + v.turn%600,y+10)
		--love.graphics.print(v.name .. v.turn,x + v.turn%600,y+10)
	end
	for _, v in pairs(tableEnemys) do
		love.graphics.setColor(255,0,0)
		love.graphics.rectangle("fill",x + v.turn%600,y,4,4,2)
		text:set({{255,0,0},v.name .. v.turn})
		love.graphics.draw(text,x + v.turn%600,y+10)

	end
	for _, v in pairs(tableNpcs) do
		love.graphics.setColor(0,0,255)
		love.graphics.rectangle("fill",x + v.turn%600,y,4,4,2)
		love.graphics.print(v.name .. v.turn,x + v.turn%600,y+10)
		text:set({{0,0,255},v.name .. v.turn})
		love.graphics.draw(text,x + v.turn%600,y+10)
	end

end