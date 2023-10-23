local ft_windows = {
  "NeogitStatus",
  "prompt",
  "Dashboard",
  "dashboard",
  "alpha",
  "help",
  "dbui",
  "DiffviewFiles",
  "Mundo",
  "MundoDiff",
  "NvimTree",
  "neo-tree",
  "Outline",
  "edgy",
  "dirbuf",
  "qf",
  "fugitive",
  "fugitiveblame",
  "gitcommit",
  "Trouble",
}

return {
  "folke/tokyonight.nvim",
  priority = 999,
  lazy = false,
  config = function(_, opts)
    local Prefer = require("preferences")

    opts = vim.tbl_deep_extend("force", opts or {}, {
      style = "day",
      lualine_bold = true,
      dim_inactive = false,
      sidebars = ft_windows,
      terminal_colors = true,
      hide_inactive_statusline = true,
      transparent = Prefer.transparent,
      transparent_sidebar = Prefer.transparent,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
      },
      -- on_colors = function(colors)
      --   if not Config.transparent then
      --     colors.border = "#12131D"
      --   else
      --     colors.border = Config.palette.yellow
      --   end
      -- end,
    })

    if Prefer.transparent then
      opts.styles.sidebars = "transparent"
      opts.styles.floats = "transparent"
    end

    require("tokyonight").setup(opts)
  end,
}
