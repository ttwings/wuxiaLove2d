local moveToRoom = b3.Class("MoveToRoom", b3.Action)
b3.MoveToRoom = moveToRoom

function moveToRoom:ctor(settings)
	b3.Action.ctor(self)
	self.name = "moveToRoom"
	self.title = "moveToRoom"
	self.properties = {room = ''}
end

function moveToRoom:open(tick)

end


function moveToRoom:tick(tick)
    local roomName = self.properties.room
    local room = rooms[roomName]
    local rx,ry = room.x,room.y
    local w,h = room.w,room.h

	local actor = tick.blackboard:get('actor')
    local inRoom = math.point

	if actor.room == self.properties.room then
		return b3.SUCCESS
	end

	return b3.RUNNING
end
