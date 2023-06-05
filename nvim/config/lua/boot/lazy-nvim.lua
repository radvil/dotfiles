local M = {}

---@type LazyConfig
M.opts = {
  defaults = {
    lazy = false,
    version = nil,
  },
  checker = {
    enabled = true,
    notify = true,
  },
  change_detection = {
    enabled = true,
    notify = true,
  },
  install = {
    colorscheme = {
      "tokyonight",
      "catppuccin",
    },
  },
  performance = {
    reset_packpath = true, -- reset the package path to improve startup time
    cache = { enabled = false },
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      disabled_plugins = require("opt.filetype").builtin_plugins_excludes,
    },
  },
  ui = {
    border = "rounded",
    title = "Code Nvim",
    title_pos = "center",
    browser = "brave-browser",
    icons = {
      ft = "",
      lazy = "鈴 ",
      loaded = "",
      not_loaded = "",
      cmd = " ",
      config = "",
      event = "",
      init = " ",
      import = " ",
      keys = " ",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = " ",
      list = {
        "",
        "",
        "",
        "‒",
      },
    },
  },
}

function M.setup()
  require("lazy").setup({
    "folke/lazy.nvim",
    require("usr.accessibility"),
    require("usr.colorscheme"),
    require("usr.completion"),
    require("usr._preview"),
    require("usr.misc"),
    require("usr.lsp"),
    require("usr.ui"),
  }, M.opts)
end

return M
