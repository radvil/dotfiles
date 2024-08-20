require("core").bootstrap({
  dev = {
    path = "~/Projects/linux",
    fallback = false,
  },
  providers_blacklist = {
    "perl",
    "python3",
    "ruby",
  },
  spec = {
    {
      "radvil/NeoVerse",
      import = "neoverse.core.plugins",
      dev = true,
      ---@type NeoVerseOpts
      opts = {
        colorscheme = function()
          if vim.opt.background:get() == "light" then
            vim.g.neo_transparent = false
          end
          vim.cmd.colorscheme("catppuccin")
        end,
        builtins = {
          keymaps = true,
          autocmds = true,
        },
      },
    },
    { import = "plugins" },
  },
})
