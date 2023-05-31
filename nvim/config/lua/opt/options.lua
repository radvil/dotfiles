local opt = vim.opt

opt.wrap = false     -- Disable line wrap
opt.autowrite = true -- Enable auto write
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true    -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true  -- Use spaces instead of tabs
-- opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true      -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.list = true            -- Show some invisible characters (tabs...
opt.mouse = "a"            -- Enable mouse mode
opt.number = true          -- Print line number
opt.pumblend = 0           -- Popup blend
opt.pumheight = 10         -- Maximum number of entries in a popup
opt.cmdheight = 1
opt.relativenumber = true  -- Relative line numbers
opt.scrolloff = 4          -- Lines of context
opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
}
opt.shiftround = true -- Round indent
opt.shiftwidth = 2    -- Size of an indent
opt.shortmess:append({
  W = true,
  I = true,
  c = true,
})
opt.showmode = false     -- Dont show mode since we have a statusline
opt.sidescrolloff = 8    -- Columns of context
opt.signcolumn = "yes"   -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true     -- Don't ignore case with capitals
opt.smartindent = true   -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true    -- Put new windows below current
opt.splitright = true    -- Put new windows right of current
opt.tabstop = 2          -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 7                -- Minimum window width
opt.hidden = true                  -- for toggleterm
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  fold = " ",
  diff = "╱",
  eob = " ",
}

vim.g.markdown_recommended_style = 0
vim.o.winwidth = 7
vim.o.winminwidth = 5
vim.o.equalalways = false
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

if os.getenv("TMUX") == nil then
  opt.timeoutlen = 460
else
  opt.timeoutlen = 200
end

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
  vim.o.foldcolumn = "1"
end

Log("Options loaded!", "^^ OPT")
