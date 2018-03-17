require "lib.behavior3.core.Decorator"

local repeatUntilFailure = b3.Class("RepeatUntilFailure", b3.Decorator)
b3.RepeatUntilFailure = repeatUntilFailure

function repeatUntilFailure:ctor(params)
	b3.Decorator.ctor(self)

	if not params then
		params = {}
	end

	self.name = "RepeatUntilFailure"
	self.title = "Repeat Until Failure"
	self.parameters = {maxLoop = -1}

	self.maxLoop = params.maxLoop or -1
end

function repeatUntilFailure:open(tick)
	tick.blackboard.set("i", 0, tick.tree.id, self.id)
end

function repeatUntilFailure:tick(tick)
	if not self.child then
		return b3.ERROR
	end

	local i = tick.blackboard.get("i", tick.tree.id , self.id)
	local status = b3.ERROR

	while(self.maxLoop < 0 or i < self.maxLoop)
	do
		local status = self.child:_execute(tick)

		if status == b3.SUCCESS then
			i = i + 1
		else
			break
		end
	end

	i = tick.blackboard.set("i", i, tick.tree.id, self.id)
	return status
end
