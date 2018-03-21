require 'lib.behavior3.core.Condition'

local isfarawayTarget = b3.Class("IsfarawayTarget", b3.Condition)
b3.IsfarawayTarget = isfarawayTarget

function isfarawayTarget:ctor(settings)
	b3.Action.ctor(self)

	self.name = "IsfarawayTarget"
	self.title = "IsfarawayTarget"
	self.properties = {distance = 2}

end


function isfarawayTarget:tick(tick)
	local actor = tick.blackboard:get('actor')
	local target = tick.blackboard:get('target')
	local distance = math.abs(target.tx - actor.tx) + math.abs(target.ty - actor.ty)
	if distance <= self.properties.distance then
		return b3.SUCCESS
	end

	return b3.RUNNING
end