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
    desc = "CURRENT » Maximize/Minimize",
  },
  {
    "<Leader>w=",
    "<Cmd>WindowsEqualize<Cr>",
    desc = "ALL » Set Equal Size",
  },
  {
    "<Leader>wu",
    "<Cmd>WindowsToggleAutowidth<Cr>",
    desc = "CURRENT » Toggle Auto Width",
  },
}
M.config = function()
  require("windows").setup({
    animation = {
      enable = true,
      duration = 150,
    },
  })
end
return M
