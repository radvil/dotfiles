local M = {}

local options = {
  dev = false,
  name = "Neo",
  mapleader = " ",
  maplocalleader = [[\]],
  username = os.getenv("USER"),
  providers_blacklist = {
    "perl",
    "python3",
    "ruby",
  },
}

local function get_lazy_opts()
  local icon = require("icons").Common
  local title = string.format(" %s %s ", icon.Vim, options.name)
  return {
    -- directory where plugins will be installed
    root = vim.fn.stdpath("data") .. "/" .. options.username,
    defaults = {
      lazy = not options.dev,
    },
    dev = {
      path = "~/Projects",
      fallback = false,
    },
    ui = {
      size = { width = 0.8, height = 0.8 },
      wrap = true,
      border = "single",
      title = title,
      title_pos = "right",
      icons = {
        cmd = icon.CmdOutlined,
        config = icon.Cog,
        event = icon.Flash,
        ft = icon.File,
        init = icon.Start,
        import = icon.Import,
        keys = icon.Keys,
        lazy = icon.Lazy,
        loaded = icon.Bullet,
        not_loaded = icon.BulletOutlined,
        plugin = icon.Package,
        runtime = icon.Vim,
        source = icon.Source,
        start = icon.Check,
        task = icon.Calendar,
        list = {
          icon.Bullet,
          icon.ArrowRight,
          icon.Star,
          "‒",
        },
      },
    },
    install = {
      missing = true,
      colorscheme = {
        "catppuccin",
        "monokai-pro",
      },
    },
    performance = {
      cache = { enabled = true },
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
  }
end

local function log(msg, opts)
  opts = vim.tbl_deep_extend("force", {
    severity = vim.log.levels.INFO,
    title = "LOG",
  }, opts or {}) or {}
  local title = string.format("[%s]", opts.title)
  local hl = opts.severity == vim.log.levels.INFO and "Type" or "Label"
  vim.api.nvim_echo({
    { title, hl },
    { " » " .. msg },
  }, true, {})
end

function M.bootstrap(on_init)
  vim.g.mapleader = options.mapleader
  vim.g.maplocalleader = options.maplocalleader

  -- make all keymaps silent by default
  local keymap_set = vim.keymap.set

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.keymap.set = function(mode, lhs, rhs, kopts)
    kopts = kopts or {}
    kopts.silent = kopts.silent ~= false
    return keymap_set(mode, lhs, rhs, kopts)
  end

  for _, value in ipairs(options.providers_blacklist) do
    vim.cmd(string.format("let g:loaded_%s_provider = 0", value))
  end

  local userpath = string.format("/%s/lazy.nvim", options.username)
  local path = vim.fn.stdpath("data") .. userpath

  if not vim.loop.fs_stat(path) then
    log("🚩 lazy.nvim was not installed. Installing from latest stable version...", {
      severity = vim.log.levels.WARN,
      title = "BOOTSRAP",
    })

    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      path,
    })
  end

  vim.opt.rtp:prepend(path)

  on_init(get_lazy_opts())
end

return M
