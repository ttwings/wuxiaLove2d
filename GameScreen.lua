local Screen = require( "lib/Screen" )
local sti = require "sti"
local actorsdata=require "assets/data/actors"
local anim8 = require 'lib/anim8'
-- local Class = require "lib/middleclass"
require "Date"
-- 主要对象类,角色类，房间类，区域类
require "Actor"
require "Npc"
require "assets/data/actors"
require "assets/data/rooms"
require "lib/guiDraw"
require "lib/colorT"
require "lib/drawTool"
local GameScreen = {}
local map
local world
local tx, ty
local font
local canvas = love.graphics.newCanvas()
local canvasGUI = love.graphics.newCanvas()
local tx
local ty
-- shader
local code =[[
vec4 effect(vec4 color,Image texture,vec2 tc,vec2 sc){
	return Texel(texture,vec2((tc.x-0.5)/(tc.y+1)+0.5,tc.y));
}
]]
shader = love.graphics.newShader(code)

-- npc table
function canvasLoad()
	love.graphics.setCanvas(canvas)
	love.graphics.clear()
	map:draw(-tx,-ty)
	map:box2d_draw(-tx,-ty)
	love.graphics.setCanvas()
end

function canvasGUIload()
	love.graphics.setCanvas(canvas)
	love.graphics.clear()
	guiDraw()
	love.graphics.print("FPS:" .. love.timer.getFPS(),1220,0)
	drawTile(actorImgs[1],0,0,32,48,640,400)
	-- 绘制时间
	-- date.draw()
	love.graphics.setCanvas()
end

function loadData(  )
	-- actor class
		actor=Actor:new(actors["段誉"])
		-- actor:readData(actors["段誉"])
		-- npc1 = Actor:new(actors["言达平"])
		-- npc2 = Actor:new(actors["鲁坤"])
		npcs:add(actors,5)
		-- npc1.x = 500
		-- npc1.y = 600
		-- npc2.x = 800
		-- npc2.y = 1000
		-- npc1:readData(actors["言达平"])
		-- actor.misc = {}
		--
		font = love.graphics.newFont("assets/font/msyh.ttf", 18)
		love.graphics.setFont(font)
		map = sti("assets/tileMaps/wuguan.lua",{"box2d"})
		-- Prepare translations
		tx, ty = 0, 0
		-- Prepare physics world
		love.physics.setMeter(32)
		world = love.physics.newWorld(0, 0)
		map:box2d_init(world)
		-- Create a Custom Layer
		map:addCustomLayer("Sprite Layer", 5)
		-- Add data to Custom Layer
		local spriteLayer = map.layers["Sprite Layer"]

		spriteLayer.sprites = {
			player = {}
		}
		-- Update callback for Custom Layer
		function spriteLayer:update(dt)
			local objs =  map.layers[7].objects
			for i=1,#objs,1 do
				local objName = objs[i].name
				local bx,by = objs[i].x,objs[i].y
				local ax,ay = actor.x/2,actor.y/2
				local distance=math.abs(bx-ax) + math.abs(by-ay)
				-- print(distance)
				-- print( distance )
				if (distance<100) then
					actor.target = objName .. ":"..bx .. ":".. by
					break
				else
					actor.target = ""
				end
			end
		end
		--
		function spriteLayer:draw()
			for _, sprite in pairs(self.sprites) do
				local x = math.floor(actor.x/2)
    			local y = math.floor(actor.y/2)
				actor:drawAnim()
				npcs:drawAnim()
				-- npc1:drawAnim()
				-- npc2:drawAnim()
				-- actor:drawFly()
			end
		end


		canvasLoad()
end


function GameScreen.new(  )
	local self=Screen.new()
	loadData()
	function self:draw()
		love.graphics.setShader(shader)
		love.graphics.draw(canvas)
		love.graphics.setShader()
		-- GUI
		guiDraw()
		-- actor:draw()
		-- actor:drawBag()
		love.graphics.print("FPS:" .. love.timer.getFPS(),1220,0)
		date.draw()
	end

	function self:update( dt )
		world:update(dt)
		map:update(dt)
		actor:key(dt)
		actor:update(dt)
		-- npc1:update(dt)
		npcs:update(dt)
		-- 地图的位移
		tx = math.floor((actor.x - 1280)/ 2)
    	ty = math.floor((actor.y - 800)/ 2)
    	-- 画布
    	canvasLoad()
    	guiUpdata(actor,dt)
    	date.update()
	end
	return self
end


return GameScreen