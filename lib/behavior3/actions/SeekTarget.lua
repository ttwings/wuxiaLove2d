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
	if d == 'N' then Actions.moveN(actor) 
        elseif d == 'S' then Actions.moveS(actor) 
        elseif d == 'W' then Actions.moveW(actor) 
        elseif d == 'E' then Actions.moveE(actor) 
        elseif d == 'EN' then Actions.moveEN(actor) 
        elseif d == 'ES' then Actions.moveES(actor) 
        elseif d == 'WN' then Actions.moveWN(actor) 
        elseif d == 'WS' then Actions.moveWS(actor) 
    end

	return b3.RUNNING
end