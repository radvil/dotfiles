return {
  "tokyonight.nvim",
  config = function()
    local transparent = vim.g.neo_transparent
    return {
      style = "moon",
      lualine_bold = true,
      dim_inactive = false,
      terminal_colors = true,
      transparent = transparent,
      hide_inactive_statusline = true,
      transparent_sidebar = transparent,
      sidebars = {
        "DiffviewFiles",
        "fugitiveblame",
        "NeogitStatus",
        "Dashboard",
        "dashboard",
        "gitcommit",
        "MundoDiff",
        "fugitive",
        "NvimTree",
        "neo-tree",
        "Outline",
        "Trouble",
        "dirbuf",
        "prompt",
        "alpha",
        "Mundo",
        "help",
        "edgy",
        "dbui",
        "qf",
      },
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = transparent and "transparent" or "dark",
        floats = transparent and "transparent" or "dark",
      },
    }
  end,
}
