---@type LazySpec
local M = {}
M[1] = "nvim-lualine/lualine.nvim"
M.enabled = function()
  return rnv.opt.statusline
end
M.dependencies = "arkav/lualine-lsp-progress"
M.opts = function()
  return require("libs.ui.lualine.rainbow")
end
return M
