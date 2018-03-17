require 'lib.behavior3.core.Composite'

local sequence = b3.Class("Sequence", b3.Composite)
b3.Sequence = sequence

function sequence:ctor()
	b3.Composite.ctor(self)

	self.name = "Sequence"
end

function sequence:tick(tick)
	for i = 1,table.getn(self.children) do
		local v = self.children[i]
		local status = v:_execute(tick)
		print(i,v.title)
		if status ~= b3.SUCCESS then
			return status
		end
	end
	return b3.SUCCESS
end
