require ('lib.util')
local moveToPoint = b3.Class("MoveToPoint", b3.Action)
b3.MoveToPoint = moveToPoint

function moveToPoint:ctor(settings)
	b3.Action.ctor(self)

	self.name = "moveToPoint"
	self.title = "moveToPoint"
	self.properties = {tx=0,ty=0}

end

function moveToPoint:tick(tick)
	local point = {tx = self.properties.tx,ty = self.properties.ty}
    local str = ('tx:%s ty:%s'):format(point.tx,point.ty)
	lovebird.print(str)
	local actor = tick.blackboard:get('actor')
    local d = math.getDirection(actor.tx,actor.ty,point.tx,point.ty)
    lovebird.print(d)
	if point.tx == actor.tx and point.ty == actor.ty then
		return b3.SUCCESS
	end
	if d == 'N' then Ations.moveN(actor) end
    if d == 'S' then Actions.moveS(actor) end
    if d == 'W' then Actions.moveW(actor) end
    if d == 'E' then Actions.moveE(actor) end
    if d == 'EN' then Actions.moveEN(actor) end
    if d == 'ES' then Actions.moveES(actor) end
    if d == 'WN' then Actions.moveWN(actor) end
    if d == 'WS' then Actions.moveWS(actor) end

	return b3.RUNNING
end
