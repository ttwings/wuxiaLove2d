---@class love.joystick
---Provides an interface to the user's joystick.
local m = {}

--region Joystick
---@class Joystick : Object
---Represents a physical joystick.
local Joystick = {}
---Gets the direction of each axis.
---@return number, number, number
function Joystick:getAxes() end

---Gets the direction of an axis.
---@param axis number @The index of the axis to be checked.
---@return number
function Joystick:getAxis(axis) end

---Gets the number of axes on the joystick.
---@return number
function Joystick:getAxisCount() end

---Gets the number of buttons on the joystick.
---@return number
function Joystick:getButtonCount() end

---Gets a stable GUID unique to the type of the physical joystick which does not change over time. For example, all Sony Dualshock 3 controllers in OS X have the same GUID. The value is platform-dependent.
---@return string
function Joystick:getGUID() end

---Gets the direction of a virtual gamepad axis. If the Joystick isn't recognized as a gamepad or isn't connected, this function will always return 0.
---@param axis GamepadAxis @The virtual axis to be checked.
---@return number
function Joystick:getGamepadAxis(axis) end

---Gets the button, axis or hat that a virtual gamepad input is bound to.
---@param axis GamepadAxis @The virtual gamepad axis to get the binding for.
---@return JoystickInputType, number, JoystickHat
---@overload fun(button:GamepadAxis):JoystickInputType, number, JoystickHat
function Joystick:getGamepadMapping(axis) end

---Gets the direction of the Joystick's hat.
---@param hat number @The index of the hat to be checked.
---@return JoystickHat
function Joystick:getHat(hat) end

---Gets the number of hats on the joystick.
---@return number
function Joystick:getHatCount() end

---Gets the joystick's unique identifier. The identifier will remain the same for the life of the game, even when the Joystick is disconnected and reconnected, but it will change when the game is re-launched.
---@return number, number
function Joystick:getID() end

---Gets the name of the joystick.
---@return string
function Joystick:getName() end

---Gets the current vibration motor strengths on a Joystick with rumble support.
---@return number, number
function Joystick:getVibration() end

---Gets whether the Joystick is connected.
---@return boolean
function Joystick:isConnected() end

---Checks if a button on the Joystick is pressed.
---
---LÖVE 0.9.0 had a bug which required the button indices passed to Joystick:isDown to be 0-based instead of 1-based, for example button 1 would be 0 for this function. It was fixed in 0.9.1.
---@param ... number @The index of a button to check.
---@return boolean
function Joystick:isDown(...) end

---Gets whether the Joystick is recognized as a gamepad. If this is the case, the Joystick's buttons and axes can be used in a standardized manner across different operating systems and joystick models via Joystick:getGamepadAxis and related functions.
---
---LÖVE automatically recognizes most popular controllers with a similar layout to the Xbox 360 controller as gamepads, but you can add more with love.joystick.setGamepadMapping.
---@return boolean
function Joystick:isGamepad() end

---Checks if a virtual gamepad button on the Joystick is pressed. If the Joystick is not recognized as a Gamepad or isn't connected, then this function will always return false.
---@param ... GamepadButton @The gamepad button to check.
---@return boolean
function Joystick:isGamepadDown(...) end

---Gets whether the Joystick supports vibration.
---@return boolean
function Joystick:isVibrationSupported() end

---Sets the vibration motor speeds on a Joystick with rumble support.
---@param left number @Strength of the left vibration motor on the Joystick. Must be in the range of [0, 1].
---@param right number @Strength of the right vibration motor on the Joystick. Must be in the range of [0, 1].
---@return boolean
---@overload fun(left:number, right:number, duration:number):boolean
function Joystick:setVibration(left, right) end

--endregion Joystick
---Virtual gamepad axes.
GamepadAxis = {
	---The x-axis of the left thumbstick.
	['leftx'] = 1,
	---The y-axis of the left thumbstick.
	['lefty'] = 2,
	---The x-axis of the right thumbstick.
	['rightx'] = 3,
	---The y-axis of the right thumbstick.
	['righty'] = 4,
	---Left analog trigger.
	['triggerleft'] = 5,
	---Right analog trigger.
	['triggerright'] = 6,
}
---Virtual gamepad buttons.
GamepadButton = {
	---Bottom face button (A).
	['a'] = 1,
	---Right face button (B).
	['b'] = 2,
	---Left face button (X).
	['x'] = 3,
	---Top face button (Y).
	['y'] = 4,
	---Back button.
	['back'] = 5,
	---Guide button.
	['guide'] = 6,
	---Start button.
	['start'] = 7,
	---Left stick click button.
	['leftstick'] = 8,
	---Right stick click button.
	['rightstick'] = 9,
	---Left bumper.
	['leftshoulder'] = 10,
	---Right bumper.
	['rightshoulder'] = 11,
	---D-pad up.
	['dpup'] = 12,
	---D-pad down.
	['dpdown'] = 13,
	---D-pad left.
	['dpleft'] = 14,
	---D-pad right.
	['dpright'] = 15,
}
---Joystick hat positions.
JoystickHat = {
	---Centered
	['c'] = 1,
	---Down
	['d'] = 2,
	---Left
	['l'] = 3,
	---Left+Down
	['ld'] = 4,
	---Left+Up
	['lu'] = 5,
	---Right
	['r'] = 6,
	---Right+Down
	['rd'] = 7,
	---Right+Up
	['ru'] = 8,
	---Up
	['u'] = 9,
}
---Types of Joystick inputs.
JoystickInputType = {
	---Analog axis.
	['axis'] = 1,
	---Button.
	['button'] = 2,
	---8-direction hat value.
	['hat'] = 3,
}
---Gets the number of connected joysticks.
---@return number
function m.getJoystickCount() end

---Gets a list of connected Joysticks.
---@return table
function m.getJoysticks() end

---Loads a gamepad mappings string or file created with love.joystick.saveGamepadMappings.
---@param filename string @The filename to load the mappings string from.
---@overload fun(mappings:string):void
function m.loadGamepadMappings(filename) end

---Saves the virtual gamepad mappings of all Joysticks that are recognized as gamepads and have either been recently used or their gamepad bindings have been modified.
---@param filename string @The filename to save the mappings string to.
---@return string
function m.saveGamepadMappings(filename) end

---Binds a virtual gamepad input to a button, axis or hat for all Joysticks of a certain type. For example, if this function is used with a GUID returned by a Dualshock 3 controller in OS X, the binding will affect Joystick:getGamepadAxis and Joystick:isGamepadDown for all Dualshock 3 controllers used with the game when run in OS X.
---
---LÖVE includes built-in gamepad bindings for many common controllers. This function lets you change the bindings or add new ones for types of Joysticks which aren't recognized as gamepads by default.
---
---The virtual gamepad buttons and axes are designed around the Xbox 360 controller layout.
---@param guid string @The OS-dependent GUID for the type of Joystick the binding will affect.
---@param button GamepadButton @The virtual gamepad button to bind.
---@param inputtype JoystickInputType @The type of input to bind the virtual gamepad button to.
---@param inputindex number @The index of the axis, button, or hat to bind the virtual gamepad button to.
---@param hatdirection JoystickHat @The direction of the hat, if the virtual gamepad button will be bound to a hat. nil otherwise.
---@return boolean
---@overload fun(guid:string, axis:GamepadAxis, inputtype:JoystickInputType, inputindex:number, hatdirection:JoystickHat):boolean
function m.setGamepadMapping(guid, button, inputtype, inputindex, hatdirection) end

return m