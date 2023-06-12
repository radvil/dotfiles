---@desc auto-resize windows on focused
---@type LazySpec
local M = {}
M[1] = "radvil2/windows.nvim"
M.event = "WinNew"

M.dependencies = {
  { "anuvyklack/middleclass" },
  { "anuvyklack/animation.nvim", enabled = true },
}

M.keys = {
  {
    "<Leader>wm",
    ":WindowsMaximize<cr>",
    desc = "Window » maximize/minimize",
  },
  {
    "<Leader>w=",
    ":WindowsEqualize<cr>",
    desc = "Window » set equal size",
  },
  {
    "<Leader>uW",
    ":WindowsToggleAutowidth<cr>",
    desc = "Toggle » window auto width",
  },
}

M.config = function()
  require("windows").setup({
    animation = {
      enable = true,
      duration = 150,
    },
    autowidth = {
      enable = false,
      winwidth = 5,
      filetype = {
        help = 2,
      },
    },
    ignore = {
      buftype = { "quickfix" },
      filetype = require("opt.filetype").popups,
    }
  })
end

return M
