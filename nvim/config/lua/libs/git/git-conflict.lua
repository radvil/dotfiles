---@type LazySpec
local M = {}
M[1] = "akinsho/git-conflict.nvim"
M.enabled = false
M.opts = {
  default_mappings = false,    -- disable buffer local mapping created by this plugin
  default_commands = true,     -- disable commands created by this plugin
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
    desc = "diagnostics » git conflicts",
  },
  {
    "<Leader>g[",
    "<Cmd>GitConflictPrevConflict<Cr>",
    desc = "git conflict » prev ref",
  },
  {
    "<Leader>g]",
    "<Cmd>GitConflictNextConflict<Cr>",
    desc = "git conflict » next ref",
  },
  {
    "<Leader>go",
    "<Cmd>GitConflictChooseOurs<Cr>",
    desc = "git conflict » choose ours",
  },
  {
    "<Leader>gt",
    "<Cmd>GitConflictChooseTheirs<Cr>",
    desc = "git conflict » choose theirs",
  },
  {
    "<Leader>gb",
    "<Cmd>GitConflictChooseBoth<Cr>",
    desc = "git conflict » choose both",
  },
  {
    "<Leader>g0",
    "<Cmd>GitConflictChooseNone<Cr>",
    desc = "git conflict » choose none",
  },
}
return M
