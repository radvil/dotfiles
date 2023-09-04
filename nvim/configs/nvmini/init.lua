local core = require("minimal")

core.bootstrap(function(opts)
  require("minimal.option")

  require("lazy").setup({
    require("lazy"),
    { import = "libs" },
    { import = "lang" },
    { import = "linter" },
    { "radvil/NeoVerse" },
    { import = "neoverse.plugins.completion" },
    { import = "neoverse.plugins.window" },
    { import = "neoverse.plugins.editor" },
    { import = "neoverse.plugins.finder" },
    { import = "neoverse.plugins.ui-ux" },
    { import = "neoverse.plugins.misc" },
    { "echasnovski/mini.indentscope", enabled = false },
  }, opts)

  vim.schedule(function()
    require("minimal.autocmd")
    require("minimal.keymap")
  end)
end)
