local util = require("minimal.util")
util.log("Loading keymaps...")

-- reset
util.map({ "n", "x", "v" }, "<nL>", "<nop>")
util.map("", "<c-z>", ":undo<cr>", { nowait = true })

-- base
util.map("v", "<", "<gv", { desc = "Indent left" })
util.map("v", ">", ">gv", { desc = "Indent right" })
util.map("n", "U", "<c-r>", { nowait = true, desc = "Redo" })
util.map("n", "ZZ", ":qa<cr>", { nowait = true, desc = "Quit" })
util.map("n", "<a-cr>", "o<esc>", { desc = "Add one line down" })
util.map("i", "<c-d>", "<del>", { desc = "Delete next char" })
util.map("i", "<c-h>", "<left>", { desc = "Shift one char left" })
util.map("i", "<c-l>", "<right>", { desc = "Shift one char right" })
util.map({ "i", "c" }, "<a-bs>", "<esc>ciw", { nowait = true, desc = "Delete backward" })
util.map({ "i", "c" }, "<a-i>", "<space><esc>i", { desc = "Tab backward" })
util.map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })
util.map({ "n", "x", "v" }, "ga", "<esc>ggVG", { nowait = true, desc = "Select all" })
util.map({ "n", "x", "v" }, "Q", "q", { nowait = true, desc = "Record" })
util.map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
util.map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

if vim.opt.clipboard ~= "unnamedplus" then
  local opt = function(desc)
    return { nowait = true, desc = string.format("System clipboard » %s", desc) }
  end
  util.map({ "n", "o", "x", "v" }, "gy", '"+y', opt("Yank"))
  util.map({ "n", "o", "x", "v" }, "gp", '"+p', opt("Paste after cursor"))
  util.map("n", "gY", '"+y$', opt("Yank line"))
  util.map("n", "gP", '"+P', opt("Paste before cursor"))
end

-- Clear search, diff update and redraw
util.map(
  "n",
  "<leader>ur",
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- swap lines
util.map("n", "<A-k>", ":m .-2<cr>==", { desc = "Swap current line up" })
util.map("n", "<A-j>", ":m .+1<cr>==", { desc = "Swap current line down" })
util.map("i", "<A-j>", "<esc>:m .+1<cr>==gi", { desc = "Swap current line down" })
util.map("i", "<A-k>", "<esc>:m .-2<cr>==gi", { desc = "Swap current line up" })
util.map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Swap selected lines up" })
util.map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Swap selected lines down" })

-- tabs
util.map("n", "[t", ":tabprevious<cr>", { desc = "Tab » Prev" })
util.map("n", "]t", ":tabnext<cr>", { desc = "Tab » Next" })
util.map("n", "<leader>tn", ":tabnew<cr>", { desc = "Tab » New" })
util.map("n", "<leader>td", ":tabclose<cr>", { desc = "Tab » Delete" })

-- windows
util.map("n", "<leader>ww", "<c-w>p", { desc = "Window » Other" })
util.map("n", "<leader>wd", "<c-w>c", { desc = "Window » Delete" })
if util.call("smart-splits") == nil then
  util.map("n", "<c-h>", "<c-w>h", { remap = true, desc = "Window » Navigate left" })
  util.map("n", "<c-j>", "<c-w>j", { remap = true, desc = "Window » Navigate down" })
  util.map("n", "<c-k>", "<c-w>k", { remap = true, desc = "Window » Navigate up" })
  util.map("n", "<c-l>", "<c-w>l", { remap = true, desc = "Window » Navigate right" })
  util.map("n", "<c-up>", ":resize +2<cr>", { desc = "Window » Height++" })
  util.map("n", "<c-down>", ":resize -2<cr>", { desc = "Window » Height--" })
  util.map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "Window » Width--" })
  util.map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "Window » Width++" })
end

-- buffers
util.map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
util.map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
util.map("n", "[b", ":bprevious<cr>", { desc = "Buffer » Prev" })
util.map("n", "]b", ":bnext<cr>", { desc = "Buffer » Next" })

if require("minimal.util").call("mini.bufremove") == nil then
  util.map("n", "<leader>bd", ":bdelete<cr>", { desc = "Buffer » Delete" })
  util.map("n", "<Leader>bD", ":bufdo bdelete<cr>", { desc = "Buffer » Delete (all)" })
end

util.map("n", "<leader>us", function()
  util.toggle("spell")
end, { desc = "Toggle » Spell" })
util.map("n", "<leader>uw", function()
  util.toggle("wrap")
end, { desc = "Toggle » Word wrap" })
util.map("n", "<leader>uc", function()
  util.toggle("cursorline")
end, { desc = "Toggle » Cursor line" })
util.map("n", "<leader>un", function()
  util.toggle("relativenumber", true)
  util.toggle("number")
end, { desc = "Toggle » Line numbers" })

---floating terminal
local ft = function(cmd, root)
  local opt = { size = { width = 0.6, height = 0.7 }, title = "  " .. (cmd or "Terminal"), title_pos = "right" }
  opt.border = minimal.transbg and "single" or "none"
  if root then
    opt.cwd = util.get_root()
  end
  util.float_term(cmd, opt)
end
util.map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
util.map("t", [[<c-\>]], "<cmd>close<cr>", { desc = "Float » Terminal hide" })
--stylua: ignore
util.map("n", "<leader>fh", function() ft("btop") end, { desc = "Float » Open htop/btop" })
--stylua: ignore
util.map("n", "<leader>fT", function() ft(nil) end, { desc = "Float » Terminal (curr dir)" })
--stylua: ignore
util.map("n", "<leader>ft", function() ft(nil, true) end, { desc = "Float » Terminal (root dir)" })
--stylua: ignore
util.map("n", [[<c-\>]], function() ft(nil, true) end, { desc = "Float » Terminal open (root dir)" })

if not vim.g.neovide then
  util.map("n", "<leader>fz", function()
    vim.cmd([[call system('zmux')]])
  end, { desc = "Float » Tmux Z" })
end

---lazygit
local lz = function(opts)
  util.float_term({ "lazygit" }, {
    unpack(opts or {}),
    title_pos = "right",
    title = "  LazyGit ",
    border = "rounded",
    ctrl_hjkl = false,
    esc_esc = false,
  })
end
util.map("n", "<leader>gg", function()
  lz()
end, { desc = "Git » Open lazygit (curr dir)" })
util.map("n", "<leader>gG", function()
  lz({ cwd = util.get_root() })
end, { desc = "Git » Open lazygit (root dir)" })
