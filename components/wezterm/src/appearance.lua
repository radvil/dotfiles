local opts = {}

opts.colors = {
	foreground = "#fcfcfc",
	background = "#202027",
	cursor_bg = "#ff9e64",
	-- cursor_fg = "black",
	cursor_border = "#ff9e64",
	-- selection_fg = "black",
	-- selection_bg = "#fffacd",
	-- scrollbar_thumb = "#222222",
	-- split = "#444444",

	ansi = {
		"#6C6168",
		"#F29BA7",
		"#a8be81",
		"#F3DDA0",
		"#86AACC",
		"#D0B1C8",
		"#C9E4F6",
		"#E3F2FA",
	},

	brights = {
		"#1c1d22",
		"#EA7A95",
		"#a8be81",
		"#eccc81",
		"#5d81ab",
		"#b18eab",
		"#A6C9E5",
		"#FBF1F5",
	},

	-- When the IME, a dead key or a leader key are being processed and are effectively
	-- holding input pending the result of input composition, change the cursor
	-- to this color to give a visual cue about the compose state.
	compose_cursor = "orange",

	-- Colors for copy_mode and quick_select
	-- available since: 20220807-113146-c2fee766
	-- In copy_mode, the color of the active text is:
	-- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
	-- 2. selection_* otherwise
	copy_mode_active_highlight_bg = { Color = "#000000" },
}

opts.color_scheme = 'Catppuccin Macchiato'
opts.window_background_opacity = 0.93
opts.hide_tab_bar_if_only_one_tab = true
opts.tab_bar_at_bottom = true
-- opts.window_background_image = '/path/to/wallpaper.jpg'
opts.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
opts.cursor_blink_ease_in = "Constant"
opts.cursor_blink_ease_out = "Constant"
opts.cursor_blink_rate = 666
opts.force_reverse_video_cursor = false

return {
	setup = function(config)
		for key, value in pairs(opts) do
			config[key] = value
		end
	end,
}
