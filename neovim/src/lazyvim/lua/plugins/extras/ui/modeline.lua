return {
  { "nvim-lualine/lualine.nvim", enabled = false },
  { "nvim-mini/mini.statusline", enabled = false },
  {
    "nvimdev/modeline.nvim",
    name = "modeline",
    config = function()
      require("modeline").setup()
    end,
  },
}
