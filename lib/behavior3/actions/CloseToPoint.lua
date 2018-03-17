local closeToPoint = b3.Class("CloseToPoint", b3.Action)
b3.CloseToPoint = closeToPoint

function closeToPoint:ctor(settings)
	b3.Action.ctor(self, settings)

	self.name = "closeToPoint"
	self.title = "closeToPoint"
	self.distance = settings.distance or 2
end

function closeToPoint:tick(tick)

	local player = tick.blackboard:get("player")
	local enemy = tick.blackboard:get('enemy')

    local d = math.getDirection(enemy.x,enemy.y,player.x,player.y)
    if d == 'N' then actions.moveN(enemy) end
    if d == 'S' then actions.moveS(enemy) end
    if d == 'W' then actions.moveW(enemy) end
    if d == 'E' then actions.moveE(enemy) end
	if math.abs(player.x - enemy.x) + math.abs(player.y - enemy.y) <= self.distance  then
		return b3.SUCCESS
	end

	return b3.RUNNING
end
