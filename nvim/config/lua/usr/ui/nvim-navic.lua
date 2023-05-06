---@type LazySpec
local M = {}
M[1] = "SmiteshP/nvim-navic"
M.enabled = false
M.dependencies = { "neovim/nvim-lspconfig" }
M.opts = {
  icons = require("media.icons").KindIcons,
  depth_limit_indicator = "..",
  safe_output = true,
  highlight = true,
  separator = " ≫ ",
  depth_limit = 9,
}
return M
