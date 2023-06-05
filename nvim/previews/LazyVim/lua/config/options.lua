-- options are automatically loaded before lazy.nvim startup
-- default options that are always set: https://github.com/lazyvim/lazyvim/blob/main/lua/lazyvim/config/options.lua

vim.opt.winwidth = 7
vim.opt.winminwidth = 5
vim.opt.equalalways = false
vim.opt.foldlevel = 99
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
vim.opt.timeoutlen = os.getenv("TMUX") == nil and 460 or 200
vim.opt.guicursor = ""
