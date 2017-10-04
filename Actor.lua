require "lib/middleclass"
require "lib/anim8"

Actor=calss("actor")
Actor.property={}
function Actor:init(actorData)
	for k, v in pairs(actorData) do
		Actor.property.k=v
	end
end

function Actor:move(x,y)
	Actor.property.x = x
	Actor.property.y = y
end

function Actor:draw()
	local imagePath = "" .. Actor.property["行走图"]
	local image = love.graphics.newImage()
	love.graphics.draw()
end
