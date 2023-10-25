require("core").bootstrap(function(opts)
  require("lazy").setup({
    {
      "radvil/NeoVerse",
      import = "neoverse.core.plugins",
      dev = true,
      ---@type NeoVerseOpts
      opts = {
        darkmode = true,
        builtins = {
          keymaps = true,
          autocmds = true,
        },
        colorscheme = function()
          vim.cmd.colorscheme("catppuccin")
        end,
        note_dir = vim.fn.expand("~") .. "/Documents/obsidian-vault",
        snippet_dirs = {
          os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
          os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
        },
      },
    },
  }, opts)
end)
