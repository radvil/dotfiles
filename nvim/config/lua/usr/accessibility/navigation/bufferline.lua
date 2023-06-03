---@desc tabline/bufferline/etc
---@type LazySpec
local M = {}
M[1] = "akinsho/nvim-bufferline.lua"
M.event = "VeryLazy"
M.dependencies = { "nvim-tree/nvim-web-devicons" }
M.keys = {
  {
    "<Leader>bS",
    ":BufferLineSortByTabs<cr>",
    desc = "buffer » sort by directory",
  },
  {
    "<Leader>bs",
    ":BufferLineSortByDirectory<cr>",
    desc = "buffer » sort by relative directory",
  },
  {
    "<Leader>bp",
    "<Cmd>BufferLineTogglePin<CR>",
    desc = "buffer » toggle pin",
  },
  {
    "<A-b>",
    "<Cmd>BufferLinePick<CR>",
    desc = "buffer » pick",
  },
  {
    "<A-,>",
    "<Cmd>BufferLineMovePrev<CR>",
    desc = "buffer » shift left",
  },
  {
    "<A-.>",
    "<Cmd>BufferLineMoveNext<CR>",
    desc = "buffer » shift right",
  },
  {
    "<A-[>",
    "<Cmd>BufferLineCyclePrev<CR>",
    desc = "buffer » switch prev",
  },
  {
    "<A-]>",
    "<Cmd>BufferLineCycleNext<CR>",
    desc = "buffer » switch next",
  },
  {
    "<A-1>",
    "<Cmd>BufferLineGoToBuffer 1<CR>",
    desc = "buffer » switch 1st",
  },
  {
    "<A-2>",
    "<Cmd>BufferLineGoToBuffer 2<CR>",
    desc = "buffer » switch 2nd",
  },
  {
    "<A-3>",
    "<Cmd>BufferLineGoToBuffer 3<CR>",
    desc = "buffer » switch 3rd",
  },
  {
    "<A-4>",
    "<Cmd>BufferLineGoToBuffer 4<CR>",
    desc = "buffer » switch 4th",
  },
  {
    "<A-5>",
    "<Cmd>BufferLineGoToBuffer 5<CR>",
    desc = "buffer » switch 5th",
  },
}
M.opts = {
  options = {
    diagnostics = "nvim_lsp",
    sort_by = "insert_at_end",
    --- @type "thin" | "padded_slant" | "slant" | "thick" | "none"
    separator_style = "thin",
    indicator = {
      ---@type "icon" | "underline" | "none"
      style = "icon",
    },
    show_close_icon = false,
    show_tab_indicators = true,
    always_show_bufferline = false,
    diagnostics_indicator = function(_, _, diag)
      local icons = require("media.icons").Diagnostics
      local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = require("media.icons").Misc.Vim .. " Tree View",
        highlight = "BufferLineBackground",
        text_align = "left",
        separator = false,
      },
      {
        filetype = "neo-tree",
        text = require("media.icons").Misc.Vim .. " Tree View",
        highlight = "BufferLineBackground",
        text_align = "left",
        separator = false,
      },
    },
  },
}
return M
