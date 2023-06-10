---@type LazySpec
local M = {}
local colors = rnv.opt.palette
M[1] = "folke/lsp-colors.nvim"
M.enabled = true
M.opts = {
  Error = colors.red,
  Warning = colors.yellow,
  Information = colors.blue,
  Hint = colors.cyan,
}
return M
