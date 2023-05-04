---@desc bookmarking
---@LazySpec
local M = {}

M[1] = "ThePrimeagen/harpoon"

local function mark_current()
  require("harpoon.mark").add_file()
  vim.notify("📌 Document marked")
end

local function quick_menu()
  require("harpoon.ui").toggle_quick_menu()
end

M.keys = {
  {
    "<C-m>",
    mark_current,
    desc = "Harpoon » Mark File",
  },
  {
    '<Leader><Space>',
    quick_menu,
    desc = "Harpoon » Open List",
  },
}

M.opts = {
  mark_branch = false,
  save_on_change = false,
  save_on_toggle = false,
  enter_on_sendcmd = false,
  tmux_autoclose_windows = false,
  excluded_filetypes = { "harpoon" },
  menu = {
    width = vim.api.nvim_win_get_width(0) - 13,
  },
}

return M
