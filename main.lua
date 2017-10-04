--@class Love2d
local sti = require "sti"
local excel = require "lib/txt2table"
local actorsdata=require "assets/data/actors"
local anim8 = require 'lib/anim8'
require "assets/data/actors"
require "lib/guiDraw"
require "lib/colorT"
require "lib/actorAction"
require "lib/drawTool"
-- 变量
local map
local car
local world
local tx, ty
local points
local font
-- actorImg
local actorImgs={}
local actorImgNames={"Actor1","Actor2"}
actorImgs[1] = love.graphics.newImage("assets/graphics/Characters/001-Fighter01.png")
-- anim test
local image,animation
-- actor
actor={}
-- local actors={}
local skills={}
canvas = love.graphics.newCanvas()
canvasGUI = love.graphics.newCanvas()
local tx
local ty
-- bullet
local bullet={}
local bullets={}
-- shader
local code =[[
vec4 effect(vec4 color,Image texture,vec2 tc,vec2 sc){
	return Texel(texture,vec2((tc.x-0.5)/(tc.y+1)+0.5,tc.y));
}
]]
shader = love.graphics.newShader(code)

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
	drawMsg()
	drawBag(actor)
	love.graphics.print("FPS:" .. love.timer.getFPS(),1220,0)
	drawTile(actorImgs[1],0,0,32,48,640,400)

	love.graphics.setCanvas()
end

function love.load()
	-- anim test
	image = actorImgs[1]
	skillImg = love.graphics.newImage("assets/graphics/Animations/Attack2.png")
	local skillG = anim8.newGrid(192,192,skillImg:getWidth(),skillImg:getHeight())
	local g = anim8.newGrid(32,48,image:getWidth(),image:getHeight())
	animation = anim8.newAnimation(g('1-4',2),0.2)
	skillAnim = anim8.newAnimation(skillG('1-5',1),0.2)

	--
	font = love.graphics.newFont("assets/font/msyh.ttf", 18)
	-- love.graphics.print(colorT["RED"])
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
		player = {
			image = actorImgs[1],
			x = 32,
			y = 48,
			r = 0,
		}
	}
	-- Update callback for Custom Layer
	function spriteLayer:update(dt)
		-- for _, sprite in pairs(self.sprites) do
		-- 	sprite.r = sprite.r + math.rad(90 * dt)
		-- end
			-- sprite.x = actor.x
			-- sprite.y = actor.y
			flyTxt(flytxt)

	end

	-- Draw callback for Custom Layer
	function spriteLayer:draw()
		for _, sprite in pairs(self.sprites) do
			-- local x = math.floor(sprite.x)
			-- local y = math.floor(sprite.y)
			-- local r = sprite.r
			-- test
			local x = math.floor(actor.x/2)
    		local y = math.floor(actor.y/2)

			-- love.graphics.draw(sprite.image, x, y, r)
			-- drawTile(actorImgs[1],0,0,32,48,x,y)
			-- anim 8 test
			animation:draw(image,actor.x/2,actor.y/2)
			love.graphics.circle("line", actor.x/2, actor.y/2, 32)
			love.graphics.rectangle("line", actor.x/2, actor.y/2, 32,32)
			if skillAnim.status=="playing" then
				skillAnim:draw(skillImg,(actor.x-256)/2,(actor.y-158)/2)
			end
			-- skillAnim.status="pause"
			flytxt = {}
			flytxt.x = 100
			flytxt.y = 100
			flytxt.contant="35点挫伤"
			flytxt.cd = 1
			flytxt.color = {255,0,0,200}
			flytxt.display = true
			flyTxt(flytxt)
		end
	end
	-- 角色
	actor=actors[1]
	actor["说"]="你好"
	say(actor,"你好")
	guiUpdata(actor)
	canvasLoad()
end

function love.update(dt)
	world:update(dt)
	map:update(dt)
	key(dt,actor)
	-- 地图的位移
	tx = math.floor((actor.x - 1280)/ 2)
    ty = math.floor((actor.y - 800)/ 2)
    -- 画布
    canvasLoad()
    -- anim8 test
    animation:update(dt)
    skillAnim:update(dt)
end

function love.draw()
	love.graphics.setShader(shader)
	love.graphics.draw(canvas)
	love.graphics.setShader()
	-- GUI
	guiDraw()
	drawMsg()
	drawBag(actor)
	love.graphics.print("FPS:" .. love.timer.getFPS(),1220,0)
    -- local text = love.graphics.newText(font,"")
    -- text:setf({{255,0,0,255},"ceshi"},100,"left")
    -- love.graphics.draw(text,100,100)
end

function flyTxt(fly)
	if fly.cd<0 then
		fly.cd=fly.cd
		fly.display=false
	end
	if fly.display then
		local dt = love.timer.getDelta()
		fly.cd = fly.cd - dt
		local text = love.graphics.newText(font,"")
		text:setf({fly.color,fly.contant},100,"center")
		love.graphics.draw(text,300,300+fly.cd*32)
	end
end