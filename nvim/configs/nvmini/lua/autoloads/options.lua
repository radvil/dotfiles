-- GLOBALS
vim.g.neo_transparent = false
-- vim.g.neo_winborder = not vim.g.neovide and "single" or "none"
vim.g.neo_winborder = vim.g.neo_transparent and "single" or "none"
vim.g.neo_autocomplete = true
vim.g.neo_autopairs = false
vim.g.neo_autoformat = false
-- TODO: This is for telescope param, probably should refactor...
vim.g.neo_notesdir = os.getenv("HOME") .. "/Documents/obsidian-vault"

-- options
-- vim.opt.guicursor = ""
vim.opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.laststatus = 3
vim.opt.smoothscroll = true
vim.opt.autowrite = true
vim.opt.cursorline = false
vim.opt.mouse = "nv" -- enable mouse on 'normal' and 'visual mode' only
vim.opt.mousemoveevent = true
vim.opt.conceallevel = 3
vim.opt.signcolumn = "yes" -- avoid gitsigns error ??
vim.opt.virtualedit = "block" -- "block" to allow cursor to move where there is no text in visual block mode
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.sessionoptions = {
  "tabpages",
  "winsize",
  "globals",
  "skiprtp",
  "buffers",
  -- "folds",
  "help",
}

if vim.g.neo_transparent then
  vim.opt.background = "dark"
end

if not Lonard.lazy_has("nvim-ufo") then
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.foldtext = "v:lua.require'neoverse.utils'.ui.foldtext()"
  vim.o.formatexpr = "v:lua.require'neoverse.utils'.format.formatexpr()"
end

if vim.opt.signcolumn:get() == "yes" and not Lonard.lazy_has("statuscol.nvim") then
  vim.opt.statuscolumn = [[%!v:lua.require'neoverse.utils'.ui.statuscolumn()]]
end

if vim.g.neovide then
  ---@type "railgun" | "torpedo" | "pixiedust" | "sonicboom" | "ripple" | "wireframe"
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_animate_command_line = false
  if vim.g.neo_transparent then
    vim.g.neo_transparent = false
  end
  vim.opt.guifont = { "JetbrainsMono Nerd Font", ":h10" }
end
