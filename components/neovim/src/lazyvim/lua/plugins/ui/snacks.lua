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
          enabled = true,
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
    },
  },
}
