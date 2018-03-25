-- richtext library

--[[
Copyright (c) 2010 Robin Wellner
Copyright (c) 2014 Florian Fischer (class changes, initial color, ...)

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

   1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.

   2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.

   3. This notice may not be removed or altered from any source
   distribution.
]]

-- issues/bugs:
--  * still under-tested
--  * word wrapping might not be optimal
--  * words keep their final space in wrapping, which may cause words to be wrapped too soon

local rich = {}
rich.__index = rich

function rich:new(t, stdcolor) -- syntax: rt = rich.new{text, width, resource1 = ..., ...}
	local obj = setmetatable({parsedtext = {}, resources = {}}, rich)
	obj.width = t[2]
	obj.hardwrap = false
	obj:extract(t)
	obj:parse(t)
	-- set text standard color
	if stdcolor and type(stdcolor) =='table' then love.graphics.setColor( unpack(stdcolor) ) end
	if love.graphics.isSupported and love.graphics.isSupported('canvas') then
		obj:render()
		obj:render(true)
	end
	return obj
end

function rich:draw(x, y)
	local firstR, firstG, firstB, firstA = love.graphics.getColor()
	love.graphics.setColor(255, 255, 255, 255)
	local prevMode = love.graphics.getBlendMode()
	if self.framebuffer then
		love.graphics.setBlendMode("premultiplied")
		love.graphics.draw(self.framebuffer, x, y)
		love.graphics.setBlendMode(prevMode)
	else
		love.graphics.push()
		love.graphics.translate(x, y)
		self:render()
		love.graphics.pop()
	end
	love.graphics.setColor(firstR, firstG, firstB, firstA)
end

function rich:extract(t)
	if t[3] and type(t[3]) == 'table' then
		for key,value in pairs(t[3]) do
			local meta = type(value) == 'table' and value or {value}
			self.resources[key] = self:initmeta(meta) -- sets default values, does a PO2 fix...
		end
	else
		for key,value in pairs(t) do
			if type(key) == 'string' then
				local meta = type(value) == 'table' and value or {value}
				self.resources[key] = self:initmeta(meta) -- sets default values, does a PO2 fix...
			end
		end
	end
end

local function parsefragment(parsedtext, textfragment)
	-- break up fragments with newlines
	local n = textfragment:find('\n', 1, true)
	while n do
		table.insert(parsedtext, textfragment:sub(1, n-1))
		table.insert(parsedtext, {type='nl'})
		textfragment = textfragment:sub(n + 1)
		n = textfragment:find('\n', 1, true)
	end
	table.insert(parsedtext, textfragment)
end

function rich:parse(t)
	local text = t[1]
	if string.len(text) > 0 then 
		-- look for {tags} or [tags]
		for textfragment, foundtag in text:gmatch'([^{]*){(.-)}' do
			parsefragment(self.parsedtext, textfragment)
			table.insert(self.parsedtext, self.resources[foundtag] or foundtag)
		end
		parsefragment(self.parsedtext, text:match('[^}]+$'))
	end
end

-- [[ since 0.8.0, no autopadding needed any more
local log2 = 1/math.log(2)
local function nextpo2(n)
	return math.pow(2, math.ceil(math.log(n)*log2))
end

local metainit = {}
function metainit.Image(res, meta)
	meta.type = 'img'
	local w, h = res:getWidth(), res:getHeight()
	--[[ since 0.8.0, no autopadding needed any more
	if not rich.nopo2 then
		local neww = nextpo2(w)
		local newh = nextpo2(h)
		if neww ~= w or newh ~= h then
			local padded = love.image.newImageData(wp, hp)
			padded:paste(love.image.newImageData(res), 0, 0)
			meta[1] = love.graphics.newImage(padded)
		end
	end
	]]
	meta.width = meta.width or w
	meta.height = meta.height or h
end
function metainit.Font(res, meta)
	meta.type = 'font'
end
function metainit.number(res, meta)
	meta.type = 'color'
end

function rich:initmeta(meta)
	local res = meta[1]
	local type = (type(res) == 'userdata') and res:type() or type(res)
	if metainit[type] then
		metainit[type](res, meta)
	else
		error("Unsupported type")
	end
	return meta
end

local function wrapText(parsedtext, fragment, lines, maxheight, x, width, i, fnt, hardwrap)
	if not hardwrap or (hardwrap and x > 0) then
		-- find first space, split again later if necessary
		local n = fragment:find(' ', 1, true)
		local lastn = n
		while n do
			local newx = x + fnt:getWidth(fragment:sub(1, n-1))
			if newx > width then
				break
			end
			lastn = n
			n = fragment:find(' ', n + 1, true)
		end
		n = lastn or (#fragment + 1)
		-- wrapping
		parsedtext[i] = fragment:sub(1, n-1)
		table.insert(parsedtext, i+1, fragment:sub((fragment:find('[^ ]', n) or (n+1)) - 1))
		lines[#lines].height = maxheight
		maxheight = 0
		x = 0
		table.insert(lines, {})
	end
	
	return maxheight, 0
end

local function renderText(parsedtext, fragment, lines, maxheight, x, width, i, hardwrap)
	local fnt = love.graphics.getFont() or love.graphics.newFont(12)
	if x + fnt:getWidth(fragment) > width then -- oh oh! split the text
		maxheight, x = wrapText(parsedtext, fragment, lines, maxheight, x, width, i, fnt, hardwrap)
	end

	-- hardwrap long words
	if hardwrap and x + fnt:getWidth(parsedtext[i]) > width then
		local n = #parsedtext[i]
		while x + fnt:getWidth(parsedtext[i]:sub(1, n)) > width do
			n = n - 1
		end
		local p1, p2 = parsedtext[i]:sub(1, n - 1), parsedtext[i]:sub(n)
		parsedtext[i] = p1
		if not parsedtext[i + 1] then
			parsedtext[i + 1] = p2
		elseif type(parsedtext[i + 1]) == 'string' then
			parsedtext[i + 1] = p2 .. parsedtext[i + 1]
		elseif type(parsedtext[i + 1]) == 'table' then
			table.insert(parsedtext, i + 2, p2)
			table.insert(parsedtext, i + 3, {type='nl'})
		end
		lines[#lines].height = maxheight
		maxheight = 0
		x = 0
		table.insert(lines, {})
	end

	local h = math.floor(fnt:getHeight(parsedtext[i]) * fnt:getLineHeight())
	maxheight = math.max(maxheight, h)
	return maxheight, x + fnt:getWidth(parsedtext[i]), {parsedtext[i], x = x > 0 and x or 0, type = 'string', height = h, width = fnt:getWidth(parsedtext[i])}
end

local function renderImage(fragment, lines, maxheight, x, width)
	local newx = x + fragment.width
	if newx > width and x > 0 then -- wrapping
		lines[#lines].height = maxheight
		maxheight = 0
		x = 0
		table.insert(lines, {})
	end
	maxheight = math.max(maxheight, fragment.height)
	return maxheight, newx, {fragment, x = x, type = 'img'}
end

local function doRender(parsedtext, width, hardwrap)
	local x = 0
	local lines = {{}}
	local maxheight = 0
	for i, fragment in ipairs(parsedtext) do -- prepare rendering
		if type(fragment) == 'string' then
			maxheight, x, fragment = renderText(parsedtext, fragment, lines, maxheight, x, width, i, hardwrap)
		elseif fragment.type == 'img' then
			maxheight, x, fragment = renderImage(fragment, lines, maxheight, x, width)
		elseif fragment.type == 'font' then
			love.graphics.setFont(fragment[1])
		elseif fragment.type == 'nl' then
			-- move onto next line, reset x and maxheight
			lines[#lines].height = maxheight
			maxheight = 0
			x = 0
			table.insert(lines, {})
			-- don't want nl inserted into line
			fragment = ''
		end
		table.insert(lines[#lines], fragment)
	end
--~	 for i,f in ipairs(parsedtext) do
--~		 print(f)
--~	 end
	lines[#lines].height = maxheight
	return lines
end

local function doDraw(lines)
	local y = 0
	local colorr,colorg,colorb,colora = love.graphics.getColor()
	for i, line in ipairs(lines) do -- do the actual rendering
		y = y + line.height
		for j, fragment in ipairs(line) do
			if fragment.type == 'string' then
				-- remove leading spaces, but only at the begin of a new line
				-- Note: the check for fragment 2 (j==2) is to avoid a sub for leading line space
				if j==2 and string.sub(fragment[1], 1, 1) == ' ' then
					fragment[1] = string.sub(fragment[1], 2)
				end
				love.graphics.print(fragment[1], fragment.x, y - fragment.height)
				if rich.debug then
					love.graphics.rectangle('line', fragment.x, y - fragment.height, fragment.width, fragment.height)
				end
			elseif fragment.type == 'img' then
				love.graphics.setColor(255,255,255)
				love.graphics.draw(fragment[1][1], fragment.x, y - fragment[1].height)
				if rich.debug then
					love.graphics.rectangle('line', fragment.x, y - fragment[1].height, fragment[1].width, fragment[1].height)
				end
				love.graphics.setColor(colorr,colorg,colorb,colora)
			elseif fragment.type == 'font' then
				love.graphics.setFont(fragment[1])
			elseif fragment.type == 'color' then
				love.graphics.setColor(unpack(fragment))
				colorr,colorg,colorb,colora = love.graphics.getColor()
			end
		end

	end
end

function rich:calcHeight(lines)
	local h = 0
	for _, line in ipairs(lines) do
		h = h + line.height
	end
	return h
end

function rich:render(usefb)
	local renderWidth = self.width or math.huge -- if not given, use no wrapping
	local firstFont = love.graphics.getFont() or love.graphics.newFont(12)
	local firstR, firstG, firstB, firstA = love.graphics.getColor()
	local lines = doRender(self.parsedtext, renderWidth, self.hardwrap)
	-- dirty hack, add half height of last line to bottom of height to ensure tails of y's and g's, etc fit in properly.
	self.height = self:calcHeight(lines) + math.floor((lines[#lines].height / 2) + 0.5)
	local fbWidth = math.max(nextpo2(math.max(love.graphics.getWidth(), self.width or 0)), nextpo2(math.max(love.graphics.getHeight(), self.height)))
	local fbHeight = fbWidth
	love.graphics.setFont(firstFont)
	if usefb then
		self.framebuffer = love.graphics.newCanvas(fbWidth, fbHeight)
		self.framebuffer:setFilter( 'nearest', 'nearest' )
		self.framebuffer:renderTo(function () doDraw(lines) end)
	else
		self.height = doDraw(lines)
	end
	love.graphics.setFont(firstFont)
	love.graphics.setColor(firstR, firstG, firstB, firstA)
end

return rich
