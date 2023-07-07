local M = {}

function M.bootstrap(on_init)
  local Vars = require("rad.core.vars")
  local Utils = require("rad.core.utils")
  local plugins_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  Vars.setup(" ")

  if not vim.loop.fs_stat(plugins_path) then
    Utils.log("🚩 lazy.nvim was not installed. Installing from latest stable version...", {
      severity = vim.log.levels.WARN,
      title = "BOOTSRAP",
    })

    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      plugins_path,
    })
  end

  vim.opt.rtp:prepend(plugins_path)

  on_init(Vars.lazy_opts())
end

return M
