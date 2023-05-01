-- This file should load before plugins
local util = require("utils")

-- Base
Map({ "n", "i", "c", "x", "o" }, "<A-Space>", "<Esc>", { nowait = true, desc = "Exit insert" })
-- Map("n", "<Leader>xl", "<Cmd>lopen<Cr>", { desc = "[Loclist] open" })
Map("n", "<Leader>xe", "<Cmd>copen<Cr>", { desc = "Open Quickfix" })
Map("n", ";", ":", { nowait = true, silent = false })
Map("v", ";", ":", { nowait = true, silent = false })
Map("n", "+", "<Cmd>join<Cr>", { nowait = true })
Map("n", "U", "<C-r>", { nowait = true })
Map("n", "H", "^")
Map("n", "J", "5j")
Map("n", "K", "5k")
Map("n", "L", "g_")
Map("v", "H", "^")
Map("v", "J", "5j")
Map("v", "K", "5k")
Map("v", "L", "$")

-- Fighting Kirby
-- Map("c", "<F2>", [[\(.*\)]])

-- Change forward/backward whilst in ins mode
Map("i", "<C-d>", '<Esc>l"_cw')
Map("i", "<A-Bs>", '<Esc>l"_cb')

-- Add ispace after cursor whilst in ins mode
-- Map("i", "<C-i>", "<Space><Esc>i")
Map("i", "<C-W>", "<Space><Esc>i")
Map("i", "<C-H>", "<Left>")
Map("i", "<C-L>", "<Right>")

-- Give one space down whilst in normal mode
Map("n", "<A-Cr>", "o<Esc>", { desc = "Add one line down" })

-- Center search result
if not util.has("mini.animate") then
  Map("n", "n", "nzz", { nowait = true, desc = "Show + center search results" })
  Map("n", "N", "Nzz", { nowait = true, desc = "Show + center search results" })
end

-- Test selection
Map("n", "<C-g>", "ggVG", { desc = "Select all content [Normal]" })
Map("i", "<C-g>", "<Esc>ggVG<Cr>", { desc = "Select all content" })
Map("v", "<C-g>", "<Esc>", { desc = "Deselect all content" })

-- Clear search with <esc>
Map({ "i", "n" }, "<esc>", "<Cmd>noh<Cr><esc>", { desc = "Clear hlsearch" })

-- Better indenting
Map("v", "<", "<gv", { desc = "Indent Left" })
Map("v", ">", ">gv", { desc = "Indent Right" })

-- Move to window using the <ctrl> hjkl keys
if not util.has("vim-tmux-navigator") then
  Map("n", "<C-h>", "<C-w>h", { desc = "[Window] Navigate left" })
  Map("n", "<C-j>", "<C-w>j", { desc = "[Window] Navigate down" })
  Map("n", "<C-k>", "<C-w>k", { desc = "[Window] Navigate up" })
  Map("n", "<C-l>", "<C-w>l", { desc = "[Window] Navigate right" })
else
  Map("n", "<C-h>", "<Cmd>TmuxNavigateLeft<Cr>", { desc = "[Window] Navigate left" })
  Map("n", "<C-j>", "<Cmd>TmuxNavigateDown<Cr>", { desc = "[Window] Navigate down" })
  Map("n", "<C-k>", "<Cmd>TmuxNavigateUp<Cr>", { desc = "[Window] Navigate up" })
  Map("n", "<C-l>", "<Cmd>TmuxNavigateRight<Cr>", { desc = "[Window] Navigate right" })
end

-- Move Lines
Map("n", "<A-j>", ":m .+1<Cr>==", { desc = "Move down" })
Map("v", "<A-j>", ":m '>+1<Cr>gv=gv", { desc = "Move down" })
Map("i", "<A-j>", "<Esc>:m .+1<Cr>==gi", { desc = "Move down" })
Map("n", "<A-k>", ":m .-2<Cr>==", { desc = "Move up" })
Map("v", "<A-k>", ":m '<-2<Cr>gv=gv", { desc = "Move up" })
Map("i", "<A-k>", "<Esc>:m .-2<Cr>==gi", { desc = "Move up" })

-- Windows
-- NOTE: Later learn about Tab
Map("n", "<Leader>wd", "<C-W>c", { desc = "CURRENT » Delete" }) -- same as <Cmd>close
Map("n", "<C-Up>", "<Cmd>resize +2<Cr>", { desc = "Increase window height" })
Map("n", "<C-Down>", "<Cmd>resize -2<Cr>", { desc = "Decrease window height" })
Map("n", "<C-Left>", "<Cmd>vertical resize -2<Cr>", { desc = "Decrease window width" })
Map("n", "<C-Right>", "<Cmd>vertical resize +2<Cr>", { desc = "Increase window width" })

-- Buffers
Map("n", "[b", "<Cmd>bprevious<Cr>", { desc = "Prev buffer" })
Map("n", "]b", "<Cmd>bnext<Cr>", { desc = "Next buffer" })

if not util.has("mini.bufremove") then
  Map("n", "<Leader>bd", "<Cmd>bdelete<Cr>", { desc = "Delete current buffer" })
  Map("n", "<Leader>bD", "<Cmd>bufdo bdelete<Cr>", { desc = "Delete all buffers" })
end

Map("n", "<C-z>s", function()
  util.toggle("spell")
end, { desc = "Toggle » Word Spelling" })

Map("n", "<C-z>w", function()
  util.toggle("wrap")
end, { desc = "Toggle » Word Wrap" })

Map("n", "<C-z>n", function()
  util.toggle("relativenumber", true)
  util.toggle("number")
end, { desc = "Toggle » Line Numbers" })

Map("n", "<Leader>gg", function()
  util.float_term({ "lazygit" })
end, { desc = " Git » Open Lazy Git (cwd)" })

Map("n", "<Leader><Space>", function()
  vim.cmd [[call system('zmux')]]
end, { desc = "Tmux » New Session" })
