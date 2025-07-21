return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = not string.match(vim.g.neo_colorscheme, "rose-pine"),
  opts = {
    ---@type "auto" | "main" | "moon" | "dawn"
    variant = "auto",
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = false,
    styles = {
      bold = true,
      italic = false,
      transparency = false,
    },
    palette = {
      -- Override the builtin palette per variant
      -- moon = {
      --     base = '#18191a',
      --     overlay = '#363738',
      -- },
    },

    highlight_groups = {
      -- Comment = { fg = "foam" },
      -- VertSplit = { fg = "muted", bg = "muted" },
    },
  },
  config = function(_, opts)
    local transparent = vim.g.neo_transparent
    opts.styles.transparency = transparent
    opts.dim_inactive_windows = true
    require("rose-pine").setup(opts)
  end,
}
