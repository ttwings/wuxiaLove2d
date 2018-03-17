require 'lib.behavior3.core.BaseNode'

local action = b3.Class("Action", b3.BaseNode)
b3.Action = action

function action:ctor()
	b3.BaseNode.ctor(self)

	self.category = b3.ACTION
end