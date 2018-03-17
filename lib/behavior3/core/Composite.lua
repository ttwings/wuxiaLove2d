require 'lib.behavior3.core.BaseNode'

local composite = b3.Class("Composite", b3.BaseNode)
b3.Composite = composite

function composite:ctor(params)
	self.children = (params and params.children) or {}
end