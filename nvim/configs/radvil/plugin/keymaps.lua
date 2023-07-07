local function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", { silent = false, noremap = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- reset
map({ "n", "x", "v" }, "<nL>", "<nop>")
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
map({ "i", "c" }, "<a-bs>", "<esc>ciw", { nowait = true, desc = "Delete backward" })
map({ "i", "c" }, "<a-i>", "<space><esc>i", { desc = "Tab backward" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })
map({ "n", "x", "v" }, "ga", "<esc>ggVG", { nowait = true, desc = "Select all" })
map({ "n", "x", "v" }, "Q", "q", { nowait = true, desc = "Record" })
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

if vim.opt.clipboard ~= "unnamedplus" then
  local opt = function(desc)
    return { remap = true, nowait = true, desc = string.format("System clipboard » %s", desc) }
  end
  map({ "n", "o", "x", "v" }, "gy", '"+y', opt "Yank")
  map({ "n", "o", "x", "v" }, "gp", '"+p', opt "Paste after cursor")
  map("n", "gY", '"+y$', opt "Yank line")
  map("n", "gP", '"+P', opt "Paste before cursor")
end

-- swap lines
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Swap current line up" })
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Swap current line down" })
map("i", "<A-j>", "<esc>:m .+1<cr>==gi", { desc = "Swap current line down" })
map("i", "<A-k>", "<esc>:m .-2<cr>==gi", { desc = "Swap current line up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Swap selected lines up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Swap selected lines down" })

-- tabs
map("n", "[t", ":tabprevious<cr>", { desc = "Tab » Prev" })
map("n", "]t", ":tabnext<cr>", { desc = "Tab » Next" })
map("n", "<leader>tn", ":tabnew<cr>", { desc = "Tab » New" })
map("n", "<leader>td", ":tabclose<cr>", { desc = "Tab » Delete" })

-- windows
map("n", "<leader>ww", "<c-w>p", { desc = "Window » Other" })
map("n", "<leader>wd", "<c-w>c", { desc = "Window » Delete" })
-- if Util.call "smart-splits" == nil then
--   map("n", "<c-h>", "<c-w>h", { remap = true, desc = "Window » Navigate left" })
--   map("n", "<c-j>", "<c-w>j", { remap = true, desc = "Window » Navigate down" })
--   map("n", "<c-k>", "<c-w>k", { remap = true, desc = "Window » Navigate up" })
--   map("n", "<c-l>", "<c-w>l", { remap = true, desc = "Window » Navigate right" })
--   map("n", "<c-up>", ":resize +2<cr>", { desc = "Window » Height++" })
--   map("n", "<c-down>", ":resize -2<cr>", { desc = "Window » Height--" })
--   map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "Window » Width--" })
--   map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "Window » Width++" })
-- end

-- buffers
map("n", "<leader>`", "<cmd>e #<cr>", { silent = true, desc = "Buffer » Switch to other" })
map("n", "<leader>bb", "<cmd>e #<cr>", { silent = true, desc = "Buffer » Switch to other" })
map("n", "[b", ":bprevious<cr>", { silent = true, desc = "Buffer » Prev" })
map("n", "]b", ":bnext<cr>", { silent = true, desc = "Buffer » Next" })

-- if Util.call "mini.bufremove" == nil then
--   map("n", "<leader>bd", ":bdelete<cr>", { desc = "Buffer » Delete" })
--   map("n", "<Leader>bD", ":bufdo bdelete<cr>", { desc = "Buffer » Delete (all)" })
-- end

-- Clear search, diff update and redraw
map(
  "n",
  "<leader>ur",
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>",
  { desc = "Toggle » Redraw / clear hlsearch / diff update" }
)
