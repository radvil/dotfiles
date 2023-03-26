---@desc undo history
---@type LazySpec
local M = {}
M[1] = "mbbill/undotree"
M.enabled = true
M.keys = {
  {
    "<Leader>/u",
    "<Cmd>UndotreeToggle<CR>",
    desc = "Find » Undo(s)",
  },
}
return M
