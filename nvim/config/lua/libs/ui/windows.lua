---@type LazySpec
local M = {}
M[1] = "radvil2/windows.nvim"
M.event = "WinNew"
M.dependencies = "anuvyklack/middleclass"

M.keys = {
  {
    "<Leader>wm",
    ":WindowsMaximize<cr>",
    desc = "Window » Maximize/minimize",
  },
  {
    "<Leader>w=",
    ":WindowsEqualize<cr>",
    desc = "Window » Equalize",
  },
  {
    "<Leader>wu",
    ":WindowsToggleAutowidth<cr>",
    desc = "Window » Toggle autowidth",
  },
}

M.config = function()
  require("windows").setup({
    animation = { enable = false, },
    autowidth = {
      enable = false,
      winwidth = 5,
      filetype = {
        help = 2,
      },
    },
    ignore = {
      buftype = { "nofile", "quickfix", "edgy" },
      filetype = {
        unpack(require("opt.filetype").sidebars),
        "help"
      }
    }
  })
end

return M
