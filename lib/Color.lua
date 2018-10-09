Color={}
Color.CLEAR = { 0, 0, 0, 0 };
Color.BLACK = { 0, 0, 0, 1 };
Color.BLUE = { 0, 0, 1, 1 };
Color.NAVY = { 0, 0, 128, 1 };
Color.CYAN = { 0, 1, 1, 1 };
Color.TEAL = { 0, 128, 128, 1 };
Color.WHITE = { 1, 1, 1, 1 };
Color.LIGHT_GRAY = { 0xbf, 0xbf, 0xbf, 1 };
Color.GRAY = { 0x7f, 0x7f, 0x7f, 1 };
Color.DARK_GRAY = { 0x3f, 0x3f, 0x3f, 1 };
Color.SLATE = { 0x70, 0x80, 0x90, 1 };
Color.ROYAL = { 0x41, 0x69, 0xe1, 1 };
Color.SKY = { 0x87, 0xce, 0xeb, 1 };
Color.GREEN = { 0x00, 1, 0x00, 1 };
Color.CHARTREUSE = { 0x7f, 1, 0x00, 1 };
Color.LIME = { 0x32, 0xcd, 0x32, 1 };
Color.FOREST = { 0x22, 0x8b, 0x22, 1 };
Color.OLIVE = { 0x6b, 0x8e, 0x23, 1 };
Color.YELLOW = { 1, 1, 0x00, 1 };
Color.GOLD = { 1, 0xd7, 0x00, 1 };
Color.GOLDENROD = { 0xda, 0xa5, 0x20, 1 };
Color.SCARLET = { 1, 0x34, 0x1c, 1 };
Color.BROWN = { 0x8b, 0x45, 0x13, 1 };
Color.TAN = { 0xd2, 0xb4, 0x8c, 1 };
Color.FIREBRICK = { 0xb2, 0x22, 0x22, 1 };
Color.RED = { 1, 0x00, 0x00, 1 };
Color.ORANGE = { 1, 0xa5, 0x00, 1 };
Color.CORAL = { 1, 0x7f, 0x50, 1 };
Color.SALMON = { 0xfa, 0x80, 0x72, 1 };
Color.PINK = { 1, 0x69, 0xb4, 1 };
Color.PURPLE = { 0xa0, 0x20, 0xf0, 1 };
Color.VIOLET = { 0xee, 0x82, 0xee, 1 };
Color.MAROON = { 0xb0, 0x30, 0x60, 1 };
Color.MAGENTA = { 1, 0, 1, 1 };
Color["透明"] = {0, 0, 0, 0};
Color["黑色"] = {0, 0, 0, 1};
Color["白色"] = {1,1,1,1};
Color["浅灰"] = {0xbf/255,0xbf/255,0xbf/255,1};
Color["灰色"] = {0x7f/255,0x7f/255,0x7f/255,1};
Color["深灰"] = {0x3f/255,0x3f/255,0x3f/255,1};
Color["蓝色"] = {0, 0, 1, 1};
Color["深蓝"] = {0,0,128/255,1};
Color["浅蓝"] = {0x41/255,0x69/255,0xe1/255,1};
Color["蓝灰"] = {0x70/255,0x80/255,0x90/255,1};
Color["天蓝"] = {0x87/255,0xce/255,0xeb/255,1};
Color["蓝绿"] = {0, 1, 1, 1};
Color["青色"] = {0,128/255,128/255,1};
Color["绿色"] = {0x00/255,1,0x00/255,1};
Color["黄绿"] = {0x7f/255,1,0x00/255,1};
Color["青柠"] = {0x32/255,0xcd/255,0x32/255,1};
Color["森林"] = {0x22/255,0x8b/255,0x22/255,1};
Color["橄榄"] = {0x6b/255,0x8e/255,0x23/255,1};
Color["黄色"] = {1,1,0,1};
Color["金色"] = {1,0xd7/255,0,1};
Color["橘黄"] = {0xda/255,0xa5/255,0x20/255,1};
Color["橙色"] = {1,0xa5/255,0,1};
Color["棕色"] = {0x8b/255,0x45/255,0x13/255,1};
Color["棕灰"] = {0xd2/255,0xb4/255,0x8c/255,1};
Color["棕红"] = {0xb2/255,0x22/255,0x22/255,1};
Color["红色"] = {1,0,0,1};
Color["浅红"] = {1,0x34/255,0x1c/255,1};
Color["橘红"] = {1,0x7f/255,0x50/255,1};
Color["肉色"] = {0xfa/255,0x80/255,0x72/255,1};
Color["粉红"] = {1,0x69/255,0xb4/255,1};
Color["紫红"] = {0xa0/255,0x20/255,0xf0/255,1};
Color["紫色"] = {0xee/255,0x82/255,0xee/255,1};
Color["蓝紫"] = {0xb0/255,0x30/255,0x60/255,1};
Color["紫褐"] = {1, 0, 1, 1};
-- set color
function setColor(color)
	-- love.graphics.setColor(color["r"],color["g"],color["b"],color["a"])
	love.graphics.setColor(color)
end
-- reset color
function resetColor()
	love.graphics.setColor(Color.WHITE)
end

return Color