-- keymaps are automatically loaded on the verylazy event
-- default keymaps that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/keymaps.lua
local util = require("lazyvim.util")

-- overrides
vim.keymap.set("", "<Leader>q", "<nop>")
vim.keymap.set("n", "<Leader>w-", "<nop>")
vim.keymap.set("n", "<Leader>w|", "<nop>")
vim.keymap.set("", "<c-z><c-z>", "", { silent = true, noremap = true })
vim.keymap.set("n", "<a-cr>", "<nop>", { silent = true, noremap = true })
vim.keymap.set("i", "<a-bs>", "<nop>", { silent = true, noremap = true })
vim.keymap.set("i", "<c-d>", "<nop>", { silent = true, noremap = true })
vim.keymap.set({ "n", "x", "v" }, "<nl>", "<nop>", { silent = true, noremap = true })

-- base
vim.keymap.set("v", "<", "<gv", { desc = "indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "indent right" })
vim.keymap.set("n", "U", "<c-r>", { nowait = true, desc = "redo" })
vim.keymap.set("n", "ZZ", ":qa<cr>", { nowait = true, desc = "quit" })
vim.keymap.set("n", "<a-cr>", "o<esc>", { desc = "add one line down" })
vim.keymap.set("i", "<c-d>", "<del>", { desc = "delete next char" })
vim.keymap.set("i", "<c-h>", "<left>", { desc = "shift one char left" })
vim.keymap.set("i", "<c-l>", "<right>", { desc = "shift one char right" })
vim.keymap.set("i", "<a-bs>", '<esc>l"_cb', { desc = "delete one word left" })
vim.keymap.set("i", "<c-w>", "<space><esc>i", { desc = "delete one word right" })
vim.keymap.set("n", "<leader>xl", ":lopen<cr>", { desc = "diagnostics » open in loclist" })
vim.keymap.set("n", "<leader>xe", ":copen<cr>", { desc = "diagnostics » open in quickfix" })
vim.keymap.set("n", "<c-g>", "ggVG", { desc = "select all content" })
vim.keymap.set("v", "<c-g>", "<esc>", { desc = "unselect all content" })
vim.keymap.set("i", "<c-g>", "<esc>ggVG", { desc = "select all content" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "clear hlsearch" })
vim.keymap.set({ "n", "x", "v" }, "Q", "q", { nowait = true, desc = "record" })
vim.keymap.set({ "n", "x", "v" }, "+", ":join<cr>", { nowait = true, desc = "join lines" })
vim.keymap.set({ "n", "x", "v" }, "q", "<esc>", { nowait = true, desc = "escape to normal" })
vim.keymap.set({ "n", "x", "v" }, ";", ":", { nowait = true, silent = false, desc = "drop into cmdline" })

-- center search result
if not util.has("mini.animate") then
  vim.keymap.set("n", "n", "nzz", { nowait = true, desc = "show & center search" })
  vim.keymap.set("n", "N", "Nzz", { nowait = true, desc = "show & center search" })
end

if vim.opt.clipboard ~= "unnamedplus" then
  vim.keymap.set({ "n", "x", "v" }, "gy", '"+y', { desc = "system clipboard » copy" })
  vim.keymap.set({ "n", "x", "v" }, "gY", '"+Y', { desc = "system clipboard » copy line" })
  vim.keymap.set({ "n", "x", "v" }, "gp", '"+p', { desc = "system clipboard » paste before cursor" })
  vim.keymap.set({ "n", "x", "v" }, "gP", '"+P', { desc = "system clipboard » pase after cursor" })
end

-- move to window using the <ctrl> hjkl keys
if os.getenv("TMUX") == nil then -- TODO: tmux-navigator plugin name ?
  vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "window » navigate left" })
  vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "window » navigate down" })
  vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "window » navigate up" })
  vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "window » navigate right" })
else
  vim.keymap.set("n", "<c-h>", ":TmuxNavigateLeft<cr>", { nowait = true, desc = "window/tmux » navigate left" })
  vim.keymap.set("n", "<c-j>", ":TmuxNavigateDown<cr>", { nowait = true, desc = "window/tmux » navigate down" })
  vim.keymap.set("n", "<c-k>", ":TmuxNavigateUp<cr>", { nowait = true, desc = "window/tmux » navigate up" })
  vim.keymap.set("n", "<c-l>", ":TmuxNavigateRight<cr>", { nowait = true, desc = "window/tmux » navigate right" })
end

-- swap lines
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", { desc = "swap current line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", { desc = "swap current line down" })
vim.keymap.set("i", "<A-j>", "<esc>:m .+1<cr>==gi", { desc = "swap current line down" })
vim.keymap.set("i", "<A-k>", "<esc>:m .-2<cr>==gi", { desc = "swap current line up" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "swap selected lines up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "swap selected lines down" })

-- windows
vim.keymap.set("n", "<leader>wd", "<c-w>c", { desc = "window » delete" }) -- TODO: same as <Cmd>close ??
vim.keymap.set("n", "<c-up>", ":resize +2<cr>", { desc = "window » height++" })
vim.keymap.set("n", "<c-down>", ":resize -2<cr>", { desc = "window » height--" })
vim.keymap.set("n", "<c-left>", ":vertical resize -2<cr>", { desc = "window » width--" })
vim.keymap.set("n", "<c-right>", ":vertical resize +2<cr>", { desc = "window » width++" })

-- buffers
vim.keymap.set("n", "[b", ":bprevious<cr>", { desc = "buffer » prev" })
vim.keymap.set("n", "]b", ":bnext<cr>", { desc = "buffer » next" })

if not util.has("mini.bufremove") then
  vim.keymap.set("n", "<leader>bd", ":bdelete<cr>", { desc = "buffer » delete" })
  vim.keymap.set("n", "<Leader>bD", ":bufdo bdelete<cr>", { desc = "buffer » delete (all)" })
end

vim.keymap.set("n", "<c-z>w", function()
  util.toggle("wrap")
end, { desc = "toggle » word wrap" })

vim.keymap.set("n", "<c-z>s", function()
  util.toggle("spell")
end, { desc = "toggle » word spell" })

vim.keymap.set("n", "<c-z>c", function()
  util.toggle("cursorline")
end, { desc = "toggle » cursor line" })

vim.keymap.set("n", "<leader>mw", function()
  vim.cmd([[call system('ami-project')]])
end, { desc = "tmux » switch ami workspace" })

vim.keymap.set("n", "<leader>mm", function()
  vim.cmd([[call system('zmux')]])
end, { desc = "tmux » most recent directory" })

vim.keymap.set("n", "<c-z>n", function()
  util.toggle("relativenumber", true)
  util.toggle("number")
end, { desc = "toggle » line numbers" })

vim.keymap.set("n", "<leader>gg", function()
  if os.getenv("TMUX") ~= nil then
    vim.cmd([[call system('lg --popup')]])
  else
    util.float_term({ "lazygit" })
  end
end, { desc = "Lazygit (cwd)" })
