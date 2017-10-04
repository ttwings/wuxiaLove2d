function love.load()
	local map = love.graphics.newImage("20170827.jpg")
	local vert1 = {
		{0,0,0,0},
		{0,1,0.2,1}, -- 右上点
		{0.5,0,0.5,0},
		{0.5,1,0.5,1},

	}
	vert2 = {
		{0.5,1,0.5,1},
		{1,1,0.8,1},
		{0.5,0,0.5,0},
		{1,0,1,0},
	}
	mesh1 = love.graphics.newMesh(vert1, "strip")  --quest 1
	mesh1:setTexture(map)
	mesh2 = love.graphics.newMesh(vert2, "strip")  --quest 1
	mesh2:setTexture(map)
	mesh3 = love.graphics.newMesh(vert3, "strip")
	mesh3:setTexture(map)
end

function love.draw()
	love.graphics.draw(mesh1,0,0,0,800,600)
	love.graphics.draw(mesh2,0,0,0,800,600)
	-- love.graphics.draw(mesh3,0,0,0,800,600)
end