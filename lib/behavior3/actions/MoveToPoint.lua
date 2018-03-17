local moveToPoint = b3.Class("MoveToPoint", b3.Action)
b3.MoveToPoint = moveToPoint

function moveToPoint:ctor(settings)
	b3.Action.ctor(self)

	self.name = "moveToPoint"
	self.title = "moveToPoint"
	self.properties = {x=0,y=0}
end

function moveToPoint:open(tick)
	local point = {x = self.properties.x,y = self.properties.y}
	tick.blackboard:set("point",point)
end

function moveToPoint:tick(tick)

	local point = tick.blackboard:get('point')
	local actor = tick.blackboard:get('actor')
	print(point.x)
    local d = math.getDirection(actor.x,actor.y,point.x,point.y)
    print(d)

	if point.x == actor.x and point.y == actor.y then
		return b3.SUCCESS
	end
	if d == 'N' then Actions.moveN(actor) end
    if d == 'S' then Actions.moveS(actor) end
    if d == 'W' then Actions.moveW(actor) end
    if d == 'E' then Actions.moveE(actor) end
    if d == 'EN' then Actions.moveEN(actor) end
    if d == 'ES' then Actions.moveES(actor) end
    if d == 'WN' then Actions.moveWN(actor) end
    if d == 'WS' then Actions.moveWS(actor) end

	return b3.RUNNING
end
