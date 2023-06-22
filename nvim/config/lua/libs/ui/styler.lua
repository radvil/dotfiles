---@type LazySpec
return {
  "folke/styler.nvim",
  enabled = function() return not rnv.opt.transbg end,
  config = function()
    require("styler").setup({
      themes = {
        html = { colorscheme = "catppuccin-mocha", background = "dark" },
        help = { colorscheme = "catppuccin-mocha", background = "dark" },
      },
    })
  end,
}
