local NeoUtils = require("neoverse.utils")
NeoUtils.debug("Loading keymaps...")

-- reset
NeoUtils.map({ "n", "x", "v" }, "<nL>", "<nop>")
NeoUtils.map("", "<c-z>", ":undo<cr>", { nowait = true })

-- base
NeoUtils.map("v", "<", "<gv", { desc = "Indent left" })
NeoUtils.map("v", ">", ">gv", { desc = "Indent right" })
NeoUtils.map("n", "U", "<c-r>", { nowait = true, desc = "Redo" })
NeoUtils.map("n", "ZZ", ":qa<cr>", { nowait = true, desc = "Quit" })
NeoUtils.map("n", "<a-cr>", "o<esc>", { desc = "Add one line down" })
NeoUtils.map("i", "<c-d>", "<del>", { desc = "Delete next char" })
NeoUtils.map("i", "<c-h>", "<left>", { desc = "Shift one char left" })
NeoUtils.map("i", "<c-l>", "<right>", { desc = "Shift one char right" })
NeoUtils.map({ "i", "c" }, "<a-bs>", "<esc>ciw", { nowait = true, desc = "Delete backward" })
-- NeoUtils.map({ "i", "c" }, "<a-i>", "<space><esc>i", { desc = "Tab backward" })
NeoUtils.map({ "i", "c" }, "<a-i>", "<space><left>", { desc = "Tab backward" })
NeoUtils.map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })
NeoUtils.map({ "n", "x", "v" }, "ga", "<esc>ggVG", { nowait = true, desc = "Select all" })
NeoUtils.map({ "n", "x", "v" }, "Q", "q", { nowait = true, desc = "Record" })
NeoUtils.map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
NeoUtils.map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

if vim.opt.clipboard ~= "unnamedplus" then
  local opt = function(desc)
    return { nowait = true, desc = string.format("System clipboard » %s", desc) }
  end
  NeoUtils.map({ "n", "o", "x", "v" }, "gy", '"+y', opt("Yank"))
  NeoUtils.map({ "n", "o", "x", "v" }, "gp", '"+p', opt("Paste after cursor"))
  NeoUtils.map("n", "gY", '"+y$', opt("Yank line"))
  NeoUtils.map("n", "gP", '"+P', opt("Paste before cursor"))
end

-- Clear search, diff update and redraw
NeoUtils.map(
  "n",
  "<leader>ur",
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- swap lines
NeoUtils.map("n", "<A-k>", ":m .-2<cr>==", { desc = "Swap current line up" })
NeoUtils.map("n", "<A-j>", ":m .+1<cr>==", { desc = "Swap current line down" })
NeoUtils.map("i", "<A-j>", "<esc>:m .+1<cr>==gi", { desc = "Swap current line down" })
NeoUtils.map("i", "<A-k>", "<esc>:m .-2<cr>==gi", { desc = "Swap current line up" })
NeoUtils.map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Swap selected lines up" })
NeoUtils.map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Swap selected lines down" })

-- tabs
NeoUtils.map("n", "[t", ":tabprevious<cr>", { desc = "Tab » Prev" })
NeoUtils.map("n", "]t", ":tabnext<cr>", { desc = "Tab » Next" })
NeoUtils.map("n", "<leader>tn", ":tabnew<cr>", { desc = "Tab » New" })
NeoUtils.map("n", "<leader>td", ":tabclose<cr>", { desc = "Tab » Delete" })

-- windows
NeoUtils.map("n", "<leader>ww", "<c-w>p", { desc = "Window » Other" })
NeoUtils.map("n", "<leader>wd", "<c-w>c", { desc = "Window » Delete" })
if NeoUtils.call("smart-splits") == nil then
  NeoUtils.map("n", "<c-h>", "<c-w>h", { remap = true, desc = "Window » Navigate left" })
  NeoUtils.map("n", "<c-j>", "<c-w>j", { remap = true, desc = "Window » Navigate down" })
  NeoUtils.map("n", "<c-k>", "<c-w>k", { remap = true, desc = "Window » Navigate up" })
  NeoUtils.map("n", "<c-l>", "<c-w>l", { remap = true, desc = "Window » Navigate right" })
  NeoUtils.map("n", "<c-up>", ":resize +2<cr>", { desc = "Window » Height++" })
  NeoUtils.map("n", "<c-down>", ":resize -2<cr>", { desc = "Window » Height--" })
  NeoUtils.map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "Window » Width--" })
  NeoUtils.map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "Window » Width++" })
end

-- buffers
NeoUtils.map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
NeoUtils.map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
NeoUtils.map("n", "[b", ":bprevious<cr>", { desc = "Buffer » Prev" })
NeoUtils.map("n", "]b", ":bnext<cr>", { desc = "Buffer » Next" })
if NeoUtils.call("bufferline") == nil then
  NeoUtils.map("n", "<a-[>", ":bprevious<cr>", { desc = "Buffer » Prev" })
  NeoUtils.map("n", "<a-]>", ":bnext<cr>", { desc = "Buffer » Next" })
end
if NeoUtils.call("mini.bufremove") == nil then
  NeoUtils.map("n", "<leader>bd", ":bdelete<cr>", { desc = "Buffer » Delete" })
  NeoUtils.map("n", "<Leader>bD", ":bufdo bdelete<cr>", { desc = "Buffer » Delete (all)" })
end

NeoUtils.map("n", "<leader>us", function()
  NeoUtils.toggle("spell")
end, { desc = "Toggle » Spell" })
NeoUtils.map("n", "<leader>uw", function()
  NeoUtils.toggle("wrap")
end, { desc = "Toggle » Word wrap" })
NeoUtils.map("n", "<leader>uc", function()
  NeoUtils.toggle("cursorline")
end, { desc = "Toggle » Cursor line" })
NeoUtils.map("n", "<leader>un", function()
  NeoUtils.toggle("relativenumber", true)
  NeoUtils.toggle("number")
end, { desc = "Toggle » Line numbers" })

---floating terminal
local ft = function(cmd, root)
  local opt = { size = { width = 0.6, height = 0.7 }, title = "  " .. (cmd or "Terminal"), title_pos = "right" }
  opt.border = require("neoverse.config").transparent and "single" or "none"
  if root then
    opt.cwd = NeoUtils.get_root()
  end
  NeoUtils.float_term(cmd, opt)
end
NeoUtils.map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
NeoUtils.map("t", [[<c-\>]], "<cmd>close<cr>", { desc = "Float » Terminal hide" })
--stylua: ignore
NeoUtils.map("n", "<leader>fh", function() ft("btop") end, { desc = "Float » Open htop/btop" })
--stylua: ignore
NeoUtils.map("n", "<leader>fT", function() ft(nil) end, { desc = "Float » Terminal (cwd)" })
--stylua: ignore
NeoUtils.map("n", "<leader>ft", function() ft(nil, true) end, { desc = "Float » Terminal (rwd)" })
--stylua: ignore
NeoUtils.map("n", [[<c-\>]], function() ft(nil, true) end, { desc = "Float » Terminal open (rwd)" })

if not vim.g.neovide then
  NeoUtils.map("n", "<leader>fz", function()
    vim.cmd([[call system('zmux')]])
  end, { desc = "Float » Tmux Z" })
end

---lazygit
local lz = function(opts)
  NeoUtils.float_term({ "lazygit" }, {
    unpack(opts or {}),
    title_pos = "right",
    title = "  LazyGit ",
    border = "single",
    ctrl_hjkl = false,
    esc_esc = false,
  })
end
--stylua: ignore
NeoUtils.map("n", "<leader>gg", function() lz() end, { desc = "Git » Open lazygit (cwd)" })
--stylua: ignore
NeoUtils.map("n", "<leader>gG", function() lz({ cwd = NeoUtils.get_root() }) end, { desc = "Git » Open lazygit (rwd)" })
