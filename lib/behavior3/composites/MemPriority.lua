 require 'lib.behavior3.core.Composite'

local memPriority = b3.Class("MemPriority", b3.Composite)
b3.MemPriority = memPriority

function memPriority:ctor()
	b3.Composite.ctor(self)
    -- b3.MemPriority.super.ctor(self,para)
	self.name = "MemPriority"
end

function memPriority:open(tick)
	tick.blackboard:set("runningChild", 0, tick.tree.id, self.id)
end

function memPriority:tick(tick)
	local child = tick.blackboard:get("runningChild", tick.tree.id, self.id)
	for i,v in pairs(self.children) do
		local status = v:_execute(tick)

		if status ~= b3.FAILURE then
			if status == b3.RUNNING then
				tick.blackboard:set("runningChild", i, tick.tree.id, self.id)
			end

			return status
		end
	end

	return b3.FAILURE
end