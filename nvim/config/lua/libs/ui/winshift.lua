---@desc window manager
---@type LazySpec
local M = {}
M[1] = "sindrets/winshift.nvim"
M.event = "VeryLazy"
M.cmd = "WinShift"
M.keys = {
  {
    "<Leader>w<Cr>",
    "<Cmd>WinShift<CR>",
    desc = "Window » Manage",
  },
  {
    "<Leader>ws",
    "<Cmd>WinShift swap<Cr>",
    desc = "Window » Swap",
  },
  {
    "<Leader>wj",
    "<Cmd>WinShift down<Cr>",
    desc = "Window » Shift down",
  },
  {
    "<Leader>wk",
    "<Cmd>WinShift top<Cr>",
    desc = "Window » Shift top",
  },
  {
    "<Leader>wh",
    "<Cmd>WinShift left<Cr>",
    desc = "Window » Shift left",
  },
  {
    "<Leader>wl",
    "<Cmd>WinShift right<Cr>",
    desc = "Window » Shift right",
  },
}
M.opts = function()
  local picker = require("winshift.lib").pick_window
  return {
    highlight_moving_win = true,
    focused_hl_group = "Visual",
    keymaps = {
      disable_defaults = false,
      win_move_mode = {
        ["q"] = "left",
        ["H"] = "far_left",
        ["j"] = "down",
        ["J"] = "far_down",
        ["k"] = "up",
        ["K"] = "far_up",
        ["l"] = "right",
        ["L"] = "far_right",
      },
    },
    window_picker = function()
      return picker({
        picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        filter_rules = {
          filetype = require("opt.filetype").excludes,
          cur_win = true,
          floats = true,
        },
      })
    end,
  }
end
return M
