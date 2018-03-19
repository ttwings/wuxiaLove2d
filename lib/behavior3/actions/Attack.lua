require 'lib.behavior3.core.Action'

local attack = b3.Class("Attack", b3.Action)
b3.Attack = attack

function attack:ctor(settings)
	b3.Action.ctor(self)

	self.name = "Attack"
	self.title = "Attack"
	self.properties = {skill = ''}

end


function attack:tick(tick)
	local actor = tick.blackboard:get('actor')
	local target = tick.blackboard:get('target')
	local distance = math.abs(target.x - actor.x) + math.abs(target.y - actor.y)
	local attackDis = 5
    local skill = self.properties.skill
	if distance <= attackDis then
		Actions.attack(actor,target)
		return b3.SUCCESS
	end

	return b3.RUNNING
end
