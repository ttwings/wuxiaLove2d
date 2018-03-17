require 'lib.behavior3.core.Action'

local findWanderPoint = b3.Class("FindWanderPoint", b3.Action)
b3.FindWanderPoint = findWanderPoint

function findWanderPoint:ctor(settings)
	b3.Action.ctor(self)

	self.name = "FindWanderPoint"
	self.title = "FindWanderPoint"
	self.properties = {x=0,y=0,radius=0}
end

function findWanderPoint:open(tick)
	local point = {x = self.properties.x,y = self.properties.y}
	print('x:'..point.x..' y:'..point.y)
	tick.blackboard:set('point',point)
end

function findWanderPoint:tick(tick)

	local actor = tick.blackboard:get('actor')
	local point = tick.blackboard:get('point')
	if (point.x - actor.x)^2 + (point.y - actor.y)^2 < self.properties.radius^2 then
		return b3.SUCCESS
	end

	return b3.RUNNING
end