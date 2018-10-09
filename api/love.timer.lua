---@class love.timer
---Provides an interface to the user's clock.
local m = {}

---Returns the average delta time (seconds per frame) over the last second.
---@return number
function m.getAverageDelta() end

---Returns the time between the last two frames.
---@return number
function m.getDelta() end

---Returns the current frames per second.
---@return number
function m.getFPS() end

---Returns the value of a timer with an unspecified starting time. This function should only be used to calculate differences between points in time, as the starting time of the timer is unknown.
---@return number
function m.getTime() end

---Sleeps the program for the specified amount of time.
---@param s number @Seconds to sleep for.
function m.sleep(s) end

---Measures the time between two frames. Calling this changes the return value of love.timer.getDelta.
function m.step() end

return m