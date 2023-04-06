local M = {}
local colors = require("media.colors").palette
M[1] = "folke/lsp-colors.nvim"
M.opts = {
  Error = colors.red,
  Warning = colors.yellow,
  Information = colors.blue,
  Hint = colors.cyan,
}
return M
