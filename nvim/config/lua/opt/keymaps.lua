rnv.api.log("Loading keymaps...", "opt.keymaps")

local util = require("common.utils")
local map = rnv.api.map

-- TODO:
-- ' g' `, ← all of these are the same keys to list marks

-- reset
map("i", "<c-d>", "<nop>")
map("n", "<a-cr>", "<nop>")
map("i", "<a-bs>", "<nop>")
map({ "n", "x", "v", "o" }, "-", "g$")
map({ "n", "x", "v" }, "<nl>", "<nop>")
map("", "<c-z>", ":undo<cr>", { nowait = true })

-- base
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("n", "U", "<c-r>", { nowait = true, desc = "Redo" })
map("n", "ZZ", ":qa<cr>", { nowait = true, desc = "Quit" })
map("n", "<a-cr>", "o<esc>", { desc = "Add one line down" })
map("i", "<c-d>", "<del>", { desc = "Delete next char" })
map("i", "<c-h>", "<left>", { desc = "Shift one char left" })
map("i", "<c-l>", "<right>", { desc = "Shift one char right" })
map({ "i", "o", "s" }, "<a-bs>", '<esc>l"_cb', { desc = "Delete one word left" })
map("i", "<c-w>", "<space><esc>i", { desc = "Delete one word right" })
map("n", "<leader>xl", ":lopen<cr>", { desc = "Diagnostics » Open in loclist" })
map("n", "<leader>xe", ":copen<cr>", { desc = "Diagnostics » Open in quickfix" })
map("n", "<c-g>", "ggVG", { desc = "Select all content" })
map("v", "<c-g>", "<esc>", { desc = "Unselect all content" })
map("i", "<c-g>", "<esc>ggVG", { desc = "Select all content" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })
map({ "n", "x", "v" }, "K", "5k", { desc = "Shift 5 top" })
map({ "n", "x", "v" }, "J", "5j", { desc = "Shift 5 down" })
map({ "n", "x", "v" }, "Q", "q", { nowait = true, desc = "Record" })
map({ "n", "x", "v" }, "+", ":join<cr>", { nowait = true, desc = "Join lines" })
map({ "n", "x", "v" }, "q", "<esc>", { nowait = true, desc = "Escape to normal" })
map({ "n", "x", "v" }, ";", ":", { nowait = true, silent = false, desc = "Drop into cmdline" })

-- center search result
if not util.has("mini.animate") then
  map("n", "n", "nzz", { nowait = true, desc = "Show & center search" })
  map("n", "N", "Nzz", { nowait = true, desc = "Show & center search" })
end

if vim.opt.clipboard ~= "unnamedplus" then
  map({ "n", "x", "v" }, "gy", '"+y', { nowait = true, desc = "System clipboard » Copy" })
  map({ "n", "x" }, "gY", '"+y$', { nowait = true, desc = "System clipboard » Copy line" })
  map({ "n", "x", "v" }, "gp", '"+p', { nowait = true, desc = "System clipboard » Paste before cursor" })
  map({ "n", 'x' }, "gP", '"+P', { nowait = true, desc = "System clipboard » Paste after cursor" })
end

-- move to window using the <ctrl> hjkl keys
if not os.getenv("TMUX") then
  map("n", "<c-h>", "<c-w>h", { desc = "Window » Navigate left" })
  map("n", "<c-j>", "<c-w>j", { desc = "Window » Navigate down" })
  map("n", "<c-k>", "<c-w>k", { desc = "Window » Navigate up" })
  map("n", "<c-l>", "<c-w>l", { desc = "Window » Navigate right" })
end

-- swap lines
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Swap current line up" })
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Swap current line down" })
map("i", "<A-j>", "<esc>:m .+1<cr>==gi", { desc = "Swap current line down" })
map("i", "<A-k>", "<esc>:m .-2<cr>==gi", { desc = "Swap current line up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Swap selected lines up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Swap selected lines down" })

-- windows
map("n", "<leader>ww", "<c-w>p", { desc = "Window » Other" })
map("n", "<leader>wd", "<c-w>c", { desc = "Window » Delete" }) -- TODO: same as <Cmd>close ??

if rnv.api.call("smart-splits") == nil then
  map("n", "<c-up>", ":resize +2<cr>", { desc = "Window » Height++" })
  map("n", "<c-down>", ":resize -2<cr>", { desc = "Window » Height--" })
  map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "Window » Width--" })
  map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "Window » Width++" })
end

-- buffers
map("n", "<Leader>`", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
map("n", "<Leader>bb", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
map("n", "[b", ":bprevious<cr>", { desc = "Buffer » Prev" })
map("n", "]b", ":bnext<cr>", { desc = "Buffer » Next" })
if rnv.api.call("mini.bufremove") == nil then
  map("n", "<leader>bd", ":bdelete<cr>", { desc = "Buffer » Delete" })
  map("n", "<Leader>bD", ":bufdo bdelete<cr>", { desc = "Buffer » Delete (all)" })
end

map("n", "<leader>uw", function()
  util.toggle("wrap")
end, { desc = "Toggle » Word wrap" })
map("n", "<leader>us", function()
  util.toggle("spell")
end, { desc = "Toggle » Word spell" })
map("n", "<leader>uc", function()
  util.toggle("cursorline")
end, { desc = "Toggle » Cursor line" })
map("n", "<leader>un", function()
  util.toggle("relativenumber", true)
  util.toggle("number")
end, { desc = "Toggle » Line numbers" })

-- floating terminal
map("n", "<leader>fG", function()
  util.float_term({ "lazygit" }, {
    cwd = util.get_root(),
    esc_esc = false,
    ctrl_hjkl = false
  })
end, { desc = "Float » Lazygit open (root)" })
map("n", "<leader>fg", function()
  util.float_term({ "lazygit" }, {
    esc_esc = false,
    ctrl_hjkl = false
  })
end, { desc = "Float » Lazygit open (cwd)" })
map("n", "<leader>ft", function()
  util.float_term(nil, {
    cwd = util.get_root()
  })
end, { desc = "Float » Terminal (root)" })
map("n", "<leader>fT", function()
  util.float_term()
end, { desc = "Float » Terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

map("n", "<leader>mw", function()
  vim.cmd([[call system('ami-project')]])
end, { desc = "Tmux » Switch ami workspace" })
map("n", "<leader>mm", function()
  vim.cmd([[call system('zmux')]])
end, { desc = "Tmux » Switch to most recent" })
