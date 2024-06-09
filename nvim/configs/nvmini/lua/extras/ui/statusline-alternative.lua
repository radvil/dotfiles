---@diagnostic disable: undefined-field
local icons = require("icons")

local colors = {
  bg = "#1A1B23",
  fg = "#ffffff",
  blue = "#51afef",
  cyan = "#8AD3C8",
  darkblue = "#081633",
  green = "#6DD390",
  magenta = "#c678dd",
  orange = "#FF8800",
  red = "#ec5f67",
  pink = "#E76EB1",
  violet = "#a9a1e1",
  yellow = "#ECBE7B",
}

local vmodecolor = {
  n = colors.red,
  i = colors.green,
  v = colors.orange,
  [""] = colors.orange,
  V = colors.orange,
  c = colors.magenta,
  no = colors.red,
  s = colors.pink,
  S = colors.pink,
  [""] = colors.pink,
  ic = colors.cyan,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.blue,
  ce = colors.blue,
  r = colors.magenta,
  rm = colors.magenta,
  ["r?"] = colors.magenta,
  ["!"] = colors.red,
  t = colors.red,
}

local custom_labels = {
  angularls = "Angular Language Service",
  lua_ls = "Lua Language Service",
}

local bgcolor = colors.bg

local is_buffer_not_empty = function()
  return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
end

local set_hl = function(hlGroup, options)
  vim.api.nvim_set_hl(0, hlGroup, options)
end

local is_git_workspace = function()
  local filepath = vim.fn.expand("%:p:h")
  local gitdir = vim.fn.finddir(".git", filepath .. ";")
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

local get_server_names = function()
  local buffer_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
  local active_clients = Lonard.lsp.get_clients();
  if next(active_clients) ~= nil then
    for _, client in ipairs(active_clients) do
      local file_type = client.config.filetypes
      if file_type and vim.fn.index(file_type, buffer_ft) ~= -1 then
        return custom_labels[client.name] or client.name
      end
    end
  end
  return "No Lsp attached"
end

local opts = {
  extensions = {
    "neo-tree",
    "lazy",
    "oil",
  },

  options = {
    disabled_filetypes = {
      statusline = {
        "dashboard",
        "alpha",
      },
    },
    globalstatus = true,
    component_separators = "",
    section_separators = "",
    icons_enabled = true,
    theme = "auto",
  },

  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function insert_left(changes)
  table.insert(opts.sections.lualine_c, changes or {})
end

local function insert_right(changes)
  table.insert(opts.sections.lualine_x, changes or {})
end

insert_left({
  "mode",
  -- fmt = function(str)
  --   return icons.Common.Vim .. str
  -- end,
  color = function()
    return {
      bg = vmodecolor[vim.fn.mode()],
      fg = bgcolor,
      gui = "bold",
    }
  end,
})

insert_left({
  function()
    return icons.Common.ChevronRight
  end,
  padding = 0,
  color = function()
    return {
      fg = vmodecolor[vim.fn.mode()],
      bg = colors.yellow,
    }
  end,
})

-- Git Branch
insert_left({
  "branch",
  icon = icons.Git.Branch,
  color = {
    bg = colors.yellow,
    fg = bgcolor,
    gui = "bold",
  },
  fmt = function(str)
    if str == "" or str == nil then
      return "!= vcs"
    end
    return str
  end,
})

insert_left({
  "filename",
  padding = 0,
  cond = is_buffer_not_empty,
  fmt = function(filename)
    local icon = icons.Common.File
    local color = colors.green

    if require("nvim-web-devicons").has_loaded() then
      local ext = vim.fn.expand("%:e")
      icon, color = require("nvim-web-devicons").get_icon_color(filename, ext)
    end

    set_hl("StatusLineFileIconPrefix", {
      fg = colors.yellow,
      bg = color,
    })

    set_hl("StatusLineFileIcon", {
      fg = bgcolor,
      bg = color,
    })

    set_hl("StatusLineFileIconSuffix", {
      fg = color,
      bg = colors.green,
    })

    set_hl("StatusLineFileName", {
      fg = bgcolor,
      bg = colors.green,
      bold = true,
    })

    set_hl("StatusLineFileNameSuffix", {
      fg = colors.green,
      bg = bgcolor,
    })

    local ft_icon_prefix = "%#StatusLineFileIconPrefix#" .. icons.Common.ChevronRight
    local ft_icon = "%#StatusLineFileIcon# " .. icon
    local ft_icon_suffix = " %#StatusLineFileIconSuffix#" .. icons.Common.ChevronRight
    local ft_name = "%#StatusLineFileName# " .. filename .. " "
    local ft_name_suffix = "%#StatusLineFileNameSuffix#" .. icons.Common.ChevronRight .. "%*"

    return ft_icon_prefix .. ft_icon .. ft_icon_suffix .. ft_name .. ft_name_suffix
  end,
})

insert_left({
  "filesize",
  cond = is_buffer_not_empty,
  padding = { right = 1, left = 1 },
  color = { fg = colors.blue },
  fmt = function(filesize)
    return "🧷 " .. filesize .. " "
  end,
})

insert_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = icons.Diagnostics.Error,
    warn = icons.Diagnostics.Warn,
    info = icons.Diagnostics.Info,
  },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_info = { fg = colors.cyan },
    color_warn = { fg = colors.yellow },
  },
})

-- middle separator
insert_left({
  function()
    return "%="
  end,
})

insert_right({
  "lsp_progress",
  display_components = {
    "lsp_client_name",
    "spinner",
    -- { "title", "percentage", "message" },
  },
  spinner_symbols = icons.SpinnerFrames,
  color = {
    fg = colors.yellow,
    bg = colors.trans,
  },
})

-- Attached Lsp server's name
insert_right({
  function()
    return get_server_names()
  end,
  fmt = function(serverName)
    -- return "🚀 ≪ " .. serverName .. " ≫"
    return "🔸 " .. serverName .. " 🔸"
  end,
  color = {
    fg = colors.blue,
  },
})

insert_right({
  "diff",
  cond = is_git_workspace,
  symbols = {
    added = icons.Git.Untracked .. " ",
    modified = icons.Git.Unstaged .. " ",
    removed = icons.Git.Deleted .. " ",
  },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
})

insert_right({
  "progress",
  padding = 0,
  color = {
    fg = colors.green,
    gui = "bold",
  },
  fmt = function(progress)
    return " " .. progress .. " "
  end,
})

insert_right({
  "location",
  padding = 0,
  color = {
    gui = "bold",
    fg = colors.yellow,
  },
  fmt = function(location)
    return " " .. location .. " "
  end,
})

insert_right({
  function()
    return icons.Common.Block
  end,
  padding = 0,
  color = function()
    return {
      fg = vmodecolor[vim.fn.mode()],
    }
  end,
})

---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  event = "UIEnter",
  dependencies = "arkav/lualine-lsp-progress",
  config = function()
    require("lualine").setup(opts)
  end,
}
