local core = require("minimal")

core.bootstrap(function(opts)
  require("minimal.option")

  require("lazy").setup({
    require("lazy"),
    { import = "libs" },
    { import = "lang" },
    { import = "linter" },
    {
      "radvil/NeoVerse",
      ---@type NeoVerseOpts
      opts = {
        darkmode = true,
        transparent = false,
        colorscheme = "monokai-pro",
        after_config_init = function()
          require("minimal.autocmd")
          require("minimal.keymap")
        end,
      },
    },
    { import = "neoverse.plugins.colorscheme" },
    { import = "neoverse.plugins.completion" },
    { import = "neoverse.plugins.window" },
    { import = "neoverse.plugins.editor" },
    { import = "neoverse.plugins.finder" },
    { import = "neoverse.plugins.ui-ux" },
    { import = "neoverse.plugins.misc" },
    { "echasnovski/mini.indentscope", enabled = false },
    { "gen740/SmoothCursor.nvim", enabled = false },
  }, opts)
end)
