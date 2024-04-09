-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Optionally setup the terminal to use
-- This sets `vim.o.shell` and does some additional configuration for:
-- * pwsh
-- * powershell
-- LazyVim.terminal.setup("pwsh")

vim.opt.cursorline = false
vim.opt.fillchars = {
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  diff = "/",
  -- fold = " ",
  eob = " ",
}

vim.opt.sessionoptions = {
  "tabpages",
  "buffers",
  "winsize",
  "curdir",
  "folds",
}

if vim.g.neovide then
  ---@type "railgun" | "torpedo" | "pixiedust" | "sonicboom" | "ripple" | "wireframe"
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_hide_mouse_when_typing = false
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_transparency = 1 -- 0.87
  vim.opt.guifont = { "JetbrainsMono Nerd Font", ":h7.5" }
end

vim.g.autoformat = false
vim.g.lazygit_config = true
vim.g.minipairs_disable = true
vim.g.neo_transparent = false
vim.g.neo_winborder = vim.g.neo_transparent and "single" or "none"
