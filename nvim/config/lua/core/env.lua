---@class RnvOptions
local opt = {}

opt.name = "NgVim"
opt.version = ">= 0.0.1"
opt.dev = false
opt.transbg = true
opt.mapleader = " "
opt.darkmode = true
---@type "neotree" | "nvim-tree"
opt.tree = "neotree"
opt.whichkey = true
opt.statusline = true
opt.completion = true
opt.maplocalleader = " "
opt.lsp_diagnostics = true
opt.lsp_autoformat = true
opt.format_notification = false
opt.completion_copilot = false
opt.completion_snippets = true
opt.colorscheme = "tokyonight"
opt.colorvariant = "moon"
opt.data = os.getenv("HOME") .. "/.local/share/nvim/lazy/lazy.nvim"

---@type "dashboard" | "mini-starter" | "alpha-nvim"
opt.starter_name = "alpha-nvim"
opt.starter_logo = [[

      ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗   Z
      ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║ Z
      ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║
      ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
      ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

opt.palette = {
  bg = "#1A1B23",
  fg = "#ffffff",
  blue = "#51AFEF",
  cyan = "#8AD3C8",
  darkblue = "#081633",
  green = "#6DD390",
  magenta = "#C678DD",
  orange = "#FF855A",
  red = "#EC5F67",
  pink = "#E76EB1",
  violet = "#A9A1E1",
  yellow = "#ECBE7B",
}

---@type LazyConfig
opt.lazy_config = {
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
    cache = { enabled = true },
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      paths = {},   -- add any custom paths here that you want to includes in the rtp
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

return opt
