---@type LazySpec
local M = {}

M[1] = "radvil2/nvim-tree-lsp-file-operations"

M.enabled = true

M.dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-tree.lua",
}

return M
