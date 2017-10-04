require( "Actor" )
npcs={}
function npcs:add(npc)
	table.insert( self, npc )
end

function npcs:add(actors,num)
	for k, v in pairs( actors) do
		local npc = Actor:new(v)
		table.insert( self, npc )
	end
end

function npcs:update(dt)
	for i = #npcs,1,-1 do
		npcs[i].x=npcs[i].x+math.random( 0, 1)
		npcs[i].y=npcs[i].y+math.random( 0, 1)
		npcs[i]:update(dt)
	end
end

function npcs:draw()
	for i = #npcs,1,-1 do
		npcs[i]:draw()
	end
end

function npcs:drawAnim()
	for i = #npcs,1,-1 do
		self[i]:drawAnim()
	end
end

return npcs