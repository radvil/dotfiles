return {
  { "nvim-lualine/lualine.nvim", enabled = false, },
  { "nvim-mini/mini.statusline", enabled = false },
  {
    "nvimdev/modeline.nvim",
    dev = true,
    config = function()
      require("modeline").setup()
    end,
  },
}
