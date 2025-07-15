return {
  -- disable gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    enabled = false,
  },

  {
    "echasnovski/mini.diff",
    event = "VeryLazy",
    keys = {
      {
        "<leader>go",
        function()
          -- TODO: notify current toggle status
          require("mini.diff").toggle_overlay(0)
        end,
        desc = "Toggle git [o]verlay",
      },
    },
    opts = {
      view = {
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "▎",
        },
      },
    },
  },
}
