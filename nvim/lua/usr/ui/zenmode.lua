---@type LazySpec
local M = {}
M[1] = "folke/zen-mode.nvim"
M.cmd = "ZenMode"
M.opts = {
  window = {
    backdrop = 0.95,
    width = 120,
    height = 1,
    options = {
      -- signcolumn = "no",
      -- number = false,
      -- relativenumber = false,
      -- cursorline = false,
      -- cursorcolumn = false,
      foldcolumn = "0",
      -- list = false,
    },
  },
  plugins = {
    -- options = {
    --   enabled = true,
    --   ruler = false,
    --   showcmd = false,
    -- },
    twilight = {
      enabled = false,
    },
    gitsigns = {
      enabled = true,
    },
    tmux = {
      enabled = false,
    },
    kitty = {
      enabled = false,
      font = "+4",
    },
    alacritty = {
      enabled = false,
      font = "14",
    },
  },
  -- on_open = function(win) end,
  -- on_close = function() end,
}
return M
