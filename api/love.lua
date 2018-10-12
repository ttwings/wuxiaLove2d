---@class love
local m = {}

--region Data
---@class Data : Object
---The superclass of all data.
local Data = {}
---Gets a pointer to the Data.
---@return light userdata
function Data:getPointer() end

---Gets the size of the Data.
---@return number
function Data:getSize() end

---Gets the full Data as a string.
---@return string
function Data:getString() end

--endregion Data
--region Drawable
---@class Drawable : Object
---Superclass for all things that can be drawn on screen. This is an abstract type that can't be created directly.
local Drawable = {}
--endregion Drawable
--region Object
---@class Object
---The superclass of all LÖVE types.
local Object = {}
---Gets the type of the object as a string.
---@return string
function Object:type() end

---Checks whether an object is of a certain type. If the object has the type with the specified name in its hierarchy, this function will return true.
---@param name string @The name of the type to check for.
---@return boolean
function Object:typeOf(name) end

--endregion Object
---@type love.audio
m.audio = nil

---@type love.event
m.event = nil

---@type love.filesystem
m.filesystem = nil

---@type love.graphics
m.graphics = nil

---@type love.image
m.image = nil

---@type love.joystick
m.joystick = nil

---@type love.keyboard
m.keyboard = nil

---@type love.math
m.math = nil

---@type love.mouse
m.mouse = nil

---@type love.physics
m.physics = nil

---@type love.sound
m.sound = nil

---@type love.system
m.system = nil

---@type love.thread
m.thread = nil

---@type love.timer
m.timer = nil

---@type love.touch
m.touch = nil

---@type love.video
m.video = nil

---@type love.window
m.window = nil

---Gets the current running version of LÖVE.
---@return number, number, number, string
function m.getVersion() end

return m