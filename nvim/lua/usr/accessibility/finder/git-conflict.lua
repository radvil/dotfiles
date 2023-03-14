---@type LazySpec
local M = {}
M[1] = "akinsho/git-conflict.nvim"
M.opts = {
  default_mappings = false, -- disable buffer local mapping created by this plugin
  default_commands = true, -- disable commands created by this plugin
  disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  -- They must have background color, otherwise the default color will be used
  highlights = {
    incoming = "DiffText",
    current = "DiffAdd",
  },
}
M.keys = {
  {
    "<Leader>xg",
    "<Cmd>GitConflictListQf<Cr>",
    desc = "Git Conflicts",
  },
  {
    "<Leader>g[",
    "<Cmd>GitConflictPrevConflict<Cr>",
    desc = " Git Conflict » Prev Ref",
  },
  {
    "<Leader>g]",
    "<Cmd>GitConflictNextConflict<Cr>",
    desc = " Git Conflict » Next Ref",
  },
  {
    "<Leader>go",
    "<Cmd>GitConflictChooseOurs<Cr>",
    desc = " Git Conflict » Choose Ours",
  },
  {
    "<Leader>gt",
    "<Cmd>GitConflictChooseTheirs<Cr>",
    desc = " Git Conflict » Choose Theirs",
  },
  {
    "<Leader>gb",
    "<Cmd>GitConflictChooseBoth<Cr>",
    desc = " Git Conflict » Choose Both",
  },
  {
    "<Leader>g0",
    "<Cmd>GitConflictChooseNone<Cr>",
    desc = " Git Conflict » Choose None",
  },
}
return M
