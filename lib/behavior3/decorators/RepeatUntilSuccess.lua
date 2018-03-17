require "lib.behavior3.core.Decorator"

local repeatUntilSuccess = b3.Class("RepeatUntilSuccess", b3.Decorator)
b3.RepeatUntilSuccess = repeatUntilSuccess

function repeatUntilSuccess:ctor(params)
	b3.Decorator.ctor(self)

	if not params then
		params = {}
	end

	self.name = "RepeatUntilSuccess"
	self.title = "Repeat Until Success"
	self.parameters = {maxLoop = -1}

	self.maxLoop = params.maxLoop or -1
end

function repeatUntilSuccess:open(tick)
	tick.blackboard.set("i", 0, tick.tree.id, self.id)
end

function repeatUntilSuccess:tick(tick)
	if not self.child then
		return b3.ERROR
	end

	local i = tick.blackboard.get("i", tick.tree.id , self.id)
	local status = b3.ERROR

	while(self.maxLoop < 0 or i < self.maxLoop)
	do
		local status = self.child:_execute(tick)

		if status == b3.FAILURE then
			i = i + 1
		else
			break
		end
	end

	i = tick.blackboard.set("i", i, tick.tree.id, self.id)
	return status
end
