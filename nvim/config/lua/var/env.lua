local M = {}

M.devmode = false

M.path = {
  home = os.getenv("HOME"),
  cache = os.getenv("HOME") .. "/.cache/nvim",
  data = os.getenv("HOME") .. "/.local/share/nvim",
  config = os.getenv("HOME") .. "/.config/nvim",
}

M.user = {
  name = "Radvil Laode",
  email = "radvil.developer@gmail.com",
  github = "https://github.com/radvil",
  facebook = "https://facebook.com/radvilardian",
}

M.g = {
  mapleader = " ",
  maplocalleader = " ",
}

M.theme = {
  colorscheme = "tokyonight",
  variant = "moon",
  transbg = false,
  force_darkmode = true,
  rainbow_brackets = false,
}

---@class RvimFileExplorerSpec
M.file_explorer = {
  enabled = true,
  ---@type "ranger" | "lf" | "nnn"
  provider = "nnn",
  fix_import_on_file_operations = true,
  sidebar_tree = {
    enabled = true,
    ---@type "nvim-tree" | "neo-tree"
    provider = "nvim-tree",
  },
}

M.symbols = {
  enabled = true,
  wrap = false,
  auto_close = false,
  width = 18,
  position = "right",
  relative_width = false,
  highlight_hovered_item = true,
  keymaps = {
    close = { "<Esc>", "q" },
    goto_location = { "<Cr>", "o" },
    focus_location = "l",
    hover_symbol = "<C-space>",
    toggle_preview = "gh",
    rename_symbol = "gr",
    code_actions = "ga",
    fold = "zc",
    unfold = "zo",
    fold_all = "zC",
    unfold_all = "zO",
    fold_reset = "zU",
  },
}

M.whichkey = {
  enabled = true,
}

M.note_taking = {
  enabled = true,
  workspaces = {
    demo = "~/Documents/neorg-vault/demo",
    ami = "~/Documents/neorg-vault/ami",
  },
}

M.lsp = {
  ---@type RxLspDiagnosticsSpecs
  diagnostics = {
    enabled = true,
    icons = {},
    commands = {
      toggle = "RxToggleDiagnostics",
    },
    keymaps = {
      toggle = "<C-Z>d",
    },
    opts = {},
  },
  formatonsave = {
    enabled = true,
    command = "RxLspToggleFormatonsave",
    toggle_keymap = "<C-z>f",
  },
}

_G.rvim = M
