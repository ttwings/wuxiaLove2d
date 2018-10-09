---@class love.system
---Provides access to information about the user's system.
local m = {}

---The basic state of the system's power supply.
PowerState = {
	---Cannot determine power status.
	['unknown'] = 1,
	---Not plugged in, running on a battery.
	['battery'] = 2,
	---Plugged in, no battery available.
	['nobattery'] = 3,
	---Plugged in, charging battery.
	['charging'] = 4,
	---Plugged in, battery is fully charged.
	['charged'] = 5,
}
---Gets text from the clipboard.
---@return string
function m.getClipboardText() end

---Gets the current operating system. In general, LÖVE abstracts away the need to know the current operating system, but there are a few cases where it can be useful (especially in combination with os.execute.)
---@return string
function m.getOS() end

---Gets information about the system's power supply.
---@return PowerState, number, number
function m.getPowerInfo() end

---Gets the number of CPU cores in the system.
---
---The number includes the threads reported if technologies such as Intel's Hyper-threading are enabled. For example, on a 4-core CPU with Hyper-threading, this function will return 8.
---@return number
function m.getProcessorCount() end

---Opens a URL with the user's web or file browser.
---@param url string @The URL to open. Must be formatted as a proper URL.

To open a file or folder, "file://" must be prepended to the path.
---@return boolean
function m.openURL(url) end

---Puts text in the clipboard.
---@param text string @The new text to hold in the system's clipboard.
function m.setClipboardText(text) end

---Causes the device to vibrate, if possible. Currently this will only work on Android and iOS devices that have a built-in vibration motor.
---@param seconds number @The duration to vibrate for. If called on an iOS device, it will always vibrate for 0.5 seconds due to limitations in the iOS system APIs.
function m.vibrate(seconds) end

return m