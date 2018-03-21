require 'lib.behavior3.core.Condition'

local findTarget = b3.Class("FindTarget", b3.Condition)
b3.FindTarget = findTarget

local npcs = require('Npcs')

function findTarget:ctor(settings)
	b3.Action.ctor(self)

	self.name = "FindTarget"
	self.title = "FindTarget"
	self.properties = {class = '' ,name = '',distance = 2}

end

function findTarget:open(tick)
    local name = self.properties.name
    local class = self.properties.class
    local actor = {}
    --if class == 'Actor' then
    --    actor = npcs[name]
    --end
    actor = player
    local target = tick.blackboard:set('target',actor)
end

function findTarget:tick(tick)
	local actor = tick.blackboard:get('actor')
	local target = tick.blackboard:get('target')
	local distance = math.abs(target.tx - actor.tx) + math.abs(target.ty - actor.ty)
	if distance <= self.properties.distance then
		return b3.SUCCESS
	end

	return b3.FAILURE
end