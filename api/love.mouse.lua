---@class love.mouse
---Provides an interface to the user's mouse.
local m = {}

--region Cursor
---@class Cursor : Object
---Represents a hardware cursor.
local Cursor = {}
---Gets the type of the Cursor.
---@return CursorType
function Cursor:getType() end

--endregion Cursor
---Types of hardware cursors.
CursorType = {
	---The cursor is using a custom image.
	['image'] = 1,
	---An arrow pointer.
	['arrow'] = 2,
	---An I-beam, normally used when mousing over editable or selectable text.
	['ibeam'] = 3,
	---Wait graphic.
	['wait'] = 4,
	---Small wait cursor with an arrow pointer.
	['waitarrow'] = 5,
	---Crosshair symbol.
	['crosshair'] = 6,
	---Double arrow pointing to the top-left and bottom-right.
	['sizenwse'] = 7,
	---Double arrow pointing to the top-right and bottom-left.
	['sizenesw'] = 8,
	---Double arrow pointing left and right.
	['sizewe'] = 9,
	---Double arrow pointing up and down.
	['sizens'] = 10,
	---Four-pointed arrow pointing up, down, left, and right.
	['sizeall'] = 11,
	---Slashed circle or crossbones.
	['no'] = 12,
	---Hand symbol.
	['hand'] = 13,
}
---Gets the current Cursor.
---@return Cursor
function m.getCursor() end

---Returns the current position of the mouse.
---@return number, number
function m.getPosition() end

---Gets whether relative mode is enabled for the mouse.
---
---If relative mode is enabled, the cursor is hidden and doesn't move when the mouse does, but relative mouse motion events are still generated via love.mousemoved. This lets the mouse move in any direction indefinitely without the cursor getting stuck at the edges of the screen.
---
---The reported position of the mouse is not updated while relative mode is enabled, even when relative mouse motion events are generated.
---@return boolean
function m.getRelativeMode() end

---Gets a Cursor object representing a system-native hardware cursor.
---
--- Hardware cursors are framerate-independent and work the same way as normal operating system cursors. Unlike drawing an image at the mouse's current coordinates, hardware cursors never have visible lag between when the mouse is moved and when the cursor position updates, even at low framerates.
---@param ctype CursorType @The type of system cursor to get.
---@return Cursor
function m.getSystemCursor(ctype) end

---Returns the current x position of the mouse.
---@return number
function m.getX() end

---Returns the current y position of the mouse.
---@return number
function m.getY() end

---Gets whether cursor functionality is supported.
---
---If it isn't supported, calling love.mouse.newCursor and love.mouse.getSystemCursor will cause an error. Mobile devices do not support cursors.
---@return boolean
function m.hasCursor() end

---Checks whether a certain mouse button is down. This function does not detect mousewheel scrolling; you must use the love.wheelmoved (or love.mousepressed in version 0.9.2 and older) callback for that.
---@param button number @The index of a button to check. 1 is the primary mouse button, 2 is the secondary mouse button, etc.
---@param ... number @Additional button numbers to check.
---@return boolean
function m.isDown(button, ...) end

---Checks if the mouse is grabbed.
---@return boolean
function m.isGrabbed() end

---Checks if the cursor is visible.
---@return boolean
function m.isVisible() end

---Creates a new hardware Cursor object from an image file or ImageData.
---
---Hardware cursors are framerate-independent and work the same way as normal operating system cursors. Unlike drawing an image at the mouse's current coordinates, hardware cursors never have visible lag between when the mouse is moved and when the cursor position updates, even at low framerates.
---
---The hot spot is the point the operating system uses to determine what was clicked and at what position the mouse cursor is. For example, the normal arrow pointer normally has its hot spot at the top left of the image, but a crosshair cursor might have it in the middle.
---@param imageData ImageData @The ImageData to use for the the new Cursor.
---@param hotx number @The x-coordinate in the ImageData of the cursor's hot spot.
---@param hoty number @The y-coordinate in the ImageData of the cursor's hot spot.
---@return Cursor
---@overload fun(filepath:string, hotx:number, hoty:number):Cursor
---@overload fun(fileData:FileData, hotx:number, hoty:number):Cursor
function m.newCursor(imageData, hotx, hoty) end

---Sets the current mouse cursor.
---
---Resets the current mouse cursor to the default when called without arguments.
---@overload fun(cursor:Cursor):void
function m.setCursor() end

---Grabs the mouse and confines it to the window.
---@param grab boolean @True to confine the mouse, false to let it leave the window.
function m.setGrabbed(grab) end

---Sets the current position of the mouse. Non-integer values are floored.
---@param x number @The new position of the mouse along the x-axis.
---@param y number @The new position of the mouse along the y-axis.
function m.setPosition(x, y) end

---Sets whether relative mode is enabled for the mouse.
---
---When relative mode is enabled, the cursor is hidden and doesn't move when the mouse does, but relative mouse motion events are still generated via love.mousemoved. This lets the mouse move in any direction indefinitely without the cursor getting stuck at the edges of the screen.
---
---The reported position of the mouse is not updated while relative mode is enabled, even when relative mouse motion events are generated.
---@param enable boolean @True to enable relative mode, false to disable it.
function m.setRelativeMode(enable) end

---Sets the visibility of the cursor.
---@param visible boolean @True to set the cursor to visible, false to hide the cursor.
function m.setVisible(visible) end

---Sets the current X position of the mouse. Non-integer values are floored.
---@param x number @The new position of the mouse along the x-axis.
function m.setX(x) end

---Sets the current Y position of the mouse. Non-integer values are floored.
---@param y number @The new position of the mouse along the y-axis.
function m.setY(y) end

return m