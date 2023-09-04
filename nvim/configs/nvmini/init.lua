local core = require("minimal")

core.bootstrap(function(opts)
  require("lazy").setup({
    require("lazy"),
    { import = "libs" },
    { import = "lang" },
    { import = "linter" },

    {
      "radvil/NeoVerse",
      ---@type NeoVerseOpts
      opts = {
        dev = false,
        darkmode = true,
        colorscheme = "monokai-pro-octagon",
        transparent = not vim.g.neovide,
        statusline = {
          theme = "auto",
          global = false,
        },
        note_dir = function()
          return vim.fn.expand("~") .. "/Documents/obsidian-vault"
        end,
        snippet_dirs = {
          os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
          os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
        },
        before_config_init = function()
          require("minimal.option")
        end,
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
    -- { "glepnir/dashboard-nvim", enabled = false },
    { "goolord/alpha-nvim", enabled = false },
  }, opts)
end)
