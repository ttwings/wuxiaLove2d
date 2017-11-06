require( "lib.Color" )
-- 彩色标签中文文本输出
function printc(text,x,y)
	local x=x or 0
	local y=y or 0
	local index=1
	local colorTable={}
	for c in string.gmatch(text,"[A-Z]+") do
		color=Color[c]
		if color then 	-- 如果色彩表中，有该字段，则选择相应色彩
		    table.insert(colorTable, color)
		else
			table.insert(colorTable,{255,255,255,255})
		end 			-- 匹配汉字
		 subtext = string.match(text,"[^x00-xff]+",index)
		--subtext = string.match(text,"/S.*",index)
		if subtext then
			index = index+#c+#subtext+2  -- 定位下一个匹配位置
		end
		table.insert(colorTable, subtext)
	end
	love.graphics.print(colorTable,x,y)
	return colorTable
end

local 	bar={}
		bar[1]="■"
		bar[2]="■■"
		bar[3]="■■■"
		bar[4]="■■■■"
		bar[5]="■■■■■"
		bar[6]="■■■■■■"
		bar[7]="■■■■■■■"
		bar[8]="■■■■■■■■"
		bar[9]="■■■■■■■■■"
		bar[10]="■■■■■■■■■■"


function printHP(nowHP,maxHP,x,y)
	local r,g,b,a
	-- r = math.modf(255-255*nowHP/maxHP)
	r = 0
	g = math.modf(255*nowHP/maxHP)
	b = 0
	a = 255
	local rate = math.modf(nowHP*10/maxHP)
	local hp = bar[rate]
	local colorbar={{r,g,b,a},hp}
	love.graphics.print(colorbar,x,y)
end

function printMP(nowHP,maxHP,x,y)
	local r,g,b,a
	-- r = math.modf(255-255*nowHP/maxHP)
	r = 0
	g = 0
	b = math.modf(255*nowHP/maxHP)
	a = 255
	local rate = math.modf(nowHP*10/maxHP)
	local hp = bar[rate]
	local colorbar={{r,g,b,a},hp}
	love.graphics.print(colorbar,x,y)
end

function printAP(nowHP,maxHP,x,y)
	local r,g,b,a
	r = 0
	g = math.modf(255*nowHP/maxHP)
	-- b = math.modf(255-255*nowHP/maxHP)
	b = 0
	a = 255
	local rate = math.modf(nowHP*10/maxHP)
	local hp = bar[rate]
	local colorbar={{r,g,b,a},hp}
	love.graphics.print(colorbar,x,y)
end

function printCD(cd,x,y)
	local r,g,b,a
	r = 255
	g = 255
	b = 255
	a = 255
	local barCD = bar[cd]
	local colorbar={{r,g,b,a},barCD}
	love.graphics.print(colorbar,x,y)
end

return printc