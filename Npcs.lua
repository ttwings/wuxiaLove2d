local assets = require("lib.cargo").init("assets")
local actorData = assets.data.actorData
local npcs={}
function npcs:add(name)
	if actorData[name] then
		Npc = Class("npc",Actor)
		Npc:new(actorData[name])
		--npc:readData
		table.insert( npcs, Npc )
	end

end

function npcs:load()
	for k, v in pairs(actorData) do
		npcs:add(v.name)
	end
	return npcs
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
	--for k, v in pairs(npcs) do
	--	self[k]:drawAnim()
	--end
end

return npcs