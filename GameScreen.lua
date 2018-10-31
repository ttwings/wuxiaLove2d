local assets = require('lib.cargo').init('assets')
local Screen = require( "lib/Screen" )
require("lib.util")
local actorData = assets.data.actorDataNew
local sti = require "sti"

local roomFunc = require("assets.data.wuguan.wuguanRoomFunc")
--local Actor = require("Actor")

local GameScreen = {}
local map
local tx, ty
local canvas = love.graphics.newCanvas()
local player = {}
gameObjects = {}

date = require("objects.Date")
gameTurn = 0
--- @language C
--- @return 透视效果
local code =[[
vec4 effect(vec4 color,Image texture,vec2 tc,vec2 sc){
	return Texel(texture,vec2((tc.x-0.5)/(tc.y + 1.5)+0.5,tc.y));
}
]]

local shader = love.graphics.newShader(code)
-- npc table
function canvasLoad()
	love.graphics.setCanvas(canvas)
	love.graphics.clear()
	map:draw(-tx,-ty)
	love.graphics.setCanvas()
end
region = {}
local npcs = {}
local function loadData(  )
	---@param actor Actor
		player=Actor:new(nil,actorData["XuZhu"].x,actorData["XuZhu"].y,actorData["XuZhu"])
		enemy=Actor:new(nil,actorData["DuanYu"].x,actorData["DuanYu"].y,actorData["DuanYu"])

		table.insert(gameObjects,player)
		table.insert(gameObjects,enemy)
		---
		for k, v in pairs(actorData) do
			if v.name ~= player.name then
				local npc = Actor:new(nil,actorData[k].x,actorData[k].y,actorData[k])
				table.insert(gameObjects,npc)
			end
		end
		player.id = math.createID()
		enemy.id = math.createID()

	--- load  behavior tree
	--	behaviorTree:load('lib/behavior3/jsons/behavior3.json', {})
	--	blackBoard:set("actor",enemy)
	--	blackBoard:set('target',player)
	--	love.graphics.print(text)
		--love.graphics.setFont(font)
		map = sti("assets/tileMaps/wuguan.lua")
		-- Prepare translations
		tx, ty = 0, 0
		region.map = assets.tileMaps.wuguan
		region.objLayer = map.layers["objs"]
		region.roomLayer = map.layers["rooms"]
		region.actorLayer = map.layers["actors"]

		--- @param roomLayer 房间层
		function region.roomLayer:update(dt)
			for _, room in pairs(self.objects) do
				local rx,ry = room.x,room.y
				local rw,rh = room.width,room.height
				local px,py = player.x,player.y
				if rx <= px and rx + rw > px and ry <= py and ry + rh > py then
					player.room = room.name
					break
				else
					player.room = ""
				end
			end
		end
		--- @param objLayer 物品层
		function region.objLayer:update(dt)
			for _,obj in pairs(self.objects) do
				local ox,oy = obj.x + 16,obj.y + 16
				local px,py = player.x + 16 ,player.y + 32
				local distance = math.getDistance(px,py,ox,oy)
				if  distance <= 96 then
					player.obj = obj.name
					break
				else
					player.obj = ""
				end
			end
			---@param obj 的更新，需要重新set 同理tile
			map:setObjectSpriteBatches(self)
		end

		---@param actorLayer
		function region.actorLayer:update(dt)
			for _, actor in pairs(self.objects) do
				if actor.name == player.name then
					actor.x = player.x
					actor.y = player.y
				end
			end
			---actor target
			for _,npc in pairs(npcs) do
				local ox,oy = npc.x + 16,npc.y + 16
				local px,py = player.x + 16 ,player.y + 32
				local distance = math.getDistance(px,py,ox,oy)
				if  distance <= 96 then
					player.target = npc.name
					--print(obj.name)
					break
				else
					player.target = ""
				end
			end

		end
		--
		function region.actorLayer:draw()

			--player:drawAnim()
			table.sort(gameObjects,function(a,b) return a.y > b.y end)
			for i = #gameObjects, 1,-1 do
				gameObjects[i]:draw()
			end
			-- player:draw()
			--enemy:drawAnim()
			-- enemy:draw()
			for _, v in pairs(npcs) do
				v:drawAnim()
			end
			animations.draw()
		end
		--canvasLoad()
end
GameScreen.cam = {}
function GameScreen.new(  )
	local self=Screen.new()
	GameScreen.cam = Camera.new(0,0,1280,800)
	loadData()
	roomFunc.load()
	function self:draw()
		love.graphics.setShader(shader)
		--- 屏幕震动需要，添加后，GPU 占用率提升 todo 寻找问题，更换camera类
		love.graphics.draw(canvas)
		love.graphics.setShader()
		-- GUI
		--guiDraw()
		love.graphics.print("FPS:" .. love.timer.getFPS(),1220,0)
		date.draw()
		roomFunc.draw()
	end

	function self:update( dt )
		map:update(dt)
		if gameTurn < player.turn then
			gameTurn = gameTurn + 1
		end
		if gameTurn >= player.turn then
			player.isTurn = true
		end
		if gameTurn >= enemy.turn then
			enemy.turn = gameTurn +  math.random(1,6)
		end

		for _, v in pairs(gameObjects) do
			v:update(dt)
		end

		tx = math.floor((player.x - 1280/2))
    	ty = math.floor((player.y - 800/2))
    	-- 画布
    	canvasLoad()

    	guiUpdata(player,dt)
		animations.update(dt)
		date.update()
--		GameScreen.cam:shakeUpdate()
		roomFunc.update(dt)
	end
	function self:keypressed(key)
		player:keypressed(key)
		roomFunc.keypressed(key)
	end
	return self
end

return GameScreen