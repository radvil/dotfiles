local bgtrans = rnv.opt.transbg
local darkmode = rnv.opt.darkmode
local variant = not darkmode and "day" or rnv.opt.colorvariant or "storm"

---@type LazySpec
local M = {}
M[1] = "folke/tokyonight.nvim"
-- M.lazy = true
M.opts = function()
  local opts = {
    style = variant,
    italic_functions = false,
    terminal_colors = true,
    italic_comments = true,
    italic_keywords = false,
    italic_variables = false,
    transparent = bgtrans,
    hide_inactive_statusline = true,
    transparent_sidebar = bgtrans,
    dark_sidebar = true,
    dark_float = true,
    day_brightness = 0.3,
    lualine_bold = true,
    styles = {
      comments = "italic",
      keywords = "italic",
      functions = "NONE",
      variables = "NONE",
      sidebars = "normal",
      floats = "normal",
    },
    tokyonight_sidebars = require("opt.filetype").sidebars,
  }
  if bgtrans then
    opts.styles.sidebars = "transparent"
    opts.styles.floats = "transparent"
  end
  return opts
end
if rnv.opt.colorscheme == "tokyonight" then
  M.priority = 999
  M.lazy = false
  M.init = function()
    vim.cmd("colorscheme tokyonight")
  end
end
return M
