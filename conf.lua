io.stdout:setvbuf("no")

tw = 32
th = 32
sw = 1
sh = 1
gw = 1280
gh = 720
function love.conf(t)
	t.window.title="武侠与江湖"
	t.window.width=gw
	t.window.height=gh
end