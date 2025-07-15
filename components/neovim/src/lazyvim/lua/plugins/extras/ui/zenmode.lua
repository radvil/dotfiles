return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",

  keys = {
    {
      "<Leader>wz",
      "<cmd>ZenMode<cr>",
      desc = "Toggle window zen mode",
    },
  },

  opts = {
    window = {
      backdrop = 0.95,
      width = 130,
      height = 1,
      options = {
        foldcolumn = "0",
        list = true, -- disable whitespace chars
      },
    },
  },
}
