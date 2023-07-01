local M = {}
local wz = require("wezterm")
if wz.config_builder then
	M = wz.config_builder()
end
M.font = wz.font("JetBrains Mono")
M.automatically_reload_config = true
M.color_scheme = "Adventure"
-- dynamic color_scheme

local function dark_schemes()
	local schemes = wz.get_builtin_color_schemes()
	local dark = {}
	for name, scheme in pairs(schemes) do
		local bg = wz.color.parse(scheme.background)
		local h, s, l, a = bg:hsla()
		if l < 0.4 then
			table.insert(dark, name)
		end
	end
	table.sort(dark)
	return dark
end

local dark = dark_schemes()

wz.on("window-config-reloader", function(win, pane)
	if not win:get_config_overrides() then
		win:set_config_overrides({
			color_scheme = dark[math.random(#dark)],
		})
	end
end)

return M
