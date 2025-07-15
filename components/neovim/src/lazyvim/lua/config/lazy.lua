---@diagnostic disable: assign-type-mismatch, undefined-field, duplicate-set-field

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
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

local Icons = {
  ArrowRight = "",
  Bullet = "●",
  BulletOutlined = "○",
  Calendar = "",
  Check = "✔ ",
  CmdOutlined = " ",
  Cog = " ",
  Flash = "",
  File = " ",
  Import = " ",
  Keys = " ",
  Lazy = "󰒲 ",
  Package = " ",
  Source = " ",
  Star = "★",
  Start = "",
  Vim = " ",
}

---@class NeoOptions: LazyConfig
local M = {}

---@class NeoOptions
local defaults = {
  dev = {
    path = "~/Projects/linuxdev/neovim",
    fallback = false,
  },
  spec = {
    "folke/lazy.nvim",
  },
  defaults = {
    lazy = false,
    version = false,
    silence_keymaps = true,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  install = {
    missing = true,
    colorscheme = {
      "catppuccin",
      "tokyonight",
      "habamax",
    },
  },
  checker = {
    enabled = false,
  },
  ui = {
    wrap = true,
    size = { width = 0.8, height = 0.8 },
    title = Icons.Vim .. "NeoConfig",
    border = "single",
    backdrop = 60,
    title_pos = "right",
    icons = {
      cmd = Icons.CmdOutlined,
      config = Icons.Cog,
      event = Icons.Flash,
      ft = Icons.File,
      init = Icons.Start,
      import = Icons.Import,
      keys = Icons.Keys,
      lazy = Icons.Lazy,
      loaded = Icons.Bullet,
      not_loaded = Icons.BulletOutlined,
      plugin = Icons.Package,
      runtime = Icons.Vim,
      source = Icons.Source,
      start = Icons.Check,
      task = Icons.Calendar,
      list = {
        Icons.Bullet,
        Icons.ArrowRight,
        Icons.Star,
        "‒",
      },
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "bugreport",
        "compiler",
        "ftplugin",
        "fzf",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        "optwin",
        "rplugin",
        "rrhelper",
        "spellfile_plugin",
        "synmenu",
        "syntax",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "ruby",
        "gem",
      },
    },
  },

  -- custom options
  providers_blacklist = {},
}

---@type NeoOptions
local options

---@param opts NeoOptions
function M.bootstrap(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}
  if options.defaults.silence_keymaps then
    local keymap_set = vim.keymap.set
    vim.keymap.set = function(mode, lhs, rhs, kopts)
      kopts = kopts or {}
      kopts.silent = kopts.silent ~= false
      return keymap_set(mode, lhs, rhs, kopts)
    end
  end
  for _, value in ipairs(options.providers_blacklist) do
    vim.cmd(string.format("let g:loaded_%s_provider = 0", value))
  end
  require("lazy").setup(options)
end

setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      return vim.deepcopy(defaults)[key]
    end
    ---@cast options NeoOptions
    return options[key]
  end,
})

return M
