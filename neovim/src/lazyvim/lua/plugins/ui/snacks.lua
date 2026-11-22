---@type LazySpec[]
return {
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>.", false },
      { "<leader>n", false },
      { "<leader>S", false },
      { "<leader>dps", false },
    },
    opts = {
      dashboard = require("plugins.ui.opts.snacks-dashboard"),
      words = { enabled = false },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      --animate = { enabled = true, duraton = 1000 },
      --scroll = { enabled = true },
      indent = {
        indent = {
          char = "┊",
          enabled = true,
          only_current = false,
          only_scope = false,
        },
        scope = {
          char = "│",
          enabled = true,
          underline = false,
          only_current = true,
        },
        chunk = {
          enabled = false,
          only_current = false,
          char = {
            -- corner_top = "┌",
            -- corner_bottom = "└",
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
      },
      input = {
        icon = " ",
        icon_hl = "SnacksInputIcon",
        icon_pos = "left",
        prompt_pos = "title",
        win = { style = "input" },
        expand = false,
      },
    },
  },
}
