require 'lib.behavior3.core.Composite'

local memSequence = b3.Class("MemSequence", b3.Composite)
b3.MemSequence = memSequence

function memSequence:ctor(...)
	-- b3.MemSequence.ctor(self)
    b3.Composite.ctor(self)
    -- b3.MemSequence.super.ctor(self , ...)
	self.name = "MemSequence"
end

function memSequence:open(tick)
	tick.blackboard:set("runningChild", 0, tick.tree.id, self.id)
end

function memSequence:tick(tick)
	local child = tick.blackboard:get("runningChild", tick.tree.id, self.id)
	for i,v in pairs(self.children) do
		local status = v:_execute(tick)

		if status ~= b3.SUCCESS then
			if status == b3.RUNNING then
				tick.blackboard:set("runningChild", i, tick.tree.id, self.id)
			end

			return status
		end
	end

	return b3.SUCCESS
end