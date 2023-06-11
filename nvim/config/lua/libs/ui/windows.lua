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
    "<Cmd>WindowsMaximize<Cr>",
    desc = "Window » Maximize/Minimize",
  },
  {
    "<Leader>w=",
    "<Cmd>WindowsEqualize<Cr>",
    desc = "Window » Set Equal Size",
  },
  {
    "<Leader>wu",
    "<Cmd>WindowsToggleAutowidth<Cr>",
    desc = "Window » Toggle Auto Width",
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
      filetype = require("opt.filetype").excludes,
    }
  })
end
return M
