---@class love.keyboard
---Provides an interface to the user's keyboard.
local m = {}

---All the keys you can press. Note that some keys may not be available on your keyboard or system.
KeyConstant = {
	---The A key
	['a'] = 1,
	---The B key
	['b'] = 2,
	---The C key
	['c'] = 3,
	---The D key
	['d'] = 4,
	---The E key
	['e'] = 5,
	---The F key
	['f'] = 6,
	---The G key
	['g'] = 7,
	---The H key
	['h'] = 8,
	---The I key
	['i'] = 9,
	---The J key
	['j'] = 10,
	---The K key
	['k'] = 11,
	---The L key
	['l'] = 12,
	---The M key
	['m'] = 13,
	---The N key
	['n'] = 14,
	---The O key
	['o'] = 15,
	---The P key
	['p'] = 16,
	---The Q key
	['q'] = 17,
	---The R key
	['r'] = 18,
	---The S key
	['s'] = 19,
	---The T key
	['t'] = 20,
	---The U key
	['u'] = 21,
	---The V key
	['v'] = 22,
	---The W key
	['w'] = 23,
	---The X key
	['x'] = 24,
	---The Y key
	['y'] = 25,
	---The Z key
	['z'] = 26,
	---The zero key
	['0'] = 27,
	---The one key
	['1'] = 28,
	---The two key
	['2'] = 29,
	---The three key
	['3'] = 30,
	---The four key
	['4'] = 31,
	---The five key
	['5'] = 32,
	---The six key
	['6'] = 33,
	---The seven key
	['7'] = 34,
	---The eight key
	['8'] = 35,
	---The nine key
	['9'] = 36,
	---Space key
	['space'] = 37,
	---Exclamation mark key
	['!'] = 38,
	---Double quote key
	['"'] = 39,
	---Hash key
	['#'] = 40,
	---Dollar key
	['$'] = 41,
	---Ampersand key
	['&'] = 42,
	---Single quote key
	['\''] = 43,
	---Left parenthesis key
	['('] = 44,
	---Right parenthesis key
	[')'] = 45,
	---Asterisk key
	['*'] = 46,
	---Plus key
	['+'] = 47,
	---Comma key
	[','] = 48,
	---Hyphen-minus key
	['-'] = 49,
	---Full stop key
	['.'] = 50,
	---Slash key
	['/'] = 51,
	---Colon key
	[':'] = 52,
	---Semicolon key
	[';'] = 53,
	---Less-than key
	['<'] = 54,
	---Equal key
	['='] = 55,
	---Greater-than key
	['>'] = 56,
	---Question mark key
	['?'] = 57,
	---At sign key
	['@'] = 58,
	---Left square bracket key
	['['] = 59,
	---Backslash key
	['\\'] = 60,
	---Right square bracket key
	[']'] = 61,
	---Caret key
	['^'] = 62,
	---Underscore key
	['_'] = 63,
	---Grave accent key
	['`'] = 64,
	---The numpad zero key
	['kp0'] = 65,
	---The numpad one key
	['kp1'] = 66,
	---The numpad two key
	['kp2'] = 67,
	---The numpad three key
	['kp3'] = 68,
	---The numpad four key
	['kp4'] = 69,
	---The numpad five key
	['kp5'] = 70,
	---The numpad six key
	['kp6'] = 71,
	---The numpad seven key
	['kp7'] = 72,
	---The numpad eight key
	['kp8'] = 73,
	---The numpad nine key
	['kp9'] = 74,
	---The numpad decimal point key
	['kp.'] = 75,
	---The numpad division key
	['kp/'] = 76,
	---The numpad multiplication key
	['kp*'] = 77,
	---The numpad substraction key
	['kp-'] = 78,
	---The numpad addition key
	['kp+'] = 79,
	---The numpad enter key
	['kpenter'] = 80,
	---The numpad equals key
	['kp='] = 81,
	---Up cursor key
	['up'] = 82,
	---Down cursor key
	['down'] = 83,
	---Right cursor key
	['right'] = 84,
	---Left cursor key
	['left'] = 85,
	---Home key
	['home'] = 86,
	---End key
	['end'] = 87,
	---Page up key
	['pageup'] = 88,
	---Page down key
	['pagedown'] = 89,
	---Insert key
	['insert'] = 90,
	---Backspace key
	['backspace'] = 91,
	---Tab key
	['tab'] = 92,
	---Clear key
	['clear'] = 93,
	---Return key
	['return'] = 94,
	---Delete key
	['delete'] = 95,
	---The 1st function key
	['f1'] = 96,
	---The 2nd function key
	['f2'] = 97,
	---The 3rd function key
	['f3'] = 98,
	---The 4th function key
	['f4'] = 99,
	---The 5th function key
	['f5'] = 100,
	---The 6th function key
	['f6'] = 101,
	---The 7th function key
	['f7'] = 102,
	---The 8th function key
	['f8'] = 103,
	---The 9th function key
	['f9'] = 104,
	---The 10th function key
	['f10'] = 105,
	---The 11th function key
	['f11'] = 106,
	---The 12th function key
	['f12'] = 107,
	---The 13th function key
	['f13'] = 108,
	---The 14th function key
	['f14'] = 109,
	---The 15th function key
	['f15'] = 110,
	---Num-lock key
	['numlock'] = 111,
	---Caps-lock key
	['capslock'] = 112,
	---Scroll-lock key
	['scrollock'] = 113,
	---Right shift key
	['rshift'] = 114,
	---Left shift key
	['lshift'] = 115,
	---Right control key
	['rctrl'] = 116,
	---Left control key
	['lctrl'] = 117,
	---Right alt key
	['ralt'] = 118,
	---Left alt key
	['lalt'] = 119,
	---Right meta key
	['rmeta'] = 120,
	---Left meta key
	['lmeta'] = 121,
	---Left super key
	['lsuper'] = 122,
	---Right super key
	['rsuper'] = 123,
	---Mode key
	['mode'] = 124,
	---Compose key
	['compose'] = 125,
	---Pause key
	['pause'] = 126,
	---Escape key
	['escape'] = 127,
	---Help key
	['help'] = 128,
	---Print key
	['print'] = 129,
	---System request key
	['sysreq'] = 130,
	---Break key
	['break'] = 131,
	---Menu key
	['menu'] = 132,
	---Power key
	['power'] = 133,
	---Euro (&euro;) key
	['euro'] = 134,
	---Undo key
	['undo'] = 135,
	---WWW key
	['www'] = 136,
	---Mail key
	['mail'] = 137,
	---Calculator key
	['calculator'] = 138,
	---Application search key
	['appsearch'] = 139,
	---Application home key
	['apphome'] = 140,
	---Application back key
	['appback'] = 141,
	---Application forward key
	['appforward'] = 142,
	---Application refresh key
	['apprefresh'] = 143,
	---Application bookmarks key
	['appbookmarks'] = 144,
}
---Keyboard scancodes.
---
---Scancodes are keyboard layout-independent, so the scancode "w" will be generated if the key in the same place as the "w" key on an American QWERTY keyboard is pressed, no matter what the key is labelled or what the user's operating system settings are.
---
---Using scancodes, rather than keycodes, is useful because keyboards with layouts differing from the US/UK layout(s) might have keys that generate 'unknown' keycodes, but the scancodes will still be detected. This however would necessitate having a list for each keyboard layout one would choose to support.
---
---One could use textinput or textedited instead, but those only give back the end result of keys used, i.e. you can't get modifiers on their own from it, only the final symbols that were generated.
Scancode = {
	---The 'A' key on an American layout.
	['a'] = 1,
	---The 'B' key on an American layout.
	['b'] = 2,
	---The 'C' key on an American layout.
	['c'] = 3,
	---The 'D' key on an American layout.
	['d'] = 4,
	---The 'E' key on an American layout.
	['e'] = 5,
	---The 'F' key on an American layout.
	['f'] = 6,
	---The 'G' key on an American layout.
	['g'] = 7,
	---The 'H' key on an American layout.
	['h'] = 8,
	---The 'I' key on an American layout.
	['i'] = 9,
	---The 'J' key on an American layout.
	['j'] = 10,
	---The 'K' key on an American layout.
	['k'] = 11,
	---The 'L' key on an American layout.
	['l'] = 12,
	---The 'M' key on an American layout.
	['m'] = 13,
	---The 'N' key on an American layout.
	['n'] = 14,
	---The 'O' key on an American layout.
	['o'] = 15,
	---The 'P' key on an American layout.
	['p'] = 16,
	---The 'Q' key on an American layout.
	['q'] = 17,
	---The 'R' key on an American layout.
	['r'] = 18,
	---The 'S' key on an American layout.
	['s'] = 19,
	---The 'T' key on an American layout.
	['t'] = 20,
	---The 'U' key on an American layout.
	['u'] = 21,
	---The 'V' key on an American layout.
	['v'] = 22,
	---The 'W' key on an American layout.
	['w'] = 23,
	---The 'X' key on an American layout.
	['x'] = 24,
	---The 'Y' key on an American layout.
	['y'] = 25,
	---The 'Z' key on an American layout.
	['z'] = 26,
	---The '1' key on an American layout.
	['1'] = 27,
	---The '2' key on an American layout.
	['2'] = 28,
	---The '3' key on an American layout.
	['3'] = 29,
	---The '4' key on an American layout.
	['4'] = 30,
	---The '5' key on an American layout.
	['5'] = 31,
	---The '6' key on an American layout.
	['6'] = 32,
	---The '7' key on an American layout.
	['7'] = 33,
	---The '8' key on an American layout.
	['8'] = 34,
	---The '9' key on an American layout.
	['9'] = 35,
	---The '0' key on an American layout.
	['0'] = 36,
	---The 'return' / 'enter' key on an American layout.
	['return'] = 37,
	---The 'escape' key on an American layout.
	['escape'] = 38,
	---The 'backspace' key on an American layout.
	['backspace'] = 39,
	---The 'tab' key on an American layout.
	['tab'] = 40,
	---The spacebar on an American layout.
	['space'] = 41,
	---The minus key on an American layout.
	['-'] = 42,
	---The equals key on an American layout.
	['='] = 43,
	---The left-bracket key on an American layout.
	['['] = 44,
	---The right-bracket key on an American layout.
	[']'] = 45,
	---The backslash key on an American layout.
	['\\'] = 46,
	---The non-U.S. hash scancode.
	['nonus#'] = 47,
	---The semicolon key on an American layout.
	[';'] = 48,
	---The apostrophe key on an American layout.
	['\''] = 49,
	---The back-tick / grave key on an American layout.
	['`'] = 50,
	---The comma key on an American layout.
	[','] = 51,
	---The period key on an American layout.
	['.'] = 52,
	---The forward-slash key on an American layout.
	['/'] = 53,
	---The capslock key on an American layout.
	['capslock'] = 54,
	---The F1 key on an American layout.
	['f1'] = 55,
	---The F2 key on an American layout.
	['f2'] = 56,
	---The F3 key on an American layout.
	['f3'] = 57,
	---The F4 key on an American layout.
	['f4'] = 58,
	---The F5 key on an American layout.
	['f5'] = 59,
	---The F6 key on an American layout.
	['f6'] = 60,
	---The F7 key on an American layout.
	['f7'] = 61,
	---The F8 key on an American layout.
	['f8'] = 62,
	---The F9 key on an American layout.
	['f9'] = 63,
	---The F10 key on an American layout.
	['f10'] = 64,
	---The F11 key on an American layout.
	['f11'] = 65,
	---The F12 key on an American layout.
	['f12'] = 66,
	---The F13 key on an American layout.
	['f13'] = 67,
	---The F14 key on an American layout.
	['f14'] = 68,
	---The F15 key on an American layout.
	['f15'] = 69,
	---The F16 key on an American layout.
	['f16'] = 70,
	---The F17 key on an American layout.
	['f17'] = 71,
	---The F18 key on an American layout.
	['f18'] = 72,
	---The F19 key on an American layout.
	['f19'] = 73,
	---The F20 key on an American layout.
	['f20'] = 74,
	---The F21 key on an American layout.
	['f21'] = 75,
	---The F22 key on an American layout.
	['f22'] = 76,
	---The F23 key on an American layout.
	['f23'] = 77,
	---The F24 key on an American layout.
	['f24'] = 78,
	---The left control key on an American layout.
	['lctrl'] = 79,
	---The left shift key on an American layout.
	['lshift'] = 80,
	---The left alt / option key on an American layout.
	['lalt'] = 81,
	---The left GUI (command / windows / super) key on an American layout.
	['lgui'] = 82,
	---The right control key on an American layout.
	['rctrl'] = 83,
	---The right shift key on an American layout.
	['rshift'] = 84,
	---The right alt / option key on an American layout.
	['ralt'] = 85,
	---The right GUI (command / windows / super) key on an American layout.
	['rgui'] = 86,
	---The printscreen key on an American layout.
	['printscreen'] = 87,
	---The scroll-lock key on an American layout.
	['scrolllock'] = 88,
	---The pause key on an American layout.
	['pause'] = 89,
	---The insert key on an American layout.
	['insert'] = 90,
	---The home key on an American layout.
	['home'] = 91,
	---The numlock / clear key on an American layout.
	['numlock'] = 92,
	---The page-up key on an American layout.
	['pageup'] = 93,
	---The forward-delete key on an American layout.
	['delete'] = 94,
	---The end key on an American layout.
	['end'] = 95,
	---The page-down key on an American layout.
	['pagedown'] = 96,
	---The right-arrow key on an American layout.
	['right'] = 97,
	---The left-arrow key on an American layout.
	['left'] = 98,
	---The down-arrow key on an American layout.
	['down'] = 99,
	---The up-arrow key on an American layout.
	['up'] = 100,
	---The non-U.S. backslash scancode.
	['nonusbackslash'] = 101,
	---The application key on an American layout. Windows contextual menu, compose key.
	['application'] = 102,
	---The 'execute' key on an American layout.
	['execute'] = 103,
	---The 'help' key on an American layout.
	['help'] = 104,
	---The 'menu' key on an American layout.
	['menu'] = 105,
	---The 'select' key on an American layout.
	['select'] = 106,
	---The 'stop' key on an American layout.
	['stop'] = 107,
	---The 'again' key on an American layout.
	['again'] = 108,
	---The 'undo' key on an American layout.
	['undo'] = 109,
	---The 'cut' key on an American layout.
	['cut'] = 110,
	---The 'copy' key on an American layout.
	['copy'] = 111,
	---The 'paste' key on an American layout.
	['paste'] = 112,
	---The 'find' key on an American layout.
	['find'] = 113,
	---The keypad forward-slash key on an American layout.
	['kp/'] = 114,
	---The keypad '*' key on an American layout.
	['kp*'] = 115,
	---The keypad minus key on an American layout.
	['kp-'] = 116,
	---The keypad plus key on an American layout.
	['kp+'] = 117,
	---The keypad equals key on an American layout.
	['kp='] = 118,
	---The keypad enter key on an American layout.
	['kpenter'] = 119,
	---The keypad '1' key on an American layout.
	['kp1'] = 120,
	---The keypad '2' key on an American layout.
	['kp2'] = 121,
	---The keypad '3' key on an American layout.
	['kp3'] = 122,
	---The keypad '4' key on an American layout.
	['kp4'] = 123,
	---The keypad '5' key on an American layout.
	['kp5'] = 124,
	---The keypad '6' key on an American layout.
	['kp6'] = 125,
	---The keypad '7' key on an American layout.
	['kp7'] = 126,
	---The keypad '8' key on an American layout.
	['kp8'] = 127,
	---The keypad '9' key on an American layout.
	['kp9'] = 128,
	---The keypad '0' key on an American layout.
	['kp0'] = 129,
	---The keypad period key on an American layout.
	['kp.'] = 130,
	---The 1st international key on an American layout. Used on Asian keyboards.
	['international1'] = 131,
	---The 2nd international key on an American layout.
	['international2'] = 132,
	---The 3rd international key on an American layout. Yen.
	['international3'] = 133,
	---The 4th international key on an American layout.
	['international4'] = 134,
	---The 5th international key on an American layout.
	['international5'] = 135,
	---The 6th international key on an American layout.
	['international6'] = 136,
	---The 7th international key on an American layout.
	['international7'] = 137,
	---The 8th international key on an American layout.
	['international8'] = 138,
	---The 9th international key on an American layout.
	['international9'] = 139,
	---Hangul/English toggle scancode.
	['lang1'] = 140,
	---Hanja conversion scancode.
	['lang2'] = 141,
	---Katakana scancode.
	['lang3'] = 142,
	---Hiragana scancode.
	['lang4'] = 143,
	---Zenkaku/Hankaku scancode.
	['lang5'] = 144,
	---The mute key on an American layout.
	['mute'] = 145,
	---The volume up key on an American layout.
	['volumeup'] = 146,
	---The volume down key on an American layout.
	['volumedown'] = 147,
	---The audio next track key on an American layout.
	['audionext'] = 148,
	---The audio previous track key on an American layout.
	['audioprev'] = 149,
	---The audio stop key on an American layout.
	['audiostop'] = 150,
	---The audio play key on an American layout.
	['audioplay'] = 151,
	---The audio mute key on an American layout.
	['audiomute'] = 152,
	---The media select key on an American layout.
	['mediaselect'] = 153,
	---The 'WWW' key on an American layout.
	['www'] = 154,
	---The Mail key on an American layout.
	['mail'] = 155,
	---The calculator key on an American layout.
	['calculator'] = 156,
	---The 'computer' key on an American layout.
	['computer'] = 157,
	---The AC Search key on an American layout.
	['acsearch'] = 158,
	---The AC Home key on an American layout.
	['achome'] = 159,
	---The AC Back key on an American layout.
	['acback'] = 160,
	---The AC Forward key on an American layout.
	['acforward'] = 161,
	---Th AC Stop key on an American layout.
	['acstop'] = 162,
	---The AC Refresh key on an American layout.
	['acrefresh'] = 163,
	---The AC Bookmarks key on an American layout.
	['acbookmarks'] = 164,
	---The system power scancode.
	['power'] = 165,
	---The brightness-down scancode.
	['brightnessdown'] = 166,
	---The brightness-up scancode.
	['brightnessup'] = 167,
	---The display switch scancode.
	['displayswitch'] = 168,
	---The keyboard illumination toggle scancode.
	['kbdillumtoggle'] = 169,
	---The keyboard illumination down scancode.
	['kbdillumdown'] = 170,
	---The keyboard illumination up scancode.
	['kbdillumup'] = 171,
	---The eject scancode.
	['eject'] = 172,
	---The system sleep scancode.
	['sleep'] = 173,
	---The alt-erase key on an American layout.
	['alterase'] = 174,
	---The sysreq key on an American layout.
	['sysreq'] = 175,
	---The 'cancel' key on an American layout.
	['cancel'] = 176,
	---The 'clear' key on an American layout.
	['clear'] = 177,
	---The 'prior' key on an American layout.
	['prior'] = 178,
	---The 'return2' key on an American layout.
	['return2'] = 179,
	---The 'separator' key on an American layout.
	['separator'] = 180,
	---The 'out' key on an American layout.
	['out'] = 181,
	---The 'oper' key on an American layout.
	['oper'] = 182,
	---The 'clearagain' key on an American layout.
	['clearagain'] = 183,
	---The 'crsel' key on an American layout.
	['crsel'] = 184,
	---The 'exsel' key on an American layout.
	['exsel'] = 185,
	---The keypad 00 key on an American layout.
	['kp00'] = 186,
	---The keypad 000 key on an American layout.
	['kp000'] = 187,
	---The thousands-separator key on an American layout.
	['thsousandsseparator'] = 188,
	---The decimal separator key on an American layout.
	['decimalseparator'] = 189,
	---The currency unit key on an American layout.
	['currencyunit'] = 190,
	---The currency sub-unit key on an American layout.
	['currencysubunit'] = 191,
	---The 'app1' scancode.
	['app1'] = 192,
	---The 'app2' scancode.
	['app2'] = 193,
	---An unknown key.
	['unknown'] = 194,
}
---Gets the key corresponding to the given hardware scancode.
---
---Unlike key constants, Scancodes are keyboard layout-independent. For example the scancode "w" will be generated if the key in the same place as the "w" key on an American keyboard is pressed, no matter what the key is labelled or what the user's operating system settings are.
---
---Scancodes are useful for creating default controls that have the same physical locations on on all systems.
---@param scancode Scancode @The scancode to get the key from.
---@return KeyConstant
function m.getKeyFromScancode(scancode) end

---Gets the hardware scancode corresponding to the given key.
---
---Unlike key constants, Scancodes are keyboard layout-independent. For example the scancode "w" will be generated if the key in the same place as the "w" key on an American keyboard is pressed, no matter what the key is labelled or what the user's operating system settings are.
---
---Scancodes are useful for creating default controls that have the same physical locations on on all systems.
---@param key KeyConstant @The key to get the scancode from.
---@return Scancode
function m.getScancodeFromKey(key) end

---Gets whether key repeat is enabled.
---@return boolean
function m.hasKeyRepeat() end

---Gets whether text input events are enabled.
---@return boolean
function m.hasTextInput() end

---Checks whether a certain key is down. Not to be confused with love.keypressed or love.keyreleased.
---@param key KeyConstant @The key to check.
---@return boolean
---@overload fun(key:KeyConstant, ...:KeyConstant):boolean
function m.isDown(key) end

---Checks whether the specified Scancodes are pressed. Not to be confused with love.keypressed or love.keyreleased.
---
---Unlike regular KeyConstants, Scancodes are keyboard layout-independent. The scancode "w" is used if the key in the same place as the "w" key on an American keyboard is pressed, no matter what the key is labelled or what the user's operating system settings are.
---@param scancode Scancode @A Scancode to check.
---@param ... Scancode @Additional Scancodes to check.
---@return boolean
function m.isScancodeDown(scancode, ...) end

---Enables or disables key repeat. It is disabled by default.
---
---The interval between repeats depends on the user's system settings.
---@param enable boolean @Whether repeat keypress events should be enabled when a key is held down.
function m.setKeyRepeat(enable) end

---Enables or disables text input events. It is enabled by default on Windows, Mac, and Linux, and disabled by default on iOS and Android.
---@param enable boolean @Whether text input events should be enabled.
---@overload fun(enable:boolean, x:number, y:number, w:number, h:number):void
function m.setTextInput(enable) end

return m