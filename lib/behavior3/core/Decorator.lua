require 'lib.behavior3.core.BaseNode'

local decorator = b3.Class("Decorator", b3.BaseNode)
b3.Decorator = decorator

function decorator:ctor(params)
	b3.BaseNode.ctor(self, params)

	if not params then
		params = {}
	end

	self.child = params.child or nil
end
