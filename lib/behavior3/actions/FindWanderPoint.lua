require 'lib.behavior3.core.Action'

local findWanderPoint = b3.Class("FindWanderPoint", b3.Action)
b3.FindWanderPoint = findWanderPoint

function findWanderPoint:ctor(settings)
	b3.Action.ctor(self)

	self.name = "FindWanderPoint"
	self.title = "FindWanderPoint"
	-- self.parameters = {x=self.x,y=self.y,radius=10}
	self.properties = {tx=-1,ty=-1,radius=-1}
	-- self.x = settings.x or 0
	-- self.y = settings.y or 0
	-- self.radius = settings.radius or 5
end

function findWanderPoint:open(tick)
	local point = {tx = self.properties.tx,ty = self.properties.ty}
	print('x:'..point.tx..' y:'..point.ty)
	tick.blackboard:set('point',point)
end

function findWanderPoint:tick(tick)

	local actor = tick.blackboard:get('actor')
	local point = tick.blackboard:get('point')
	if (point.tx - actor.tx)^2 + (point.ty - actor.ty)^2 < self.properties.radius^2 then
		return b3.SUCCESS
	end

	return b3.RUNNING
end