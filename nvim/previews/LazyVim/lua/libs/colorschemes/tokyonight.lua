---@type LazySpec
local M = {}
M[1] = "folke/tokyonight.nvim"
M.opts = {
  style = "moon",
  italic_functions = false,
  terminal_colors = true,
  italic_comments = true,
  italic_keywords = false,
  italic_variables = false,
  transparent = true,
  hide_inactive_statusline = true,
  transparent_sidebar = true,
  dark_sidebar = true,
  dark_float = true,
  day_brightness = 0.3,
  lualine_bold = true,
  tokyonight_sidebars = require("common.filetypes").sidebars,
  styles = {
    comments = "italic",
    keywords = "italic",
    functions = "NONE",
    variables = "NONE",
    sidebars = "transparent",
    floats = "transparent",
  },
}
return M
