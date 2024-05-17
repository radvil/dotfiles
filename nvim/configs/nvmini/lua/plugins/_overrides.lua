---@diagnostic disable: need-check-nil

return {
  { "lukas-reineke/headlines.nvim", enabled = false },
  { "iamcco/markdown-preview.nvim", enabled = false },
  {
    "RRethy/vim-illuminate",
    enabled = false,
  },
  {
    "radvil2/windows.nvim",
    optional = true,
    opts = {
      animation = {
        enable = true,
      },
    },
  },
  {
    "nvim-treesitter-context",
    optional = true,
    opts = {
      enable = vim.g.neovide,
      max_lines = 3,
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["Z"] = { name = "Quit" },
      },
    },
  },
}
