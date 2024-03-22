local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- make all keymaps silent by default
local keymap_set = vim.keymap.set

---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, kopts)
  kopts = kopts or {}
  kopts.silent = kopts.silent ~= false
  return keymap_set(mode, lhs, rhs, kopts)
end

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      dev = true,
      opts = {
        colorscheme = function()
          require("tokyonight").load()
        end,
        defaults = {
          autocmds = true,
          keymaps = false,
        },
        news = {
          lazyvim = false,
          neovim = true,
        },
        misc = {
          dots = "󰇘",
        },
      },
    },
    { import = "plugins.colorschemes" },
    { import = "plugins.completion" },
    { import = "plugins.finder" },
    { import = "plugins.window" },
    { import = "plugins.editor" },
    { import = "plugins.ui-ux" },
    { import = "plugins.misc" },
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = {
    -- if a plugin's spec set to `dev` this dir is used
    path = "~/Projects/linuxdev/neovim",
    fallback = false,
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = {
      "tokyonight",
      "catppuccin",
      "monokai-pro",
      "habamax",
    },
  },
  checker = {
    enabled = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
