---@diagnostic disable: undefined-field
-- GLOBALS
vim.opt.background = "dark"
vim.g.neo_transparent = true
vim.g.neo_winborder = vim.g.neo_transparent and "single" or "none"
vim.g.neo_autocomplete = true
vim.g.neo_autopairs = false
vim.g.neo_autoformat = false
-- TODO: This is for telescope param, probably should refactor...
vim.g.neo_notesdir = os.getenv("HOME") .. "/Documents/obsidian-vault"

vim.g.deprecation_warnings = false

vim.opt.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.laststatus = 3
vim.opt.smoothscroll = true
vim.opt.autowrite = true
vim.opt.cursorline = false
vim.opt.mouse = "nv"
vim.opt.mousemoveevent = true
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

vim.o.formatexpr = "v:lua.Lonard.format.formatexpr()"

-- Folding
vim.opt.foldlevel = 99

if not Lonard.lazy_has("nvim-ufo") then
  vim.opt.foldexpr = "v:lua.Lonard.ui.foldexpr()"
  vim.opt.foldmethod = "expr"
  vim.opt.foldtext = ""
end

if vim.opt.signcolumn:get() == "yes" and not Lonard.lazy_has("statuscol.nvim") then
  vim.opt.statuscolumn = [[%!v:lua.Lonard.ui.statuscolumn()]]
end

if vim.g.neovide then
  ---@type "" | "railgun" | "torpedo" | "pixiedust" | "sonicboom" | "ripple" | "wireframe"
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_hide_mouse_when_typing = true
  if vim.g.neo_transparent then
    vim.g.neovide_transparency = 0.93
    vim.g.neo_transparent = false
  end
  vim.opt.guifont = { "JetbrainsMono Nerd Font", ":h10" }
  vim.opt.guicursor =
    "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff500-blinkon500,sm:block-blinkwait500-blinkoff500-blinkon500"
end
