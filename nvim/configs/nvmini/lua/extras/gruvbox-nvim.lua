return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    transparent_mode = vim.g.neo_transparent,
    dim_inactive = not vim.g.neo_transparent,
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_indent_guides = false,
    inverse = true,      -- invert background for search, diffs, statuslines and errors
    contrast = "hard",   -- can be "hard", "soft" or empty string
    italic = {
      strings = true,
      emphasis = true,
      comments = true,
      operators = false,
      folds = true,
    },
    palette_overrides = {},
    overrides = {},
  },
}
