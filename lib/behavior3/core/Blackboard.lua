require 'lib.behavior3.b3'

local blackboard = b3.Class("Blackboard")
b3.Blackboard = blackboard

function blackboard:ctor()
	self._baseMemory = {}
	self._treeMemory = {}
end

function blackboard:_getTreeMemory(treeScope)
	if not self._treeMemory[treeScope] then
		self._treeMemory[treeScope] = {nodeMemory = {}, openNodes = {}, traversalDepth = 0, traversalCycle = 0}
	end
	return self._treeMemory[treeScope]
end

function blackboard:_getNodeMemory(treeMemory, nodeScope)
	local memory = treeMemory.nodeMemory

	if not memory then
		memory = {}
	end

	if memory and not memory[nodeScope] then
		memory[nodeScope] = {}
	end

	return memory[nodeScope]
end

function blackboard:_getMemory(treeScope, nodeScope)
	local memory = self._baseMemory

	if treeScope then
		memory = self:_getTreeMemory(treeScope)

		if nodeScope then
			memory = self:_getNodeMemory(memory, nodeScope)
		end
	end

	return memory
end

function blackboard:set(key, value, treeScope, nodeScope)
	local memory = self:_getMemory(treeScope, nodeScope)
	memory[key] = value
end

function blackboard:get(key, treeScope, nodeScope)
	local memory = self:_getMemory(treeScope, nodeScope)
	if memory then
		return memory[key]
	end
	return {}
end
