---@diagnostic disable: assign-type-mismatch
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

---@diagnostic disable: missing-fields
-- reset
map({ "n", "x", "v" }, "<nL>", "<nop>")
-- map("", "<c-z>", ":undo<cr>", { nowait = true })
map("n", "Q", "q", { nowait = true, desc = "toggle recording" })
map("n", "<a-q>", "<nop>")
map("n", "q", "<nop>")

-- base
map("v", "<", "<gv", { desc = "indent left" })
map("v", ">", ">gv", { desc = "indent right" })
map("n", "U", "<c-r>", { nowait = true, desc = "redo" })
map("n", "ZZ", ":conf qa<cr>", { nowait = true, desc = "quit all +confirmation" })
map("n", "<a-cr>", "o<esc>", { desc = "add one line down" })
map("i", "<c-h>", "<left>", { desc = "shift one char left" })
map("i", "<c-l>", "<right>", { desc = "shift one char right" })
map({ "i", "c" }, "<a-bs>", "<esc>ciw", { nowait = true, desc = "delete backward" })
map({ "i", "c" }, "<a-i>", "<space><left>", { desc = "tab backward" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "clear hlsearch" })
map({ "n", "x", "v" }, "ga", "<esc>ggVG", { nowait = true, desc = "select all" })
map({ "n", "x", "o" }, "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "next search result" })
map({ "n", "x", "o" }, "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "prev search result" })

-- stylua: ignore start

-- formatting
map({ "n", "v" }, "<leader>cf", function() LazyVim.format({ force = true }) end, { desc = "code [f]ormat" })
LazyVim.format.snacks_toggle():map("<leader>uf")
LazyVim.format.snacks_toggle(true):map("<leader>uF")

-- diagnostic
local diagnostic_goto = function(next, severity)
  local count = next and 1 or -1
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    vim.diagnostic.jump({ count = count, severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "code line [d]iagnostics" })
map({ "n", "v", "x" }, "]d", diagnostic_goto(true), { desc = "go to next [d]iagnostic" })
map({ "n", "v", "x" }, "[d", diagnostic_goto(false), { desc = "go to prev [d]iagnostic" })
map({ "n", "v", "x" }, "]e", diagnostic_goto(true, "ERROR"), { desc = "go to next [e]rror" })
map({ "n", "v", "x" }, "[e", diagnostic_goto(false, "ERROR"), { desc = "go to prev [e]rror" })
map({ "n", "v", "x" }, "]w", diagnostic_goto(true, "WARN"), { desc = "go to next [w]arning" })
map({ "n", "v", "x" }, "[w", diagnostic_goto(false, "WARN"), { desc = "go to prev [w]arning" })

-- clipboard
if vim.opt.clipboard ~= "unnamedplus" then
  map({ "n", "o", "x", "v" }, "gy", '"+y', { desc = "yank from system clipboard (system)", nowait = true })
  map({ "n", "o", "x", "v" }, "gp", '"+p', { desc = "paste from system clipboard (system)", nowait = true })
  map("n", "gY", '"+y$', { desc = "yank to end of line (system)", nowait = true })
  map("n", "gP", '"+P', { desc = "paste before cursor (system)", nowait = true })
end

-- Clear search, diff update and redraw
map( "n", "<leader>ur", "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>", { desc = "redraw / update ui" })

-- swap lines
map("n", "<A-k>", ":m .-2<cr>==", { desc = "swap current line up" })
map("n", "<A-j>", ":m .+1<cr>==", { desc = "swap current line down" })
map("i", "<A-j>", "<esc>:m .+1<cr>==gi", { desc = "swap current line down" })
map("i", "<A-k>", "<esc>:m .-2<cr>==gi", { desc = "swap current line up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "swap selected lines up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "swap selected lines down" })

-- windows
map("n", "<leader>ww", "<c-w>p", { desc = "last used window" })
map("n", "<leader>wd", "<c-w>c", { desc = "delete current window" })
if not LazyVim.has("smart-splits.nvim") then
  map("n", "<c-h>", "<c-w>h", { remap = true, desc = "go to left window" })
  map("n", "<c-j>", "<c-w>j", { remap = true, desc = "go to down window" })
  map("n", "<c-k>", "<c-w>k", { remap = true, desc = "go to up window" })
  map("n", "<c-l>", "<c-w>l", { remap = true, desc = "go to right window" })
  map("n", "<c-up>", ":resize +2<cr>", { desc = "window height+1" })
  map("n", "<c-down>", ":resize -2<cr>", { desc = "window height-1" })
  map("n", "<c-left>", ":vertical resize -2<cr>", { desc = "window width-1" })
  map("n", "<c-right>", ":vertical resize +2<cr>", { desc = "window width+1" })
end

---buffers
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "go to recent buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "go to recent [b]uffer" })
map("n", "[b", ":bprevious<cr>", { desc = "prev[ous buffer" })
map("n", "]b", ":bnext<cr>", { desc = "n]xt buffer" })

map("n", "<leader>bd", function ()
  Snacks.bufdelete()
end, { desc = "[d]elete buffer" })
map("n", "<Leader>bD", "<cmd>:bd<cr>", { desc = "[D]elete buffer+window" })
if not LazyVim.has("bufferline.nvim") then
  map("n", "<a-[>", ":bprevious<cr>", { desc = "prev[ous buffer" })
  map("n", "<a-]>", ":bnext<cr>", { desc = "n]xt buffer" })
end

-- quickfix
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- toggle options
Snacks.toggle.option("spell", { name = "Spelling"}):map("<leader>us")
Snacks.toggle.option("wrap", {name = "Wrap"}):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number"}):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("conceallevel", {off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2}):map("<leader>uc")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark" , name = "Dark Background"}):map("<leader>ub")
if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
  map("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
  map("n", "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
  map("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
  map("n", "<leader>gl", function() Snacks.lazygit.log({ cwd = LazyVim.root.git() }) end, { desc = "Lazygit Log" })
  map("n", "<leader>gL", function() Snacks.lazygit.log() end, { desc = "Lazygit Log (cwd)" })
end

-- floating terminal
map("n", "<c-/>",      function() Snacks.terminal({ cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
map("n", "<c-_>",      function() Snacks.terminal({ cwd = vim.uv.cwd() }) end, { desc = "which_key_ignore" })

local ft = function(cmd, root)
  local label = (type(cmd) == "table" and cmd[1] or cmd) or "Terminal"
  local opt = { size = { width = 0.8, height = 0.8 }, title = "  " .. label, title_pos = "right" }
  if root then opt.cwd = LazyVim.root.get() end
  Snacks.terminal.toggle(cmd, opt)
end
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
map({ "n", "t" }, [[<c-\>]], function() ft(nil) end, { desc = [[toggle term[\]nal (cwd)]] })
map("n", "<leader>tN", function() ft(nil) end, { desc = "[N]ew terminal (cwd)" })
map("n", "<leader>tn", function() ft(nil, true) end, { desc = "[n]ew terminal (root)" })
map("n", "<leader>tH", function() ft("btop") end, { desc = "run [H]top" })
map("n", "<leader>tP", function() ft({ "ping", "9.9.9.9" }) end, { desc = "run [P]ing test" })

---@param scope 'session' | 'window'
local tmux_run = function(scope)
  scope = scope or "window"
  vim.ui.input({
    prompt = string.format("Run in a new tmux %s: ", scope),
    completion = "file_in_path", -- :h command-completion
    default = "",
  }, function(value)
    if not value then
      LazyVim.warn("Canceled", {
        title = "Run Command",
        icon = " ",
      })
    else
      local prefix = scope == "window" and "cmdw" or "cmds"
      local name = prefix .. " " .. value
      vim.cmd(string.format("call system('%s')", name))
    end
  end)
end

-- stylua: ignore start
vim.api.nvim_create_user_command("Cmds", function() tmux_run("session") end, { desc = "run command inside new tmux [s]ession" })
vim.api.nvim_create_user_command("Cmdw", function() tmux_run("window") end, { desc = "run command inside new tmux [w]indow" })
map("n", "<leader>tS", function() tmux_run("session") end, { desc = "run command in new tmux [s]ession" })
map("n", "<leader>tW", function() tmux_run("window") end, { desc = "run command in new tmux [w]indow" })
-- stylua: ignore end

-- experimental keymap
map({ "n", "x", "v", "o" }, "H", "^", { desc = "start of line (non blank)" })
map({ "n", "x", "v", "o" }, "L", "$", { desc = "end of the line" })
map({ "n", "x", "v" }, "s", "<nop>", { remap = true, desc = "[reset]" })
map({ "n", "i", "x", "v", "s", "o", "c" }, "<a-q>", "<esc>", { desc = "[esc]" })
map({ "n", "i", "s", "o" }, "<a-space>", "<esc>", { desc = "[esc] with space" })
map({ "i", "n" }, "<c-s>", "<cmd>write<cr>", { desc = "save changes" })
map("n", "ZZ", ":conf qa<cr>", { desc = "+confirm quit all" })
map("n", "Zt", ":tabclose<cr>", { desc = "quit [t]ab" })
map("n", "Zb", "<cmd>BD<cr>", { desc = "quit [b]uffer" })
map("n", "ZB", "<cmd>BAD<cr>", { desc = "quit [B]uffers" })
map("n", "Zw", "<c-w>c", { desc = "quit [w]indow" })
map("n", "Zf", ":fclose<cr>", { desc = "quit [f]loating window" })

if not vim.g.neovide then
  map("n", "<leader>fz", function()
    vim.cmd([[call system('zmux')]])
  end, { desc = "[z]mux" })
end

-- toggle autocomplete
map("n", "<leader>uC", function()
  local next = not vim.g.neo_autocomplete
  vim.g.neo_autocomplete = next
  vim.cmd.Lazy("load nvim-cmp")
  if next then
    LazyVim.info("Code completion set to auto", { title = "Code completion" })
  else
    LazyVim.warn("Code completion set to manual", { title = "Code completion" })
  end
end, { desc = "toggle code [C]ompletion" })

-- toggle transparency
map("n", "<leader>uT", function()
  LazyVim.try(function()
    local colors_name = vim.g.colors_name
    for _, value in ipairs({
      "tokyonight",
      "catppuccin",
      "monokai-pro",
      "kanagawa",
      "onedark",
      "material",
      "rose-pine",
    }) do
      if string.match(colors_name, value) then
        vim.g.neo_transparent = not vim.g.neo_transparent
        vim.cmd.Lazy("reload " .. value)
        vim.schedule(function()
          vim.cmd.colorscheme(colors_name)
        end)
        break
      end
    end
  end)
end, { desc = "toggle transparent background" })

-- toggle dim
map("n", "<leader>uD", function()
  LazyVim.try(function()
    local colors_name = vim.g.colors_name
    for _, value in ipairs({
      "tokyonight",
      "catppuccin",
      "monokai-pro",
      "kanagawa",
      "onedark",
      "material",
      "rose-pine",
    }) do
      if string.match(colors_name, value) then
        vim.g.neo_diminactive = not vim.g.neo_diminactive
        vim.cmd.Lazy("reload " .. value)
        vim.schedule(function()
          vim.cmd.colorscheme(colors_name)
        end)
        break
      end
    end
  end)
end, { desc = "toggle transparent background" })

if LazyVim.has("mini.map") then
  for _, key in ipairs({ "n", "N", "*", "#" }) do
    map("n", key, key .. "<Cmd>lua require('mini.map').refresh({}, {lines = false, scrollbar = false})<CR>")
  end
end
