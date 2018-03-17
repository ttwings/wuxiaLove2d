require 'lib.behavior3.b3'

local baseNode = b3.Class("BaseNode")
b3.BaseNode = baseNode

function baseNode:ctor(params)
	self.id = b3.createUUID()
	self.name = ""
	self.title = self.title or self.name
	self.description = ""
	self.parameters = {}
	self.properties = {}
end

function baseNode:_execute(tick)
	--ENTER
	self:_enter(tick)

	--OPEN
	if not (tick.blackboard:get("isOpen", tick.tree.id, self.id)) then
		self:_open(tick)
	end

	--TICK
	local status = self:_tick(tick)

	--CLOSE
	if status ~= b3.RUNNING then
		self:_close(tick)
	end

	--EXIT
	self:_exit(tick)

	return status
end

function baseNode:_enter(tick)
	tick:_enterNode(self)
	self:enter(tick)
end

function baseNode:_open(tick)
	tick:_openNode(self)
	tick.blackboard:set("isOpen", true, tick.tree.id, self.id)
	self:open(tick)
end

function baseNode:_tick(tick)
	tick:_tickNode(self)
	return self:tick(tick)
end

function baseNode:_close(tick)
	tick:_closeNode(self)
	tick.blackboard:set("isOpen", false, tick.tree.id, self.id)
	self:close(tick)
end

function baseNode:_exit(tick)
	tick:_exitNode(self)
	self:exit(tick)
end

function baseNode:enter(tick)
end

function baseNode:open(tick)
end

function baseNode:tick(tick)
end

function baseNode:close(tick)
end

function baseNode:exit(tick)
end

