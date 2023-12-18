local Utils = require("neoverse.utils")

vim.opt.autowrite = true
vim.opt.cursorline = true
-- vim.opt.hidden = false
-- vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.signcolumn = "no" -- "yes" to always show the signcolumn, otherwise it would shift the text each time
vim.opt.virtualedit = "block" -- "block" to allow cursor to move where there is no text in visual block mode
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.sessionoptions = {
  "tabpages",
  "winsize",
  "globals",
  "skiprtp",
  "buffers",
  "curdir",
  "folds",
  "help",
}

vim.g.neo_transparent = true and not vim.g.neovide
vim.g.neo_notesdir = vim.fn.expand("~") .. "/Documents/obsidian-vault"
vim.g.neo_snippet_dirs = {
  os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
  os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
}

if not Utils.lazy_has("nvim-ufo") then
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.foldtext = "v:lua.require'neoverse.utils'.ui.foldtext()"
  vim.o.formatexpr = "v:lua.require'neoverse.utils'.format.formatexpr()"
end

if not Utils.lazy_has("statuscol.nvim") then
  vim.opt.statuscolumn = [[%!v:lua.require'neoverse.utils'.ui.statuscolumn()]]
end
