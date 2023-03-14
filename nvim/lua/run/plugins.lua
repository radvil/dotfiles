-- @note: mapleader & maplocalleader should be set before sourcing this file!
local lazypath = rvim.path.data .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.notify("🚩 lazy.nvim was not installed, installing the latest stable version...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "folke/lazy.nvim",
  require("usr.ui"),
  require("usr.accessibility"),
  require("usr.colorscheme"),
  require("usr.lsp"),
  require("usr.completion"),
  require("usr.misc"),
  require("usr._preview"),
  ui = {
    border = "double",
  },
})

Log("Plugins init!", "^^ RUN")
