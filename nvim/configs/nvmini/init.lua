require("core").bootstrap({
  dev = {
    path = "~/Projects/linuxdev/neovim",
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
          vim.cmd.colorscheme("catppuccin-frappe")
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
