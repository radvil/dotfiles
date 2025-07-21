return {
  "sphamba/smear-cursor.nvim",
  opts = {
    cursor_color = "#d3cdc3",
    normal_bg = "#282828",
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    use_floating_windows = false,
    legacy_computing_symbols_support = true,
    hide_target_hack = false,

    stiffness = 0.8,               -- 0.6      [0, 1]
    trailing_stiffness = 0.6,      -- 0.3      [0, 1]
    trailing_exponent = 0,         -- 0.1      >= 0
    distance_stop_animating = 0.5, -- 0.1      > 0
  },
}
