require ('lib.util')
local seekTarget = b3.Class("SeekTarget", b3.Action)
b3.SeekTarget = seekTarget

function seekTarget:ctor(settings)
	b3.Action.ctor(self)

	self.name = "SeekTarget"
	self.title = "SeekTarget"
	self.properties = {distance = -1}

end

function seekTarget:tick(tick)
	local target = tick.blackboard:get('target')
	local actor = tick.blackboard:get('actor')
    local d = math.getDirection(actor.tx,actor.ty,target.tx,target.ty)
    local distance = math.abs(target.tx - actor.tx) + math.abs(target.ty - actor.ty)
    print('distance:' .. distance)
	if  distance <= self.properties.distance then
		return b3.SUCCESS
	end
	if d == 'N' then actor:moveN()
        elseif d == 'S' then actor:moveS()
        elseif d == 'W' then actor:moveW()
        elseif d == 'E' then actor:moveE()
        --elseif d == 'EN' then actor:moveEN()
        --elseif d == 'ES' then actor:moveES()
        --elseif d == 'WN' then Actions.moveWN()
        --elseif d == 'WS' then Actions.moveWS()
    end

	return b3.RUNNING
end