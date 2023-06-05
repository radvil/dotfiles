---@type LazySpec[]
return {

  ---@type LazySpec
  {
    "christoomey/vim-tmux-navigator",
    enabled = os.getenv("TMUX") ~= nil,
  },

  ---@type LazySpec
  {
    "radvil2/windows.nvim",
    event = "WinNew",
    dependencies = { "anuvyklack/middleclass", "anuvyklack/animation.nvim" },
    keys = {
      {
        "<Leader>wm",
        ":WindowsMaximize<Cr>",
        desc = "Window » Maximize/minimize",
      },
      {
        "<Leader>w=",
        ":WindowsEqualize<Cr>",
        desc = "Window » Set equal",
      },
      {
        "<Leader>wu",
        ":WindowsToggleAutowidth<Cr>",
        desc = "Window » Toggle auto width",
      },
    },
    opts = {
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
        filetype = require("common.filetypes").excludes,
      },
    },
  },

  ---@type LazySpec
  {
    "sindrets/winshift.nvim",
    event = "VeryLazy",
    cmd = "WinShift",
    keys = {
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
        desc = "Window » Shift Down",
      },
      {
        "<Leader>wk",
        "<Cmd>WinShift top<Cr>",
        desc = "Window » Shift Top",
      },
      {
        "<Leader>wh",
        "<Cmd>WinShift left<Cr>",
        desc = "Window » Shift Left",
      },
      {
        "<Leader>wl",
        "<Cmd>WinShift right<Cr>",
        desc = "Window » Shift Right",
      },
    },
    opts = function()
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
    end,
  },
}
