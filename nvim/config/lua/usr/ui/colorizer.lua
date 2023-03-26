---@desc hex colorizing
---@type LazySpec
local M = {}

M[1] = "norcalli/nvim-colorizer.lua"

M.lazy = false

M.opts = {
  ["*"] = {
    names = false,
  },
}

return M
