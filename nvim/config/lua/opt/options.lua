vim.opt.wrap = false     -- Disable line wrap
vim.opt.autowrite = true -- Enable auto write
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.confirm = true    -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.expandtab = true  -- Use spaces instead of tabs
-- opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true      -- Ignore case
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.list = true            -- Show some invisible characters (tabs...
vim.opt.mouse = "a"            -- Enable mouse mode
vim.opt.number = true          -- Print line number
vim.opt.pumblend = 0           -- Popup blend
vim.opt.pumheight = 10         -- Maximum number of entries in a popup
vim.opt.cmdheight = 1
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.scrolloff = 4          -- Lines of context
vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
}
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2    -- Size of an indent
vim.opt.shortmess:append({
  W = true,
  I = true,
  c = true,
})
vim.opt.showmode = false     -- Dont show mode since we have a statusline
vim.opt.sidescrolloff = 8    -- Columns of context
vim.opt.signcolumn = "yes"   -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true     -- Don't ignore case with capitals
vim.opt.smartindent = true   -- Insert indents automatically
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true    -- Put new windows below current
vim.opt.splitright = true    -- Put new windows right of current
vim.opt.tabstop = 2          -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.guicursor = ""
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200               -- Save swap file and trigger CursorHold
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 7                -- Minimum window width
vim.opt.hidden = true                  -- for toggleterm
vim.opt.fillchars = {
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
  vim.opt.timeoutlen = 460
else
  vim.opt.timeoutlen = 200
end

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess:append({ C = true })
  vim.o.foldcolumn = "1"
end

Log("Options loaded!", "^^ OPT")
