---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  -- TODO: override noice ui disable lsp indicator
  dependencies = { "arkav/lualine-lsp-progress", "nvim-tree/nvim-web-devicons" },
  opts = function()
    local u = require("common.utils")
    local c = require("common.colors")
    local i = require("common.icons")
    local base = c.bg
    local mode_colors = {
      n = c.red,
      i = c.green,
      v = c.orange,
      [""] = c.orange,
      V = c.orange,
      c = c.magenta,
      no = c.red,
      s = c.pink,
      S = c.pink,
      [""] = c.pink,
      ic = c.cyan,
      R = c.violet,
      Rv = c.violet,
      cv = c.blue,
      ce = c.blue,
      r = c.magenta,
      rm = c.magenta,
      ["r?"] = c.magenta,
      ["!"] = c.red,
      t = c.red,
    }

    local opts = {
      extensions = { "neo-tree", "lazy" },
      options = {
        globalstatus = true,
        component_separators = "",
        section_separators = "",
        icons_enabled = true,
        theme = "auto",
        disabled_filetypes = {
          "alpha",
          "Dashboard",
        },
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
      return table.insert(opts.sections.lualine_x, changes or {})
    end

    ---@alias VType string | function
    ---@param x {left: VType; middle: VType; right: VType}
    local function arrow(x)
      local function val(v)
        if type(v) == "function" then
          return v()
        else
          return v
        end
      end
      table.insert(opts.sections.lualine_c, {
        function()
          return ""
        end,
        padding = 0,
        color = function()
          return {
            fg = val(x.left),
            bg = val(x.middle),
          }
        end,
      })
      table.insert(opts.sections.lualine_c, {
        function()
          return ""
        end,
        padding = 0,
        color = function()
          return {
            fg = val(x.middle),
            bg = val(x.right),
          }
        end,
      })
    end

    insert_left({
      "mode",
      fmt = function(str)
        return i.Vim .. str
      end,
      color = function()
        return {
          bg = mode_colors[vim.fn.mode()],
          gui = "bold",
          fg = base,
        }
      end,
    })

    arrow({
      left = function()
        return mode_colors[vim.fn.mode()]
      end,
      middle = c.orange,
      right = c.yellow,
    })

    insert_left({
      "branch",
      icon = i.Git,
      color = {
        bg = c.yellow,
        gui = "bold",
        fg = base,
      },
      fmt = function(str)
        if str == "" or str == nil then
          return "!= vcs"
        end
        return str
      end,
    })

    arrow({
      left = c.yellow,
      middle = c.violet,
      right = function()
        return u.is_not_empty_buffer() and u.get_filemeta().color or ""
      end,
    })

    insert_left({
      "filename",
      padding = 0,
      cond = u.is_not_empty_buffer,
      fmt = function(name)
        local separator = i.ChevronRightFilled
        local meta = u.get_filemeta(name)
        -- TODO: register global highlight
        local ficon = u.create_hi("NgVimFileIconContent", {
          content = meta.icon,
          padding = " ",
          fg = base,
          bg = meta.color,
        })
        local ficon_suffix = u.create_hi("NgVimFileIconSuffix", {
          content = separator,
          bg = c.green,
          fg = meta.color,
        })
        local fname = u.create_hi("NgVimFileName", {
          content = name,
          padding = " ",
          bg = c.green,
          fg = base,
          bold = true,
        })
        local fname_suffix = u.create_hi("NgVimFileNameSuffix", {
          content = separator,
          bg = c.blue,
          fg = c.green,
        })
        return ficon .. ficon_suffix .. fname .. fname_suffix
      end,
    })

    insert_left({
      function()
        return i.ChevronRightFilled
      end,
      padding = 0,
      cond = u.is_not_empty_buffer,
      color = function()
        return {
          fg = c.blue,
        }
      end,
    })

    insert_left({
      function()
        return u.get_server_name()
      end,
      color = {
        fg = c.yellow,
      },
      fmt = function(name)
        return "🚀 « " .. name .. " »"
      end,
    })

    insert_left({
      "lsp_progress",
      display_components = { "spinner" },
      spinner_symbols = i.SpinnerFrames,
      color = {
        fg = c.yellow,
        bg = c.trans,
      },
    })

    insert_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = {
        error = i.Error,
        warn = i.Warn,
        info = i.Info,
      },
      diagnostics_color = {
        color_error = { fg = c.red },
        color_info = { fg = c.cyan },
        color_warn = { fg = c.yellow },
      },
    })

    insert_left({
      function()
        return "%="
      end,
    })

    insert_right({
      "diff",
      cond = u.is_git_workspace,
      symbols = {
        added = i.Untracked .. " ",
        modified = i.Unstaged .. " ",
        removed = i.Deleted .. " ",
      },
      diff_color = {
        added = { fg = c.green },
        modified = { fg = c.yellow },
        removed = { fg = c.red },
      },
    })

    insert_right({
      "filesize",
      cond = u.is_not_empty_buffer,
      padding = 0,
      color = u.fg("Special"),
      fmt = function(filesize)
        return " " .. filesize .. " "
      end,
    })

    insert_right({
      "progress",
      padding = 0,
      color = {
        fg = c.green,
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
        fg = c.yellow,
      },
      fmt = function(location)
        return " " .. location .. " "
      end,
    })

    insert_right({
      function()
        return i.Block
      end,
      padding = 0,
      color = function()
        return {
          fg = mode_colors[vim.fn.mode()],
        }
      end,
    })

    return opts
  end,

  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
