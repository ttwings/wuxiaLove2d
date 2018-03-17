require 'lib.behavior3.core.Action'

local error = b3.Class("Error", b3.Action)
b3.Error = error

function error:ctor()
	b3.Action.ctor(self)

	self.name = "Error"
end

function error:tick()
	return b3.ERROR
end
