return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",

  keys = {
    {
      "<Leader>wz",
      "<cmd>ZenMode<cr>",
      desc = "Toggle window zen mode",
    },
    {
      "<Leader><Space>",
      "<cmd>ZenMode<cr>",
      desc = "Toggle window zen mode",
    },
  },

  opts = {
    window = {
      backdrop = 0.90,
      width = 140,
      height = 0.96,
      options = {
        foldcolumn = "0",
        cursorline = false,
        cursorcolumn = false,
        laststatus = 3,
        -- list = true, -- disable whitespace chars
      },
    },
  },
}
