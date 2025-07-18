-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local Utils = require("utils")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Optionally setup the terminal to use
-- This sets `vim.o.shell` and does some additional configuration for:
-- * pwsh
-- * powershell
if Utils.command_exists("fish") then
  LazyVim.terminal.setup("fish")
end

-- os.getenv("KITTY_WINDOW_ID") and true or false
---@alias NeoColorscheme "catppuccin" | "tokyonight" | "kanagawa" | "onedark" | "material" | "rose-pine"

---@type NeoColorscheme
vim.g.neo_colorscheme = "catppuccin"
vim.g.neo_transparent = false
vim.g.neo_diminactive = false
-- vim.g.neo_winborder = vim.g.neo_transparent and "single" or "none"
vim.g.neo_winborder = "single"

vim.g.minipairs_disable = true
vim.g.autoformat = false
vim.g.lazygit_config = true
vim.g.lazyvim_picker = "telescope"
vim.g.snacks_animate = false
vim.g.deprecation_warnings = false

vim.opt.clipboard = ""
vim.opt.guicursor = ""
vim.opt.cursorline = false
vim.opt.pumblend = 0 -- Popup blend
vim.opt.swapfile = false
vim.opt.relativenumber = true
vim.opt.smoothscroll = true
vim.opt.laststatus = 2
vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
  "skiprtp",
  "folds",
}

vim.opt.fillchars = {
  foldclose = "",
  foldopen = "",
  foldsep = " ",
  diff = "/",
  -- fold = " ",
  eob = " ",
}

if not LazyVim.has("nvim-ufo") then
  vim.opt.foldexpr = "v:lua.LazyVim.ui.foldexpr()"
  vim.opt.foldmethod = "expr"
  vim.opt.foldtext = ""
end

if vim.opt.signcolumn:get() == "yes" and not LazyVim.has("statuscol.nvim") then
  vim.opt.statuscolumn = [[%!v:lua.Snacks.statuscolumn()]]
end

if vim.g.neovide then
  ---@type "railgun" | "torpedo" | "pixiedust" | "sonicboom" | "ripple" | "wireframe"
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_hide_mouse_when_typing = false
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_transparency = 1 -- 0.87
  vim.opt.guifont = { "JetbrainsMono Nerd Font", ":h12" }
end
