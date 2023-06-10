local opt = {}

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
opt.lsp_formatonsave = true
opt.completion_copilot = false
opt.completion_snippets = true
opt.colorscheme = "tokyonight"
opt.colorvariant = "moon"
opt.data = os.getenv("HOME") .. "/.local/share/nvim/lazy/lazy.nvim"
opt.welcome_header = {
  "                                                ",
  "                   🔥               ⚡⚡        ",
  "         ██╗     █████╗ ██╗   ██╗██╗ Z          ",
  "         ██║    ██╔══██╗██║   ██║██║Z           ",
  "         ██║    ███████║██║   ██║██║            ",
  "         ██║    ██╔══██║╚██╗ ██╔╝██║            ",
  "         ██████╗██║  ██║ ╚████╔╝ ██║            ",
  "         ╚═════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝            ",
  "                                                ",
}
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

return opt
