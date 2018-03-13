assets = require('lib.cargo').init('assets')
local Screen = require( "lib/Screen" )
local actorData = assets.data.actorData
local sti = require "sti"
local GameScreen = {}
local map
local tx, ty
local canvas = love.graphics.newCanvas()
local tx
local ty
gameTurn = 0
---@language C
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
local function loadData(  )
		-- actor class
	---@param actor Actor
		actor=Actor:new(actorData["虚竹"])
		enemy=Actor:new(actorData["段誉"])
		actors = npcs:load()
		love.graphics.setFont(font)
		map = sti("assets/tileMaps/wuguan.lua")
		-- Prepare translations
		tx, ty = 0, 0
		-- Create a Custom Layer
		map:addCustomLayer("Sprite Layer", 5)
		-- Add data to Custom Layer
		local spriteLayer = map.layers["Sprite Layer"]
		spriteLayer.sprites = {
			player = {}
		}
		-- Update callback for Custom Layer
		region.objs =  map.layers["objs"].objects
		region.actors = map.layers["sprites"].objects

		function spriteLayer:update(dt)
			for _, sprite in pairs(self.sprites) do

			end
		end
		--
		function spriteLayer:draw()
			for _, sprite in pairs(self.sprites) do
				actor:drawAnim()
                actor:draw()
				enemy:drawAnim()
				enemy:draw()
				npcs:drawAnim()
				animations.draw()

			end
		end
		--canvasLoad()
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
		map:update(dt)
		if gameTurn < actor.turn then
			gameTurn = gameTurn + 1
		end
		if gameTurn >= actor.turn then
			actor:key(dt)
		end
		if gameTurn >= enemy.turn then
			actions.moveW(enemy,dt)
			--enemy.turn = gameTurn +  math.random(1,6)
		end
		actor:update(dt)
		enemy:update(dt)
		npcs:update(dt)
		-- 地图的位移
		tx = math.floor((actor.x - 1280/2))
    	ty = math.floor((actor.y - 800/2))
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