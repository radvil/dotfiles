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
---@alias NeoColorscheme "catppuccin-latte" | "catppuccin-macchiato" | "catppuccin-mocha" | "catppuccin-frappe" | "tokyonight-moon" | "kanagawa" | "onedark" | "material" | "rose-pine"
---@type NeoColorscheme
vim.g.neo_colorscheme = "catppuccin-macchiato"
-- vim.g.neo_colorscheme = "tokyonight-moon"
vim.g.neo_transparent = false
vim.g.neo_diminactive = true
-- vim.opt.winborder = "rounded"
-- vim.g.neo_winborder = vim.g.neo_transparent and "single" and "none"
vim.g.neo_winborder = "rounded"

vim.g.minipairs_disable = true
vim.g.autoformat = false
vim.g.lazygit_config = true
vim.g.lazyvim_picker = "snacks"
vim.g.snacks_animate = false
vim.g.deprecation_warnings = false

-- vim.opt.cmdheight = 4
vim.opt.clipboard = ""
-- vim.opt.guicursor = ""
vim.opt.cursorline = true
vim.opt.pumblend = 0 -- Popup blend
vim.opt.swapfile = false
vim.opt.relativenumber = true
vim.opt.smoothscroll = true
vim.opt.laststatus = 3
vim.opt.timeoutlen = 2000
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
  vim.opt.foldexpr = "v:lua.LazyVim.treesitter.foldexpr()"
  vim.opt.foldmethod = "expr"
  vim.opt.foldtext = ""
end

if vim.opt.signcolumn:get() == "yes" and not LazyVim.has("statuscol.nvim") then
  vim.opt.statuscolumn = [[%!v:lua.Snacks.statuscolumn()]]
end

-- LSP Server to use for Rust.
-- Set to "bacon-ls" to use bacon-ls instead of rust-analyzer.
-- only for diagnostics. The rest of LSP support will still be
-- provided by rust-analyzer.
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

-- To use the newer, much faster `tsc` LSP server, either:
-- enable the `tsc` extra, or set `vim.g.lazyvim_ts_lsp = "tsc"`
---@type "vtsls" | "tsgo" | "tsc"
vim.g.lazyvim_ts_lsp = "tsc"

-- Enable this option to avoid conflicts with Prettier.
-- https://www.lazyvim.org/extras/lang/typescript/biome
vim.g.lazyvim_prettier_needs_config = true
