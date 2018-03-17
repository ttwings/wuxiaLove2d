require 'lib.behavior3.core.Composite'

local priority = b3.Class("Priority", b3.Composite)
b3.Priority = priority

function priority:ctor()
	b3.Composite.ctor(self)

	self.name = "Priority"
end

function priority:tick(tick)
	for i,v in pairs(self.children) do
		local status = v:_execute(tick)

		if status ~= b3.FAILURE then
			return status
		end
	end

	return b3.FAILURE
end

