---@type LazySpec
local M = {}
M[1] = "windwp/nvim-autopairs"
M.opts = {
  disable_filetype = require("opt.filetype").excludes,
  disable_in_visualblock = true, -- on insert after visual block
}
return M
