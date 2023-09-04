require("config.lazy").bootstrap({
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    opts = {
      -- colorscheme = "tokyonight",
      colorscheme = function() end,
      defaults = {
        autocmds = true,
        keymaps = false,
      },
    },
  },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.lang.json" },
  -- { import = "libs.editor" },
  -- { import = "libs.theme" },
  -- { import = "libs.misc" },
  -- { import = "libs.test" },
  { import = "libs.lsp" },
  -- { import = "libs.ui" },
  {
    "radvil/NeoVerse",
    ---@type NeoVerseOpts
    opts = {
      transparent = false,
      darkmode = true,
      colorscheme = "tokyonight",
      after_config_init = function()
        require("config.keymaps")
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
})
