local M = {}

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

function M.defaults()
  ---@class NeoConfigOptions
  return {
    -- directory where plugins will be installed
    root = vim.fn.stdpath("data") .. "/" .. os.getenv("USER"),
    dev = { path = "~/Projects/linuxdev/neovim", fallback = false },
    defaults = { lazy = false },
    ui = {
      wrap = true,
      size = { width = 0.8, height = 0.8 },
      title = Icons.Vim .. "NeoConfig",
      border = vim.g.neo_transparent and "rounded" or "none",
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
    change_detection = {
      enabled = true,
      notify = false,
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
    -- my custom options
    providers_blacklist = {},

    spec = {
      "folke/lazy.nvim",
    },
  }
end

---@type NeoConfigOptions
local options

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

function M.bootstrap(opts)
  -- make all keymaps silent by default
  local keymap_set = vim.keymap.set

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.keymap.set = function(mode, lhs, rhs, kopts)
    kopts = kopts or {}
    kopts.silent = kopts.silent ~= false
    return keymap_set(mode, lhs, rhs, kopts)
  end

  local userpath = string.format("/%s/lazy.nvim", os.getenv("USER"))
  local path = vim.fn.stdpath("data") .. userpath

  if not vim.uv.fs_stat(path) then
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

  options = vim.tbl_deep_extend("force", M.defaults(), opts or {}) or {}

  for _, value in ipairs(options.providers_blacklist) do
    vim.cmd(string.format("let g:loaded_%s_provider = 0", value))
  end

  require("lazy").setup(options)
end

return M
