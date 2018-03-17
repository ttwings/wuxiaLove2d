require 'lib.behavior3.core.Action'

local succeeder = b3.Class("Succeeder", b3.Action)
b3.Succeeder = succeeder

function succeeder:ctor()
	b3.Action.ctor(self)

	self.name = "Succeeder"
end

function succeeder:tick(tick)
	return b3.SUCCESS
end