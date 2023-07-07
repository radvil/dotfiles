---@diagnostic disable: redefined-local
local disabled_builtin_plugins = {
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "matchit",
  "matchparen",
  "logiPat",
  "rrhelper",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
}

local disabled_builtin_providers = {
  "perl",
  "python3",
  "ruby",
}

local palette = {
  bg = "#1A1B23",
  fg = "#ffffff",
  blue = "#51AFEF",
  cyan = "#0DB9D7",
  green = "#6DD390",
  orange = "#FF855A",
  red = "#EC5F67",
  pink = "#E76EB1",
  magenta = "#C678DD",
  violet = "#A9A1E1",
  yellow = "#ffc777",
  gold = "#e0af68",
}

---@param leader_key string
local setup = function(leader_key)
  local ok, plenary_reload = pcall(require, "plenary.reload")
  local reloader = require
  if ok then
    reloader = plenary_reload.reload_module
  end

  P = function(v)
    print(vim.inspect(v))
    return v
  end

  RELOAD = function(...)
    local ok, plenary_reload = pcall(require, "plenary.reload")
    if ok then
      reloader = plenary_reload.reload_module
    end
    return reloader(...)
  end

  R = function(name)
    RELOAD(name)
    return require(name)
  end

  for _, value in ipairs(disabled_builtin_providers) do
    vim.cmd(string.format("let g:loaded_%s_provider = 0", value))
  end

  vim.g.mapleader = leader_key or " "
end

local get_lazy_opts = function()
  local Icon = require("rad.core.icons").Common
  local title = string.format(" %s %s ", Icon.Vim, "Neovim")
  return {
    ui = {
      size = { width = 0.8, height = 0.8 },
      title_pos = "right",
      border = "none",
      title = title,
      change_detection = {
        enabled = true,
        notify = false,
      },
      icons = {
        cmd = Icon.CmdOutlined,
        config = Icon.Cog,
        event = Icon.Flash,
        ft = Icon.File,
        init = Icon.Start,
        import = Icon.Import,
        keys = Icon.Keys,
        lazy = Icon.Lazy,
        loaded = Icon.Bullet,
        not_loaded = Icon.BulletOutlined,
        plugin = Icon.Package,
        runtime = Icon.Vim,
        source = Icon.Source,
        start = Icon.Check,
        task = Icon.Calendar,
        list = {
          Icon.Bullet,
          Icon.ArrowRight,
          Icon.Star,
          "‒",
        },
      },
    },
    install = {
      missing = true,
      colorscheme = {
        "catppuccin",
        "habamax",
      },
    },
    performance = {
      cache = { enabled = true },
      rtp = {
        disabled_plugins = disabled_builtin_plugins,
      },
    },
  }
end

return {
  setup = setup,
  palette = palette,
  lazy_opts = get_lazy_opts,
}
