local Utils = require("neoverse.utils")

vim.g.neo_transparent = true and not vim.g.neovide
vim.g.neo_notesdir = vim.fn.expand("~") .. "/Documents/obsidian-vault"
vim.g.neo_snippet_dirs = {
  os.getenv("DOTFILES") .. "/nvim/assets/snippets/all",
  os.getenv("DOTFILES") .. "/nvim/assets/snippets/angular",
}

vim.opt.cursorline = vim.g.neo_transparent

if not Utils.lazy_has("nvim-ufo") then
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.foldtext = "v:lua.require'neoverse.utils'.ui.foldtext()"
  vim.o.formatexpr = "v:lua.require'neoverse.utils'.format.formatexpr()"
end

if not Utils.lazy_has("statuscol.nvim") then
  vim.opt.statuscolumn = [[%!v:lua.require'neoverse.utils'.ui.statuscolumn()]]
end
