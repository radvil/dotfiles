---@desc better diagnostics list and others
---@type LazySpec
local M = {}
M[1] = "folke/trouble.nvim"
M.enabled = true
M.cmd = {
  "TroubleToggle",
  "Trouble",
}
M.opts = {
  use_diagnostic_signs = true,
}
M.keys = {
  {
    "<Leader>xd",
    "<Cmd>TroubleToggle document_diagnostics<cr>",
    desc = "Document Diagnostics",
  },
  {
    "<Leader>xw",
    "<Cmd>TroubleToggle workspace_diagnostics<Cr>",
    desc = "Workspace Diagnostics",
  },
}
return M
