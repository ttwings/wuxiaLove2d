require 'lib.behavior3.core.Composite'

local selector = b3.Class("Selector", b3.Composite)
b3.Selector = selector

function selector:ctor()
	b3.Composite.ctor(self)

	self.name = "Selector"
end

function selector:tick(tick)
	-- for i = 1,table.getn(self.children) do
	-- 	local v = self.children[i]
	-- 	local status = v:_execute(tick)
	-- end

	local len = table.getn(self.children)
	local index = math.random(1,len)
	local v = self.children[index]
	local status = v:_execute(tick)
	print(i,v.title)
	if status ~= b3.SUCCESS then
		return status
	end
	return b3.SUCCESS
end
