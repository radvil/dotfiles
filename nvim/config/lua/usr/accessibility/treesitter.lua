---@desc syntax tree hi, hirarchy, etc, etc, ...
---@type LazySpec
local M = {}
M[1] = "nvim-treesitter/nvim-treesitter"
M.event = "BufReadPre"
M.build = ":TSUpdate"
M.keys = {
  {
    "<C-Space>",
    desc = "Increment selection",
  },
  {
    "<Bs>",
    desc = "Shrink selection",
    mode = "x",
  },
}
--- @type TSConfig
M.opts = {
  highlight = {
    additional_vim_regex_highlighting = false,
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "python" },
  },
  fold = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "<C-Space>",
      init_selection = "<C-Space>",
      scope_incremental = "<Nop>",
      node_decremental = "<Bs>",
    },
  },
}
--- @param opts TSConfig
M.config = function(_, opts)
  opts.ensure_installed = require("opt.filetype").treesitter
  require("nvim-treesitter.configs").setup(opts)
end
return M
