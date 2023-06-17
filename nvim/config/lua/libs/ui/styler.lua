return {
  "folke/styler.nvim",
  config = function()
    require("styler").setup({
      themes = {
        html = { colorscheme = "catppuccin-mocha", background = "dark" },
        help = { colorscheme = "catppuccin-mocha", background = "dark" },
      },
    })
  end,
}
