---@class NgVimSpec
local M = {}
M.name = "NgVim"
M.version = ">= 0.0.1"

function M.setup()
  vim.g.mapleader = rnv.opt.mapleader or " "
  vim.g.maplocalleader = rnv.opt.maplocalleader or " "

  if not vim.loop.fs_stat(rnv.opt.data) then
    vim.notify("🚩 lazy.nvim was not installed, installing the latest stable version...")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      rnv.opt.data,
    })
  end

  vim.opt.rtp:prepend(rnv.opt.data)

  require("boot.lazy-nvim").setup()
  rnv.api.log("Bootstraping plugins...", "BOOT")
end

M.setup()

return M
