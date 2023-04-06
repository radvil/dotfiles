---@desc nice statusline
---@type LazySpec
local M = {}
M[1] = "nvim-lualine/lualine.nvim"
M.enabled = true
M.dependencies = "arkav/lualine-lsp-progress"
M.opts = require("usr.ui.lualine.rainbow")
return M
