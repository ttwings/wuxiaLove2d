require 'lib.behavior3.b3'

local tick = b3.Class("Tick")
b3.Tick = tick

function tick:ctor()
	self.tree = nil
	self.debug = nil
	self.target = nil
	self.blackboard = nil

	self._openNodes = {}
	self._nodeCount = 0
end

function tick:_enterNode(node)
	self._nodeCount = self._nodeCount + 1
	table.insert(self._openNodes, node)
end

function tick:_openNode(node)
end

function tick:_tickNode(node)
end

function tick:_closeNode(node)
end

function tick:_exitNode(node)
end