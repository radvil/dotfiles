local Utils = require("neoverse.utils")

vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.mouse = "nv" -- enable mouse on 'normal' and 'visual mode' only
vim.opt.mousemoveevent = true
vim.opt.conceallevel = 3 -- Hide * markup for bold and italic
vim.opt.signcolumn = "yes" -- avoid gitsigns error ??
vim.opt.virtualedit = "block" -- "block" to allow cursor to move where there is no text in visual block mode
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.sessionoptions = {
  "tabpages",
  "winsize",
  "globals",
  "skiprtp",
  "buffers",
  "folds",
  "help",
}

if not Utils.lazy_has("nvim-ufo") then
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.foldtext = "v:lua.require'neoverse.utils'.ui.foldtext()"
  vim.o.formatexpr = "v:lua.require'neoverse.utils'.format.formatexpr()"
end

if vim.opt.signcolumn:get() == "yes" and not Utils.lazy_has("statuscol.nvim") then
  vim.opt.statuscolumn = [[%!v:lua.require'neoverse.utils'.ui.statuscolumn()]]
end

-- GLOBALS
vim.g.neo_transparent = true
vim.g.neo_autocomplete = false
