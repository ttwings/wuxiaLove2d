--[[
	public static final Color CLEAR = new Color(0, 0, 0, 0);
	public static final Color BLACK = new Color(0, 0, 0, 1);

	public static final Color WHITE = new Color(0xffffffff);
	public static final Color LIGHT_GRAY = new Color(0xbfbfbfff);
	public static final Color GRAY = new Color(0x7f7f7fff);
	public static final Color DARK_GRAY = new Color(0x3f3f3fff);
	public static final Color SLATE = new Color(0x708090ff);

	public static final Color BLUE = new Color(0, 0, 1, 1);
	public static final Color NAVY = new Color(0, 0, 0.5f, 1);
	public static final Color ROYAL = new Color(0x4169e1ff);
	public static final Color SKY = new Color(0x87ceebff);
	public static final Color CYAN = new Color(0, 1, 1, 1);
	public static final Color TEAL = new Color(0, 0.5f, 0.5f, 1);

	public static final Color GREEN = new Color(0x00ff00ff);
	public static final Color CHARTREUSE = new Color(0x7fff00ff);
	public static final Color LIME = new Color(0x32cd32ff);
	public static final Color FOREST = new Color(0x228b22ff);
	public static final Color OLIVE = new Color(0x6b8e23ff);

	public static final Color YELLOW = new Color(0xffff00ff);
	public static final Color GOLD = new Color(0xffd700ff);
	public static final Color GOLDENROD = new Color(0xdaa520ff);

	public static final Color BROWN = new Color(0x8b4513ff);
	public static final Color TAN = new Color(0xd2b48cff);
	public static final Color FIREBRICK = new Color(0xb22222ff);

	public static final Color RED = new Color(0xff0000ff);
	public static final Color CORAL = new Color(0xff7f50ff);
	public static final Color ORANGE = new Color(0xffa500ff);
	public static final Color SALMON = new Color(0xfa8072ff);
	public static final Color PINK = new Color(0xff69b4ff);
	public static final Color MAGENTA = new Color(1, 0, 1, 1);

	public static final Color PURPLE = new Color(0xa020f0ff);
	public static final Color VIOLET = new Color(0xee82eeff);
	public static final Color MAROON = new Color(0xb03060ff);
]]

colorT={
	["RED"]={255,0,0,255},
	["GREEN"]={0,255,0,255},
	["MAROON"]={0xb0,0x30,0x60,0xff},
	["VIOLET"]={0xee,0x82,0xee,0xff},
	["PURPLE"]={0xA0,0x20,0xf0,0xff},
	["BLUE"]={0xA0,0x20,0xf0,0xff},
}
local color={255,255,255,255}
-- set color
function setColor(color)
	-- love.graphics.setColor(color["r"],color["g"],color["b"],color["a"])
	love.graphics.setColor(color)

end
-- reset color
function resetColor()
	love.graphics.setColor(255, 255, 255, 255)
end

return colorT