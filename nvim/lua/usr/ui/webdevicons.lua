---@desc better ui icons
---@type LazySpec
local M = {}
M[1] = "nvim-tree/nvim-web-devicons"
M.lazy = false
M.opts = {
  override = require("media.icons").WebDevIcons,
  default = true,
}
return M
