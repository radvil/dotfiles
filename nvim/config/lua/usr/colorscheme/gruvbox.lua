local env = rvim.theme

---@type LazySpec
local M = {}
M[1] = "ellisonleao/gruvbox.nvim"
-- M.lazy = true
M.opts = function(opts)
  local transbg = rvim.theme.transbg or false
  return vim.tbl_deep_extend("force", {
    -- invert background for search, diffs, statuslines and errors
    inverse = true,
    ---@alias GruvboxVariant "hard" | "soft" | ""
    contrast = rvim.theme.variant or "hard",
    transparent_mode = transbg,
    dim_inactive = not transbg,
    undercurl = true,
    underline = true,
    bold = true,
    italic = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    palette_overrides = {},
    overrides = {},
  }, opts)
end
if env.colorscheme == "gruvbox" then
  M.priority = 999
  M.lazy = false
  M.init = function()
    vim.o.background = rvim.theme.force_darkmode and "dark" or "light"
    vim.cmd([[colorscheme gruvbox]])
  end
end
return M
