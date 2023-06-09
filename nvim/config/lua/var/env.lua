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
  colorscheme = "catppuccin",
  variant = "mocha",
  transbg = true,
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
    provider = "neo-tree",
  },
}

M.symbols = {
  enabled = false,
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
  enabled = false,
  workspaces = {
    demo = "~/Documents/neorg-vault/demo",
    ami = "~/Documents/neorg-vault/ami",
  },
}

M.statusline = {
  enabled = true,
}

M.lsp = {
  ---@class LspDiagnosticConfig
  diagnostics = {
    enabled = true,
    icons = {},
    commands = {
      toggle = "LspToggleDiagnostics",
    },
    keymaps = {
      toggle = "<C-Z>d",
    },
    opts = {},
  },
  ---@class LspFormatOnSaveConfig
  formatonsave = {
    enabled = true,
    notify = false,
    command = "LspToggleFormatOnSave",
    keymap = "<C-z>f",
  },
}

M.completion = {
  enabled = true,
  enable_snippets = true,
  copilot = {
    enabled = false,
    suggestion_enabled = false,
    panel_enabled = false,
  }
}

_G.rvim = M
