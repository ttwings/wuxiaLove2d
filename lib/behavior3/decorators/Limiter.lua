require 'lib.behavior3.core.Composite'

local limiter = b3.Class("Limiter", b3.Decorator)
b3.Limiter = limiter

function limiter:ctor()
	b3.Decorator.ctor(self)

	self.name = "Limiter"
	self.title = "Limit <maxLoop> Activations"
	self.parameters = {maxLoop = 1,}
end

function limiter:open(tick)
	tick.blackboard.set("i", 0, tick.tree.id, self.id)
end

function limiter:tick(tick)
	if not self.child then
		return b3.ERROR
	end

	local i = tick.blackboard:get("i", tick.tree.id, self.id)

	if i < self.maxLoop then
		local status = self.child:_execute(tick)

		if status == b3.SUCCESS or status == b3.FAILURE then
			tick.blackboard:set("i", i+1, tick.tree.id, self.id)
		end

		return status
	end

	return b3.FAILURE
end
