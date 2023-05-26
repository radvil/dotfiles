---@desc tabline/bufferline/etc
---@type LazySpec
local M = {}
M[1] = "akinsho/nvim-bufferline.lua"
M.event = "VeryLazy"
M.dependencies = { "nvim-tree/nvim-web-devicons" }
M.keys = {
  {
    "<Leader>bP",
    "<Cmd>BufferLineTogglePin<CR>",
    desc = "CURRENT » Pin/Unpin",
  },
  {
    "<A-b>",
    "<Cmd>BufferLinePick<CR>",
    desc = "Pick buffer",
  },
  {
    "<A-,>",
    "<Cmd>BufferLineMovePrev<CR>",
    desc = "Move buffer to left",
  },
  {
    "<A-.>",
    "<Cmd>BufferLineMoveNext<CR>",
    desc = "Move buffer to right",
  },
  {
    "<A-[>",
    "<Cmd>BufferLineCyclePrev<CR>",
    desc = "Switch to prev buffer",
  },
  {
    "<A-]>",
    "<Cmd>BufferLineCycleNext<CR>",
    desc = "Switch to next buffer",
  },
  {
    "<A-1>",
    "<Cmd>BufferLineGoToBuffer 1<CR>",
    desc = "Switch to 1st buffer",
  },
  {
    "<A-2>",
    "<Cmd>BufferLineGoToBuffer 2<CR>",
    desc = "Switch to 2nd buffer",
  },
  {
    "<A-3>",
    "<Cmd>BufferLineGoToBuffer 3<CR>",
    desc = "Switch to 3rd buffer",
  },
  {
    "<A-4>",
    "<Cmd>BufferLineGoToBuffer 4<CR>",
    desc = "Switch to 5th buffer",
  },
  {
    "<A-5>",
    "<Cmd>BufferLineGoToBuffer 5<CR>",
    desc = "Switch to 5th buffer",
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
