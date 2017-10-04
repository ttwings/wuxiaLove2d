date 	= {year=0,month=0,week=0,day=0,hour=0,minute=0,second=0,turn=0}
animals = {"鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪"}
weeks 	= {"上旬","中旬","下旬"}
days 	= {"月曜日","火曜日","水曜日","木曜日","金曜日","土曜日","日曜日"}
hours 	= {"子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"}
months  = {"正","二","三","四","五","六","七","八","九","十","冬","腊"}
numbers = {"〇","一","二","三","四","五","六","七","八","九"}
season	= {"春","夏","秋","冬"}
weather	= {	"晴","多云","阴","阵雨","雷阵雨","雷阵雨伴有冰雹",
			"雨夹雪","小雨","中雨","大雨","暴雨","大暴雨","特大暴雨",
			"阵雪","小雪","中雪","大雪","暴雪","雾","冻雨","沙尘暴",
			"小到中雨","中到大雨","大到暴雨","暴雨到大暴雨",
			"大暴雨到特大暴雨","小到中雪","中到大雪","大到暴雪",
			"浮尘","扬沙","沙尘暴","强沙尘暴","特强沙尘暴轻雾",
			"浓雾强浓雾","轻微霾","轻度霾","中度霾","重度霾","特强霾","霰","飑线"}

font = love.graphics.newFont("assets/font/simsun.ttf", 18)
love.graphics.setFont(font)

function date:update(dt)
	-- 1年 = 12 月 * 3 旬 * 7 天 * 12 时辰 * 120 分 * 60 秒 * 60 帧 = 15552000
	-- 计算年月日
	date.second = date.second + 100
	date.new(date.second)
end

function date:draw()
	-- colorText(colorstr)
	local d = date
	local yearStr = hours[d.year]..animals[d.year]
	local monthStr = months[d.month]
	local weekStr = weeks[d.week]
	local dayStr = days[d.day]
	local hourStr = hours[d.hour]
	dateStr = string.format("%s年%s月%s%s%s时",yearStr,monthStr,weekStr,dayStr,hourStr)
	love.graphics.print(dateStr,560,0)
end

--- 将数字转为文字
function replaseNumber(number)
	-- local numbers = number ..""
	numbers = string.gsub(number,"1", "一")
	numbers = string.gsub(numbers,"2", "二")
	numbers = string.gsub(numbers,"3", "三")
	numbers = string.gsub(numbers,"4", "四")
	numbers = string.gsub(numbers,"5", "五")
	numbers = string.gsub(numbers,"6", "六")
	numbers = string.gsub(numbers,"7", "七")
	numbers = string.gsub(numbers,"8", "八")
	numbers = string.gsub(numbers,"9", "九")
	numbers = string.gsub(numbers,"0", "〇")
	return numbers
end

function date.new(second)
	date.second	= second
	date.minute = math.modf(date.second/60)
	date.hour 	= math.modf(date.minute/60)
	date.day 	= math.modf(date.hour/12)
	date.week 	= math.modf(date.day/7)
	date.month 	= math.modf(date.week/3)
	date.year 	= math.modf(date.month/12)
--
	date.minute = math.modf(date.minute%60)+1
	date.hour 	= math.modf(date.hour%12)+1
	date.day 	= math.modf(date.day%7)+1
	date.week 	= math.modf(date.week%3)+1
	date.month 	= math.modf(date.month%12)+1
	date.year 	= math.modf(date.year%12)+1
	return date
end