---@type LazySpec[]
return {

  ---@type LazySpec
  {
    "folke/twilight.nvim",
    event = "BufReadPre",
    cmd = { "Twilight", "TwilghtEnable", "TwilightDisable" },
    ---@type TwilightOptions
    opts = {
      exclude = require("common.filetypes").excludes,
      treesitter = true,
      context = 10,
      dimming = {
        alpha = 0.25,
        color = { "Normal", "#ffffff" },
        term_bg = "#000000",
        inactive = true, -- dimm incative windows
      },
      expand = {
        "if_statement",
        "function",
        "method",
        "table",
      },
    },
  },

  ---@type LazySpec
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 0.95,
        width = 120,
        height = 1,
      },
      plugins = {
        twilight = {
          enabled = false,
        },
        gitsigns = {
          enabled = false,
        },
        tmux = {
          enabled = false,
        },
        kitty = {
          enabled = false,
          font = "+4",
        },
        alacritty = {
          enabled = false,
          font = "14",
        },
      },
    },
  },

  ---@type LazySpec
  {
    "radvil/fokus.nvim",
    enabled = false,
    event = "BufReadPre",
    dependencies = { "folke/twilight.nvim", "folke/zen-mode.nvim" },
    keys = {
      {
        "<leader>wf",
        ":ZenMode<cr>",
        desc = "Fokus » Toggle zen mode",
      },
    },
    ---@type FokusOptions
    opts = {
      view = {
        notify_status_change = false,
        blacklists_filetypes = require("common.filetypes").excludes,
        on_fokus_leave = nil,
        on_fokus_enter = nil,
      },
    },
  },
}
