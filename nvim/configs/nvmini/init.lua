local core = require("minimal")

core.bootstrap(function(opts)
  require("lazy").setup({
    { import = "lsp" },
    { import = "lang" },
    { import = "linter" },

    {
      "radvil/NeoVerse",
      dev = false,
      ---@type NeoVerseOpts
      opts = {
        darkmode = true,
        colorscheme = function()
          vim.cmd.colorscheme("monokai-pro-octagon")
        end,
        transparent = not vim.g.neovide,
        note_dir = vim.fn.expand("~") .. "/Documents/obsidian-vault",
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
    { "glepnir/dashboard-nvim", enabled = false },
    -- { "goolord/alpha-nvim", enabled = false },
  }, opts)
end)
