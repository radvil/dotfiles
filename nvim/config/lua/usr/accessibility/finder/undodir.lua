---@desc undo history
---@type LazySpec
local M = {}
M[1] = "mbbill/undotree"
M.enabled = true
M.keys = {
  {
    "<Leader>U",
    "<Cmd>UndotreeToggle<CR>",
    desc = "undotree » toggle",
  },
}
return M
