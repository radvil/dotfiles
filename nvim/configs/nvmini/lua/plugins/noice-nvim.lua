---@type LazySpec
return {
  "folke/noice.nvim",
  -- optional = true,
  enabled = function()
    return vim.g.neovide
  end,
  opts = {
    notify = { enabled = true },
    smartmove = { enabled = true },
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
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
}
