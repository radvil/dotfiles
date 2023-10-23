-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- This file is automatically loaded by lazyvim.config.init
local LazyUtil = require("lazyvim.util")
local Utils = require("utils")
local Term = require("lazyvim.util.terminal")
local Root = require("lazyvim.util.root")
local Prefer = require("preferences")

local function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", {
    noremap = true,
    silent = true,
  }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

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
map({ "i", "c" }, "<a-i>", "<space><left>", { desc = "Tab backward" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch" })
map({ "n", "x", "v" }, "ga", "<esc>ggVG", { nowait = true, desc = "Select all" })
map({ "n", "x", "v" }, "Q", "q", { nowait = true, desc = "Record" })
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

if vim.opt.clipboard ~= "unnamedplus" then
  local opt = function(desc)
    return { nowait = true, desc = string.format("System clipboard » %s", desc) }
  end
  map({ "n", "o", "x", "v" }, "gy", '"+y', opt("Yank"))
  map({ "n", "o", "x", "v" }, "gp", '"+p', opt("Paste after cursor"))
  map("n", "gY", '"+y$', opt("Yank line"))
  map("n", "gP", '"+P', opt("Paste before cursor"))
end

-- Clear search, diff update and redraw
map(
  "n",
  "<leader>ur",
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

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
if Utils.call("smart-splits") == nil then
  map("n", "<c-h>", "<c-w>h", { remap = true, desc = "Window » Navigate left" })
  map("n", "<c-j>", "<c-w>j", { remap = true, desc = "Window » Navigate down" })
  map("n", "<c-k>", "<c-w>k", { remap = true, desc = "Window » Navigate up" })
  map("n", "<c-l>", "<c-w>l", { remap = true, desc = "Window » Navigate right" })
  map("n", "<c-up>", ":resize +2<cr>", { desc = "Window » Height++" })
  map("n", "<c-down>", ":resize -2<cr>", { desc = "Window » Height--" })
  map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "Window » Width--" })
  map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "Window » Width++" })
end

-- buffers
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Buffer » Switch to other" })
map("n", "[b", ":bprevious<cr>", { desc = "Buffer » Prev" })
map("n", "]b", ":bnext<cr>", { desc = "Buffer » Next" })
if Utils.call("bufferline") == nil then
  map("n", "<a-[>", ":bprevious<cr>", { desc = "Buffer » Prev" })
  map("n", "<a-]>", ":bnext<cr>", { desc = "Buffer » Next" })
end
if Utils.call("mini.bufremove") == nil then
  map("n", "<leader>bd", ":bdelete<cr>", { desc = "Buffer » Delete" })
  map("n", "<Leader>bD", ":bufdo bdelete<cr>", { desc = "Buffer » Delete (all)" })
end

-- stylua: ignore start

map("n", "<leader>us", function() LazyUtil.toggle("spell") end, { desc = "Toggle » Spell" })
map("n", "<leader>uw", function() LazyUtil.toggle("wrap") end, { desc = "Toggle » Word wrap" })
map("n", "<leader>uc", function() LazyUtil.toggle("cursorline") end, { desc = "Toggle » Cursor line" })
map("n", "<leader>un", function() LazyUtil.toggle("relativenumber", true) LazyUtil.toggle("number") end, { desc = "Toggle » Line numbers" })

---floating terminal
local ft = function(cmd, root)
  local opt = { size = { width = 0.6, height = 0.7 }, title = "  " .. (cmd or "Terminal"), title_pos = "right" }
  opt.border = Prefer.transparent and "single" or "none"
  if root then opt.cwd = Root.get() end
  Term.open(cmd, opt)
end
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
map("t", [[<c-\>]], "<cmd>close<cr>", { desc = "Float » Terminal hide" })
map("n", "<leader>fh", function() ft("btop") end, { desc = "Float » Open htop/btop" })
map("n", "<leader>fT", function() ft(nil) end, { desc = "Float » Terminal (cwd)" })
map("n", "<leader>ft", function() ft(nil, true) end, { desc = "Float » Terminal (rwd)" })
map("n", [[<c-\>]], function() ft(nil, true) end, { desc = "Float » Terminal open (rwd)" })

-- stylua: ignore end

if not vim.g.neovide then
  map("n", "<leader>fz", function()
    vim.cmd([[call system('zmux')]])
  end, { desc = "Float » Tmux Z" })
end

---lazygit
local lz = function(opts)
  Term.open({ "lazygit" }, {
    unpack(opts or {}),
    title_pos = "right",
    title = "  LazyGit ",
    border = "single",
    ctrl_hjkl = false,
    esc_esc = false,
  })
end

--stylua: ignore start
map("n", "<leader>gg", function() lz() end, { desc = "Git » Open lazygit (cwd)" })
map("n", "<leader>gG", function() lz({ cwd = Root.get() }) end, { desc = "Git » Open lazygit (rwd)" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

if not LazyUtil.has("trouble.nvim") then
  map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
  map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- formatting
map({ "n", "v" }, "<leader>cf", function() LazyUtil.format({ force = true }) end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- toggle options
map("n", "<leader>uf", function() LazyUtil.format.toggle() end, { desc = "Toggle auto format (global)" })
map("n", "<leader>uF", function() LazyUtil.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
map("n", "<leader>us", function() LazyUtil.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() LazyUtil.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>uL", function() LazyUtil.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
map("n", "<leader>ul", function() LazyUtil.toggle.number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", function() LazyUtil.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
map("n", "<leader>uC", function() LazyUtil.toggle("cursorline") end, { desc = "Toggle Cursor line" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() LazyUtil.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
if vim.lsp.inlay_hint then
  map("n", "<leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
end

-- lazygit
map("n", "<leader>gg", function() LazyUtil.terminal({ "lazygit" }, { cwd = LazyUtil.root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function() LazyUtil.terminal({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- LazyVim Changelog
map("n", "<leader>L", function() LazyUtil.news.changelog() end, { desc = "LazyVim Changelog" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- tabs
map("n", "[t", ":tabprevious<cr>", { desc = "Tab » Prev" })
map("n", "]t", ":tabnext<cr>", { desc = "Tab » Next" })
map("n", "<leader>tn", ":tabnew<cr>", { desc = "Tab » New" })
map("n", "<leader>td", ":tabclose<cr>", { desc = "Tab » Delete" })
