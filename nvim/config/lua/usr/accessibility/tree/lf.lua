---@type LazySpec
local M = {}
M[1] = "radvil/lf.nvim"
M.dependencies = {
  "akinsho/toggleterm.nvim",
  event = "VimEnter",
  opts = {
    direction = 'float',
    open_mapping = "<C-t>",
    shade_terminals = false,
    winbar = { enabled = false, },
    float_opts = {
      ---@type 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      border = 'curved',
      ---@type number | function
      -- width = <value>,
      -- height = <value>,
      winblend = 3,
    },
  },
}
M.opts = {
  default_cmd = "lr",
  default_action = "edit",
  default_actions = {
        ["<C-t>"] = "tabedit",
        ["<C-x>"] = "split",
        ["<C-v>"] = "vsplit",
        ["<C-o>"] = "tab drop",
  },
  winblend = 10,
  dir = "",                  -- directory where `lf` starts ('gwd' is git-working-directory, "" is CWD)
  direction = "float",
  border = "single",         -- border kind: single double shadow curved
  height = 0.80,             -- height of the *floating* window
  width = 0.85,              -- width of the *floating* window
  escape_quit = true,        -- map escape to the quit command (so it doesn't go into a meta normal mode)
  focus_on_open = true,      -- focus the current file when opening Lf (experimental)
  mappings = true,           -- whether terminal buffer mapping is enabled
  tmux = false,              -- tmux statusline can be disabled on opening of Lf
  layout_mapping = "<C-Up>", -- resize window with this key
}

M.keys = {
  {
    "<Leader><Space>",
    "<Cmd>Lf<Cr>",
    desc = "[📁 File manager] Open float",
  }
}

M.config = function(_, opts)
  opts.views = {
    { width = 0.600, height = 0.600 },
    {
      width = 1.0 * vim.fn.float2nr(vim.fn.round(0.7 * vim.o.columns)) / vim.o.columns,
      height = 1.0 * vim.fn.float2nr(vim.fn.round(0.7 * vim.o.lines)) / vim.o.lines,
    },
    { width = 0.800, height = 0.800 },
    { width = 0.950, height = 0.950 },
  }
  require("lf").setup(opts)
end

return M
