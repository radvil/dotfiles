require("core").bootstrap(function(opts)
  require("lazy").setup({
    {
      "radvil/NeoVerse",
      import = "neoverse.lsp.core",
      dev = true,
      ---@type NeoVerseOpts
      opts = {
        darkmode = false,
        colorscheme = function()
          local name = vim.g.neovide and "monokai-pro-octagon" or "catppuccin-mocha"
          vim.cmd.colorscheme(name)
        end,
        transparent = not vim.g.neovide,
        note_dir = vim.fn.expand("~") .. "/Documents/obsidian-vault",
        snippet_dirs = {
          os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
          os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
        },
        before_config_init = function()
          require("options")
        end,
        after_config_init = function()
          require("autocmds")
          require("keymaps")
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

    { import = "neoverse.lsp.extras.angular" },
    { import = "neoverse.lsp.extras.golang" },
    { import = "neoverse.lsp.extras.json" },
    { import = "neoverse.lsp.extras.markdown" },
    { import = "neoverse.lsp.extras.typescript" },
    { import = "neoverse.lsp.extras.prettierd" },
    { import = "neoverse.lsp.extras.eslint" },
    -- { import = "neoverse.lsp.extras.docker" },
    -- { import = "neoverse.lsp.extras.rust" },
    -- { import = "neoverse.lsp.extras.tailwind" },

    { "echasnovski/mini.indentscope", enabled = false },
    { "gen740/SmoothCursor.nvim", enabled = false },
    { "smjonas/inc-rename.nvim", enabled = false },
    { "glepnir/dashboard-nvim", enabled = false },
    { "HiPhish/nvim-ts-rainbow2", enabled = false },
    -- { "goolord/alpha-nvim", enabled = false },
  }, opts)
end)
