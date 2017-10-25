local Screen = require( "lib/Screen" )
local sti = require "sti"
local GameScreen = {}
local map
local world
local tx, ty
local font
local canvas = love.graphics.newCanvas()
local tx
local ty
-- shader
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
	map:box2d_draw(-tx,-ty)
	love.graphics.setCanvas()
end

local function loadData(  )
		-- actor class
		actor=Actor:new(actors["段誉"])
		npcs:add(actors,5)
		local font = love.graphics.newFont("assets/font/myfont.ttf", 20)
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
		region.objs =  map.layers["objs"].objects
		function spriteLayer:update(dt)
			local objs = region.objs
			for i=#objs,1,-1 do
				local objName = objs[i].name
				local bx,by = objs[i].x,objs[i].y
				local ax,ay = actor.x/2,actor.y/2
				local distance=math.abs(bx-ax) + math.abs(by-ay)
				if (distance<100) then
					actor.target = objName
					actor.tx = bx
					actor.ty = by
					break
				else
					actor.target = ""
				end
			end
		end
		--
		function spriteLayer:draw()
			for _, sprite in pairs(self.sprites) do
				actor:drawAnim()
                actor:draw()
				--npcs:drawAnim()
				animations.draw()
			end
		end
		canvasLoad()
end
GameScreen.cam = {}
function GameScreen.new(  )
	local self=Screen.new()
	GameScreen.cam = Camera.new(0,0,1280,800)

	loadData()

	function self:draw()
		love.graphics.setShader(shader)

		GameScreen.cam:draw(function()
			love.graphics.draw(canvas)
		end)
		love.graphics.setShader()
		-- GUI
		guiDraw()
		love.graphics.print("FPS:" .. love.timer.getFPS(),1220,0)
		date.draw()
	end

	function self:update( dt )
		world:update(dt)
		map:update(dt)
		actor:key(dt)
		actor:update(dt)
        --npcs:update(dt)
		-- 地图的位移
		tx = math.floor((actor.x - 1280)/ 2)
    	ty = math.floor((actor.y - 800)/ 2)
    	-- 画布
    	canvasLoad()
    	guiUpdata(actor,dt)
		animations.update(dt)
    	date.update()
--		GameScreen.cam:shakeUpdate()
	end
	function self:keypressed(key)
		actor:keypressed(key)
	end
	return self
end

return GameScreen