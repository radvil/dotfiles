local util = require("utils")

-- TODO:
-- ' g' `, ← all of these are the same keys to list marks

-- reset
Map("", "<c-z><c-z>", "", { silent = true, noremap = true })
Map({ "n", "x", "v" }, "<nl>", "<nop>", { silent = true, noremap = true })
Map("n", "<a-cr>", "<nop>", { silent = true, noremap = true })
Map("i", "<a-bs>", "<nop>", { silent = true, noremap = true })
Map("i", "<c-d>", "<nop>", { silent = true, noremap = true })

-- base
Map("v", "<", "<gv", { desc = "indent left" })
Map("v", ">", ">gv", { desc = "indent right" })
Map("n", "U", "<c-r>", { nowait = true, desc = "redo" })
Map("n", "ZZ", ":qa<cr>", { nowait = true, desc = "quit" })
Map("n", "<a-cr>", "o<esc>", { desc = "add one line down" })
Map("i", "<c-d>", '<del>', { desc = "delete next char" })
Map("i", "<c-h>", "<left>", { desc = "shift one char left" })
Map("i", "<c-l>", "<right>", { desc = "shift one char right" })
Map("i", "<a-bs>", '<esc>l"_cb', { desc = "delete one word left" })
Map("i", "<c-w>", "<space><esc>i", { desc = "delete one word right" })
Map("n", "<leader>xl", ":lopen<cr>", { desc = "diagnostics » open in loclist" })
Map("n", "<leader>xe", ":copen<cr>", { desc = "diagnostics » open in quickfix" })
Map("n", "<c-g>", "ggVG", { desc = "select all content" })
Map("v", "<c-g>", "<esc>", { desc = "unselect all content" })
Map("i", "<c-g>", "<esc>ggVG", { desc = "select all content" })
Map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "clear hlsearch" })
Map({ "n", "x", "v" }, "K", "5k", { desc = "shift 5 top" })
Map({ "n", "x", "v" }, "J", "5j", { desc = "shift 5 down" })
-- Map({ "n", "x", "v" }, "H", "^", { desc = "shift to start line" })
-- Map({ "n", "x", "v" }, "L", "$", { desc = "shift to end line" })
Map({ "n", "x", "v" }, "Q", "q", { nowait = true, desc = "record" })
Map({ "n", "x", "v" }, "+", ":join<cr>", { nowait = true, desc = "join lines" })
Map({ "n", "x", "v" }, "q", "<esc>", { nowait = true, desc = "escape to normal" })
Map({ "n", "x", "v" }, ";", ":", { nowait = true, silent = false, desc = "drop into cmdline" })

-- center search result
if not util.has("mini.animate") then
  Map("n", "n", "nzz", { nowait = true, desc = "show & center search" })
  Map("n", "N", "Nzz", { nowait = true, desc = "show & center search" })
end

if vim.opt.clipboard ~= "unnamedplus" then
  Map({ "n", "x", "v" }, "gy", '"+y', { desc = "system clipboard » copy" })
  Map({ "n", "x", "v" }, "gY", '"+y$', { desc = "system clipboard » copy line" })
  Map({ "n", "x", "v" }, "gp", '"+p', { desc = "system clipboard » paste before cursor" })
  Map({ "n", "x", "v" }, "gP", '"+P', { desc = "system clipboard » pase after cursor" })
end

-- move to window using the <ctrl> hjkl keys
if os.getenv("TMUX") == nil then
  Map("n", "<c-h>", "<c-w>h", { desc = "window » navigate left" })
  Map("n", "<c-j>", "<c-w>j", { desc = "window » navigate down" })
  Map("n", "<c-k>", "<c-w>k", { desc = "window » navigate up" })
  Map("n", "<c-l>", "<c-w>l", { desc = "window » navigate right" })
else
  Map("n", "<c-h>", ":TmuxNavigateLeft<cr>", { nowait = true, desc = "window/tmux » navigate left" })
  Map("n", "<c-j>", ":TmuxNavigateDown<cr>", { nowait = true, desc = "window/tmux » navigate down" })
  Map("n", "<c-k>", ":TmuxNavigateUp<cr>", { nowait = true, desc = "window/tmux » navigate up" })
  Map("n", "<c-l>", ":TmuxNavigateRight<cr>", { nowait = true, desc = "window/tmux » navigate right" })
end

-- swap lines
Map("n", "<A-k>", ":m .-2<cr>==", { desc = "swap current line up" })
Map("n", "<A-j>", ":m .+1<cr>==", { desc = "swap current line down" })
Map("i", "<A-j>", "<esc>:m .+1<cr>==gi", { desc = "swap current line down" })
Map("i", "<A-k>", "<esc>:m .-2<cr>==gi", { desc = "swap current line up" })
Map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "swap selected lines up" })
Map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "swap selected lines down" })

-- windows
Map("n", "<leader>wd", "<c-w>c", { desc = "window » delete" }) -- TODO: same as <Cmd>close ??
Map("n", "<c-up>", ":resize +2<cr>", { desc = "window » height++" })
Map("n", "<c-down>", ":resize -2<cr>", { desc = "window » height--" })
Map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "window » width--" })
Map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "window » width++" })

-- buffers
Map("n", "[b", ":bprevious<cr>", { desc = "buffer » prev" })
Map("n", "]b", ":bnext<cr>", { desc = "buffer » next" })

if not util.has("mini.bufremove") then
  Map("n", "<leader>bd", ":bdelete<cr>", { desc = "buffer » delete" })
  Map("n", "<Leader>bD", ":bufdo bdelete<cr>", { desc = "buffer » delete (all)" })
end

Map("n", "<c-z>w", function() util.toggle("wrap") end, { desc = "toggle » word wrap" })
Map("n", "<c-z>s", function() util.toggle("spell") end, { desc = "toggle » word spell" })
Map("n", "<c-z>c", function() util.toggle("cursorline") end, { desc = "toggle » cursor line" })
Map("n", "<leader>mw", function() vim.cmd [[call system('ami-project')]] end, { desc = "tmux » switch ami workspace" })
Map("n", "<leader>mm", function() vim.cmd [[call system('zmux')]] end, { desc = "tmux » most recent directory" })
Map("n", "<c-z>n", function()
  util.toggle("relativenumber", true)
  util.toggle("number")
end, { desc = "toggle » line numbers" })
Map("n", "<leader>gg", function() util.float_term({ "lazygit" }) end, { desc = "LazyGit » open float (cwd)" })
-- Map("n", "<leader>gg",
--   function() if os.getenv("TMUX") ~= nil then vim.cmd [[call system('lg --popup')]] else util.float_term({ "lazygit" }) end end,
--   { desc = " Git » Open Lazy Git [cwd]" })

-- floating terminal
Map("n", "<leader>ft", function() util.float_term(nil, { cwd = util.get_root() }) end, { desc = "Terminal (root)" })
Map("n", "<leader>fT", function() util.float_term() end, { desc = "Terminal (cwd)" })
Map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
