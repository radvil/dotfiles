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
    desc = "Window » Maximize/minimize",
  },
  {
    "<Leader>w=",
    ":WindowsEqualize<cr>",
    desc = "Window » Set equal size",
  },
  {
    "<Leader>uW",
    ":WindowsToggleAutowidth<cr>",
    desc = "Toggle » Window auto width",
  },
}

M.config = function()
  require("windows").setup({
    animation = {
      enable = false,
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
      buftype = { "quickfix", "edgy" },
      filetype = require("opt.filetype").excludes,
    }
  })
end

return M
