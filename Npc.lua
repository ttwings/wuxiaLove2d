local actorData = require("assets.data.actorData")

npcs={}
function npcs:add(name)
	if actorData[name] then
		npc = Class("npc",Actor)
		npc:readData(actorData[name])
		table.insert( npcs, npc )
	end

end

function npcs:load()
	for k, v in pairs(actorData) do
		npcs:add(v.name)
	end
end

function npcs:update(dt)
	for i = #npcs,1,-1 do
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