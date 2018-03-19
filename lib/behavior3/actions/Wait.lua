require 'lib.behavior3.core.Action'
local date = require 'Date'
local wait = b3.Class("Wait", b3.Action)
b3.Wait = wait

function wait:ctor(settings)
	b3.Action.ctor(self)

	self.name = "Wait"
	self.title = "Wait <milliseconds>ms"
	self.properties = {milliseconds = 0,turn = 0}
	self.endTime = self.properties.turn
end
function wait:open(tick)
	local startTime = date.turn
	tick.blackboard:set('startTime',startTime)
	local actor = tick.blackboard:get('actor')
	Actions.wait(actor,self.properties.turn)
end

function wait:tick(tick)
	local currTime = date.turn
	local startTime = tick.blackboard:get("startTime")
	--- 添加时间
	if currTime - startTime >= self.endTime then
		print('回合:'..currTime)
		return b3.SUCCESS
	end

	return b3.RUNNING
end
