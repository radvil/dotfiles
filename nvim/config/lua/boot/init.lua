---@class NgVimSpec
local M = {}

M.name = "NgVim"

M.version = ">= 0.0.1"

---@class NgVimConfig
M.opts = {
  leaderKey = " ",
  localLeaderKey = " ",
  path = rvim.path.data .. "/lazy/lazy.nvim",
}

---@param opts? NgVimConfig
function M.setup(opts)
  M.opts = vim.tbl_extend("force", M.opts, opts or {})

  vim.g.mapleader = M.opts.leaderKey or " "
  vim.g.maplocalleader = M.opts.localLeaderKey or " "

  if not vim.loop.fs_stat(M.opts.path) then
    vim.notify("🚩 lazy.nvim was not installed, installing the latest stable version...")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      M.opts.path,
    })
  end

  vim.opt.rtp:prepend(M.opts.path)

  require("boot.lazy-nvim").setup()

  Log("Bootstraping plugins...", "^^ BOOT")
end

return M
