require("core").bootstrap(function(opts)
  require("lazy").setup({
    {
      "radvil/NeoVerse",
      import = "neoverse.core.plugins",
      dev = true,
      ---@type NeoVerseOpts
      opts = {
        colorscheme = function()
          vim.cmd.colorscheme("catppuccin")
        end,
        builtins = {
          keymaps = true,
          autocmds = true,
        },
      },
    },
    { import = "plugins" },
  }, opts)
end)
