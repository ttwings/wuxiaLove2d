require 'lib.behavior3.core.Action'

local failer = b3.Class("Failer", b3.Action)
b3.Failer = failer

function failer:ctor()
	b3.Action.ctor(self)

	self.name = "Failer"
end

function failer:tick()
	return b3.SUCCESS
end
