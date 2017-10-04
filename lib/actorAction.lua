actorMsg={}
require "assets/data/rooms"
require "lib/aTools"
-- 坐标移动
function move(actor,x,y,dt)
	local speed = 25600
	local dx,dy=x-actor.x,y-actor.y
	local round=dx^2+dy^2
	if round<4 then return end
	if math.abs(dx)>math.abs(dy) then
		actor.x = actor.x + math.sign(dx)*speed*dt
	elseif math.abs(dx)<math.abs(dy) then
		actor.y = actor.y + math.sign(dy)*speed*dt
	elseif math.abs(dx)==math.abs(dy) then
		actor.x = actor.x + math.sign(dx)*speed*dt
		actor.y = actor.y + math.sign(dy)*speed*dt
	end
end

-- 房间移动
function moveRoom(actor,roomName)
	local dt=love.timer.getDelta()
	local roomX,roomY = rooms[1]["x"],rooms[1]["y"]
	local x = tonumber(roomX)
	local y = tonumber(roomY)
	move(actor,x,y,dt)
	if (roomX-x+roomY-y)<16 then
		actor["房间"]=roomName
	end
end
-- 区域移动
function moveRegion(actor,regionName)
	actor["区域"]=regionName
end
-- 观察
function look(actor,msg)
	actor["看"]=msg
	table.insert(actorMsg,actor["名称"].."看到"..msg)
end

-- 说话
function say(actor,msg)
	actor["说"]=msg
	table.insert(actorMsg,actor["名称"].."："..msg)
end
-- 思考
function think(actor,msg)
	actor["想"]=msg
	table.insert(actorMsg,actor["名称"].."心想"..msg)
end
-- 听到
function listen(actor,msg)
	actor["听"]=msg
	table.insert(actorMsg,actor["名称"].."听到"..msg)
end
-- 写出
function wirte(actor,msg)
	actor["写"]=msg
	table.insert(actorMsg,actor["名称"].."写下"..msg)
end
-- 得到
function get(actor,msg)
	table.insert(actor["bag"],msg)
	table.insert(actorMsg,actor["名称"].."得到"..msg)
end
--------------------------- love2d 绘制部分 ---------------
function drawMsg()
	if actorMsg~=nil then
		for i = 1, #actorMsg do
			love.graphics.print(actorMsg[i], 20, 400+i*20)
		end
	end
end
-- 背包绘制
function drawBag(actor)
	if actor.bag~=nil then
		for i = 1, #actor.bag do
			love.graphics.print(actor.bag[i], 1220, 400+i*20)
		end
	end
end

--------------------------- 键盘控制 ------------------------
cd=10
function key(dt,actor)
	speed = 600
	cd=cd-dt
	if love.keyboard.isDown("f") then
        actor.x = actor.x + dt*speed
    	elseif love.keyboard.isDown("s") then
    		actor.x = actor.x - dt*speed
    end

    if love.keyboard.isDown("d") then
    	actor.y = actor.y + dt*speed
    	elseif love.keyboard.isDown("e") then
    		actor.y = actor.y - dt*speed
    end

    if love.keyboard.isDown("j") then
    	get(actor,"包子")
    	cd=10
    end

    if love.keyboard.isDown("k") then
    	look(actor,rooms[1]["name"])
    	cd=10
    end
    return actor
end

function love.keypressed(key)
	-- Exit test
	if key == "escape" then
		love.event.quit()
	end
	-- Reset translation
	if key == "space" then
		tx, ty = 0, 0
	end
end
