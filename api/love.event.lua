---@class love.event
---Manages events, like keypresses.
local m = {}

---Arguments to love.event.push() and the like.
Event = {
	---Window focus gained or lost
	['focus'] = 1,
	---Joystick axis motion
	['joystickaxis'] = 2,
	---Joystick hat pressed
	['joystickhat'] = 3,
	---Joystick pressed
	['joystickpressed'] = 4,
	---Joystick released
	['joystickreleased'] = 5,
	---Key pressed
	['keypressed'] = 6,
	---Key released
	['keyreleased'] = 7,
	---Window mouse focus gained or lost
	['mousefocus'] = 8,
	---Mouse pressed
	['mousepressed'] = 9,
	---Mouse released
	['mousereleased'] = 10,
	---Window size changed by the user
	['resize'] = 11,
	---A Lua error has occurred in a thread.
	['threaderror'] = 12,
	---Quit
	['quit'] = 13,
	---Window is minimized or un-minimized by the user
	['visible'] = 14,
}
---Clears the event queue.
function m.clear() end

---Returns an iterator for messages in the event queue.
---@return function
function m.poll() end

---Pump events into the event queue. This is a low-level function, and is usually not called by the user, but by love.run. Note that this does need to be called for any OS to think you're still running, and if you want to handle OS-generated events at all (think callbacks). love.event.pump can only be called from the main thread, but afterwards, the rest of love.event can be used from any other thread.
function m.pump() end

---Adds an event to the event queue.
---@param e Event @The name of the event.
---@param a Variant @First event argument.
---@param b Variant @Second event argument.
---@param c Variant @Third event argument.
---@param d Variant @Fourth event argument.
function m.push(e, a, b, c, d) end

---Adds the quit event to the queue.
---
---The quit event is a signal for the event handler to close LÖVE. It's possible to abort the exit process with the love.quit callback.
---@overload fun(exitstatus:number):void
---@overload fun(restart:string):void
function m.quit() end

---Like love.event.poll but blocks until there is an event in the queue.
---@return Event, Variant, Variant, Variant, Variant
function m.wait() end

return m