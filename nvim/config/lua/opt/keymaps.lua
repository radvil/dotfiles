rnv.api.log("Loading keymaps...", "opt.keymaps")

local util = require("common.utils")
local map = rnv.api.map

-- TODO:
-- ' g' `, ← all of these are the same keys to list marks

-- reset
map("i", "<c-d>", "<nop>")
map("n", "<a-cr>", "<nop>")
map("i", "<a-bs>", "<nop>")
map({ "n", "x", "v" }, "-", "g$")
map({ "n", "x", "v" }, "<nl>", "<nop>")
map("", "<c-z>", ":undo<cr>", { nowait = true })

-- base
map("v", "<", "<gv", { desc = "indent left" })
map("v", ">", ">gv", { desc = "indent right" })
map("n", "U", "<c-r>", { nowait = true, desc = "redo" })
map("n", "ZZ", ":qa<cr>", { nowait = true, desc = "quit" })
map("n", "<a-cr>", "o<esc>", { desc = "add one line down" })
map("i", "<c-d>", "<del>", { desc = "delete next char" })
map("i", "<c-h>", "<left>", { desc = "shift one char left" })
map("i", "<c-l>", "<right>", { desc = "shift one char right" })
map("i", "<a-bs>", '<esc>l"_cb', { desc = "delete one word left" })
map("i", "<c-w>", "<space><esc>i", { desc = "delete one word right" })
map("n", "<leader>xl", ":lopen<cr>", { desc = "diagnostics » open in loclist" })
map("n", "<leader>xe", ":copen<cr>", { desc = "diagnostics » open in quickfix" })
map("n", "<c-g>", "ggVG", { desc = "select all content" })
map("v", "<c-g>", "<esc>", { desc = "unselect all content" })
map("i", "<c-g>", "<esc>ggVG", { desc = "select all content" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "clear hlsearch" })
map({ "n", "x", "v" }, "K", "5k", { desc = "shift 5 top" })
map({ "n", "x", "v" }, "J", "5j", { desc = "shift 5 down" })
map({ "n", "x", "v" }, "Q", "q", { nowait = true, desc = "record" })
map({ "n", "x", "v" }, "+", ":join<cr>", { nowait = true, desc = "join lines" })
map({ "n", "x", "v" }, "q", "<esc>", { nowait = true, desc = "escape to normal" })
map({ "n", "x", "v" }, ";", ":", { nowait = true, silent = false, desc = "drop into cmdline" })

-- center search result
if not util.has("mini.animate") then
  map("n", "n", "nzz", { nowait = true, desc = "show & center search" })
  map("n", "N", "Nzz", { nowait = true, desc = "show & center search" })
end

if vim.opt.clipboard ~= "unnamedplus" then
  map({ "n", "x", "v" }, "gy", '"+y', { nowait = true, desc = "system clipboard » copy" })
  map("n", "gY", '"+y$', { nowait = true, desc = "system clipboard » copy line" })
  map({ "n", "x", "v" }, "gp", '"+p', { nowait = true, desc = "system clipboard » paste before cursor" })
  map("n", "gP", '"+P', { nowait = true, desc = "system clipboard » pase after cursor" })
end

-- move to window using the <ctrl> hjkl keys
if os.getenv("TMUX") == nil then
  map("n", "<c-h>", "<c-w>h", { desc = "window » navigate left" })
  map("n", "<c-j>", "<c-w>j", { desc = "window » navigate down" })
  map("n", "<c-k>", "<c-w>k", { desc = "window » navigate up" })
  map("n", "<c-l>", "<c-w>l", { desc = "window » navigate right" })
end

-- swap lines
map("n", "<A-k>", ":m .-2<cr>==", { desc = "swap current line up" })
map("n", "<A-j>", ":m .+1<cr>==", { desc = "swap current line down" })
map("i", "<A-j>", "<esc>:m .+1<cr>==gi", { desc = "swap current line down" })
map("i", "<A-k>", "<esc>:m .-2<cr>==gi", { desc = "swap current line up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "swap selected lines up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "swap selected lines down" })

-- windows
map("n", "<leader>ww", "<c-w>p", { desc = "Window » other" })
map("n", "<leader>wd", "<c-w>c", { desc = "window » delete" }) -- TODO: same as <Cmd>close ??
map("n", "<c-up>", ":resize +2<cr>", { desc = "window » height++" })
map("n", "<c-down>", ":resize -2<cr>", { desc = "window » height--" })
map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "window » width--" })
map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "window » width++" })

-- buffers
map("n", "<Leader>`", "<cmd>e #<cr>", { desc = "Buffer » switch to other" })
map("n", "<Leader>bb", "<cmd>e #<cr>", { desc = "Buffer » switch to other" })
map("n", "[b", ":bprevious<cr>", { desc = "Buffer » prev" })
map("n", "]b", ":bnext<cr>", { desc = "Buffer » next" })
if not util.has("mini.bufremove") then
  map("n", "<leader>bd", ":bdelete<cr>", { desc = "buffer » delete" })
  map("n", "<Leader>bD", ":bufdo bdelete<cr>", { desc = "buffer » delete (all)" })
end

map("n", "<leader>uw", function()
  util.toggle("wrap")
end, { desc = "Toggle » word wrap" })
map("n", "<leader>us", function()
  util.toggle("spell")
end, { desc = "Toggle » word spell" })
map("n", "<leader>uc", function()
  util.toggle("cursorline")
end, { desc = "Toggle » cursor line" })
map("n", "<leader>un", function()
  util.toggle("relativenumber", true)
  util.toggle("number")
end, { desc = "Toggle » line numbers" })

-- floating terminal
map("n", "<leader>fG", function()
  util.float_term({ "lazygit" }, { cwd = util.get_root() })
end, { desc = "Float » lazygit open (root)" })
map("n", "<leader>fg", function()
  util.float_term({ "lazygit" })
end, { desc = "Float » lazygit open (cwd)" })
map("n", "<leader>ft", function()
  util.float_term(nil, { cwd = util.get_root() })
end, { desc = "Float » terminal (root)" })
map("n", "<leader>fT", function()
  util.float_term()
end, { desc = "Float » terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

map("n", "<leader>mw", function()
  vim.cmd([[call system('ami-project')]])
end, { desc = "Tmux » switch ami workspace" })
map("n", "<leader>mm", function()
  vim.cmd([[call system('zmux')]])
end, { desc = "Tmux » most recent directory" })
