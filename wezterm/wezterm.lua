local wz = require("wezterm")

local config = wz.config_builder()

-- fonts related..
config.bold_brightens_ansi_colors = true
config.font_size = 10
config.font = wz.font_with_fallback({
	"JetBrainsMono Nerd Font",
	-- "JetBrains Mono",
})

-- keyboard & mouse specifics
config.use_dead_keys = false
config.disable_default_key_bindings = true
config.disable_default_mouse_bindings = true
config.keys = {
	{
		key = "F5",
		mods = "CMD|SHIFT",
		action = wz.action.ReloadConfiguration,
	},
	{
		key = "F6",
		mods = "CTRL",
		action = wz.action.ShowDebugOverlay,
	},
	{
		key = "0",
		mods = "CTRL",
		action = wz.action.ResetFontAndWindowSize,
	},
	{
		key = "P",
		mods = "CTRL",
		action = wz.action.ActivateCommandPalette,
	},
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = wz.action.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wz.action.PasteFrom("Clipboard"),
	},
}

require("appearance").setup(config)

return config
