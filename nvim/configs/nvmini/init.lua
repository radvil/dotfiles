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
          if vim.opt.background:get() == "light" then
            vim.g.neo_transparent = false
          end
          -- vim.cmd.colorscheme("catppuccin")
          vim.cmd.colorscheme("tokyonight")
          -- vim.print("config", vim.g.neo_transparent)
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
