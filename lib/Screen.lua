--===============================================================================--
--                                                                               --
-- Copyright (c) 2014 - 2017 Robert Machmer                                      --
--                                                                               --
-- This software is provided 'as-is', without any express or implied             --
-- warranty. In no event will the authors be held liable for any damages         --
-- arising from the use of this software.                                        --
--                                                                               --
-- Permission is granted to anyone to use this software for any purpose,         --
-- including commercial applications, and to alter it and redistribute it        --
-- freely, subject to the following restrictions:                                --
--                                                                               --
--  1. The origin of this software must not be misrepresented; you must not      --
--      claim that you wrote the original software. If you use this software     --
--      in a product, an acknowledgment in the product documentation would be    --
--      appreciated but is not required.                                         --
--  2. Altered source versions must be plainly marked as such, and must not be   --
--      misrepresented as being the original software.                           --
--  3. This notice may not be removed or altered from any source distribution.   --
--                                                                               --
--===============================================================================--

local Screen = {}

-- ------------------------------------------------
-- Private Functions
-- ------------------------------------------------

---
-- Function stub.
--
local function null()
    return
end

-- ------------------------------------------------
-- Module
-- ------------------------------------------------

function Screen.new()
    local self = {}

    local active = true

    -- ------------------------------------------------
    -- Public Methods
    -- ------------------------------------------------

    function self:isActive()
        return active
    end

    function self:setActive( nactiv )
        active = nactiv
    end

    -- ------------------------------------------------
    -- Callback-stubs
    -- ------------------------------------------------

    self.init = null
    self.close = null
    self.directorydropped = null
    self.draw = null
    self.filedropped = null
    self.focus = null
    self.keypressed = null
    self.keyreleased = null
    self.lowmemory = null
    self.mousefocus = null
    self.mousemoved = null
    self.mousepressed = null
    self.mousereleased = null
    self.quit = null
    self.resize = null
    self.textedited = null
    self.textinput = null
    self.threaderror = null
    self.touchmoved = null
    self.touchpressed = null
    self.touchreleased = null
    self.update = null
    self.visible = null
    self.wheelmoved = null
    self.gamepadaxis = null
    self.gamepadpressed = null
    self.gamepadreleased = null
    self.joystickadded = null
    self.joystickaxis = null
    self.joystickhat = null
    self.joystickpressed = null
    self.joystickreleased = null
    self.joystickremoved = null

    return self
end

-- ------------------------------------------------
-- Return Module
-- ------------------------------------------------

return Screen

--==================================================================================================
-- Created 02.06.14 - 20:25                                                                        =
--==================================================================================================
