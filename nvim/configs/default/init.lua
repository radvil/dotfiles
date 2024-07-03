require("config.lazy").bootstrap({
  dev = {
    path = "~/Projects/linuxdev/neovim",
    fallback = false,
  },
  providers_blacklist = {
    "python3",
    "perl",
    "ruby",
  },
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = function()
          if vim.opt.background:get() == "light" then
            vim.g.neo_transparent = false
          end
          -- vim.cmd.colorscheme("tokyonight")
          vim.cmd.colorscheme("catppuccin")
        end,
        defaults = {
          keymaps = false,
          autocmds = true,
        },
        icons = {
          mason = {
            package_uninstalled = "◍ ",
            package_installed = "",
            package_pending = "",
          },
          diagnostics = {
            Error = " ",
            Warn = " ",
            Hint = " ",
            Info = " ",
          },
          git = {
            added = "",
            removed = "",
            modified = "",
            renamed = "",
            staged = "",
            unstaged = "󰅗",
            untracked = "",
            conflict = "",
            ignored = "",
          },
          kinds = {
            Array = " ",
            Boolean = "󰨙 ",
            Class = " ",
            Color = " ",
            Constant = " ",
            Constructor = " ",
            Enum = " ",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = " ",
            Folder = " ",
            Function = " ",
            -- Interface = " ",
            Interface = " ",
            Key = " ",
            Keyword = " ",
            Method = " ",
            Module = " ",
            Namespace = " ",
            Null = " ",
            Number = "󰎠 ",
            Object = " ",
            Operator = " ",
            Package = " ",
            Property = " ",
            Reference = " ",
            Snippet = " ",
            String = " ",
            Struct = " ",
            Text = " ",
            TypeParameter = " ",
            Unit = " ",
            Value = " ",
            Variable = " ",
            Codeium = " ",
            Copilot = " ",
          },
        },
      },
    },
    { import = "plugins.colorscheme" },
    { import = "plugins.completion" },
    { import = "plugins.editor" },
    { import = "plugins.misc" },
    { import = "plugins.ui" },
    { import = "plugins" },
  },
})
