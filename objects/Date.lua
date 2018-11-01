--- @class Date
Date = Class("Date")


local Date 	= {year=0,month=0,week=0,day=0,hour=0,minute=0,second=0,turn=0}
--Date = date
local animals = {"鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪"}
local weeks 	= {"上旬","中旬","下旬"}
local days 	= {"月曜日","火曜日","水曜日","木曜日","金曜日","土曜日","日曜日"}
local hours 	= {"子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"}
local months  = {"正","二","三","四","五","六","七","八","九","十","冬","腊"}
local numbers = {"〇","一","二","三","四","五","六","七","八","九"}
local season	= {"春","夏","秋","冬"}
local monthMsgOut = {	"春天悄悄地走来了，","春风轻轻地拂过你的脸庞，","天气逐渐变暖了，",
				"已经是初夏时节了，","知了的叫声让你感觉到了盛夏的气息，","天气变得非常闷热，",
				"虽然是秋天了，天气还是有些热，","中秋佳节快到了，","一阵秋风吹来，卷起了地上的落叶，",
				"秋去冬来，","寒风凛冽，","快到年关了，"}
local monthMsgIn = {"这是一个初春的,"
			,"这是一个早春二月的,"
			,"这是一个阳春三月的,"
			,"这是一个初夏的,"
			,"这是一个盛夏的,"
			,"这是一个仲夏的,"
			,"这是一个初秋的,"
			,"这是一个秋日的,"
			,"这是一个深秋的,"
			,"这是一个初冬的,"
			,"这是一个隆冬的,"
			,"这是一个寒冬的,"}
local hourType={"午夜","午夜","黎明","黎明","朝阳","早晨","中午","中午","下午","夕阳","傍晚","傍晚"}
local fontcolor = {"深蓝","深蓝","浅蓝","浅灰","浅灰","白色","白色","白色","黄色","青色","青色","浅蓝"}
local skyMsg = {"夜幕低垂，满天繁星"
	,"夜幕低垂，满天繁星"
	,"东方的天空已逐渐发白"
	,"东方的天空已逐渐发白"
	,"太阳刚从东方的地平线升起"
	,"太阳正高挂在东方的天空中"
	,"现在是正午时分，太阳高挂在你的头顶正上方"
	,"现在是正午时分，太阳高挂在你的头顶正上方"
	,"太阳正高挂在西方的天空中"
	,"一轮火红的夕阳正徘徊在西方的地平线上"
	,"夜幕笼罩著大地，四周掩映在迷茫的夜色里"
	,"夜幕笼罩著大地，四周掩映在迷茫的夜色里"}
--weather	= {	"晴","多云","阴","阵雨","雷阵雨","雷阵雨伴有冰雹",
--			"雨夹雪","小雨","中雨","大雨","暴雨","大暴雨","特大暴雨",
--			"阵雪","小雪","中雪","大雪","暴雪","雾","冻雨","沙尘暴",
--			"小到中雨","中到大雨","大到暴雨","暴雨到大暴雨",
--			"大暴雨到特大暴雨","小到中雪","中到大雪","大到暴雪",
--			"浮尘","扬沙","沙尘暴","强沙尘暴","特强沙尘暴轻雾",
--			"浓雾强浓雾","轻微霾","轻度霾","中度霾","重度霾","特强霾","霰","飑线"}


local font = love.graphics.newFont("assets/font/myfont.ttf", 20)
local richtext = love.graphics.newText(font,"")
Date.year = 111
Date.month = 3
Date.hour = 5
Date.second = math.random(10000,1000000)

---new
---@param second number 回合数
---@return table date 日期
function Date:init(second)
	Date.second	= second
	Date.minute = math.modf(Date.second/60)
	Date.hour 	= math.modf(Date.minute/60)
	Date.day 	= math.modf(Date.hour/12)
	Date.week 	= math.modf(Date.day/7)
	Date.month 	= math.modf(Date.week/3)
	Date.year 	= math.modf(Date.month/12)
	---- 日期转化
	Date.minute = math.modf(Date.minute%60)+1
	Date.hour 	= math.modf(Date.hour%12)+1
	Date.day 	= math.modf(Date.day%7)+1
	Date.week 	= math.modf(Date.week%3)+1
	Date.month 	= math.modf(Date.month%12)+1
	Date.year 	= math.modf(Date.year%12)+1
	return Date
end

function Date:update(dt)
	-- 1年 = 12 月 * 3 旬 * 7 天 * 12 时辰 * 120 分 * 60 秒 * 60 帧 = 15552000
	-- 计算年月日
	-- 6 秒一回合
	Date.second = Date.second + 6
	Date:new(Date.second)
end

function Date:draw()
	local d = Date
	local yearStr = hours[d.year]..animals[d.year]
	local monthStr = months[d.month]
	local weekStr = weeks[d.week]
	local dayStr = days[d.day]
	local hourStr = hours[d.hour]
	local colorStr = fontcolor[d.hour]
	local text = {{Color[fontcolor[d.hour]]},monthMsgIn[d.month]..hourType[d.hour]..skyMsg[d.hour]}
	dateStr = string.format("%s年%s月%s%s%s时",yearStr,monthStr,weekStr,dayStr,hourStr)
	richtext:set({Color[fontcolor[d.hour]],dateStr})
	love.graphics.draw(richtext,330,0)
	love.graphics.print("Hello world....")
end
--
--
--
--return Date