---@type LazySpec
local M = {}
M[1] = "folke/lsp-colors.nvim"
M.enabled = true
M.opts = function()
  local colors = rnv.opt.palette
  return {
    Error = colors.red,
    Warning = colors.yellow,
    Information = colors.blue,
    Hint = colors.cyan,
  }
end
return M
