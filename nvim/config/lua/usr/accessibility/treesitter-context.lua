---@desc treesitter context
---@type LazySpec
local M = {}
M[1] = "nvim-treesitter/nvim-treesitter-context"
M.event = "BufReadPre"
M.enabled = false -- currently disabling this due to incompatile with hop
M.dependencies = { "nvim-treesitter/nvim-treesitter" }
M.opts = {
  enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
  throttle = true, -- Throttles plugin updates (may improve performance)
  max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
  patterns = {
    -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
    -- For all filetypes
    -- Note that setting an entry here replaces all other patterns for this entry.
    -- By setting the 'default' entry below, you can control which nodes you want to
    -- appear in the context window.
    default = {
      "class",
      "function",
      "method",
    },
  },
}
return M
