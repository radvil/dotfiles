---@type LazySpec
local M = {}
M[1] = "tpope/vim-fugitive"
M.enabled = false
M.init = function()
  -- Disable global mappings
  vim.cmd("let g:fugitive_no_maps = 1")
end
return M
