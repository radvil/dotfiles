---@diagnostic disable: need-check-nil

return {
  {
    "radvil2/windows.nvim",
    optional = true,
    opts = {
      animation = { enable = true },
    },
  },

  {
    "folke/noice.nvim",
    optional = true,
    opts = {
      notify = { enabled = true },
      smartmove = { enabled = true },
      cmdline = {
        enabled = true,
        view = "cmdline",
      },
      popup_menu = {
        enabled = false,
      },
      views = {
        cmdline_popup = {
          position = {
            col = "50%",
            row = "20%",
          },
        },
        virtualtext = {
          hl_group = "FlashCurrent",
        },
      },
    },
  },
}
