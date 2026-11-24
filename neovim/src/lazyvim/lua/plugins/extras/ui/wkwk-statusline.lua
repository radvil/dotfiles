return {
  { "nvim-lualine/lualine.nvim", enabled = false },
  { "nvim-mini/mini.statusline", enabled = false },
  {
    "wkwk-hehe/Wkwk.Statusline",
    name = "Wkwk.Statusline",
    config = function()
      require("wkwk.statusline").setup()
    end,
  },
}
