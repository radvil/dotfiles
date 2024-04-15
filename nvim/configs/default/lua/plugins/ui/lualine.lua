---@diagnostic disable: undefined-field

local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

M.config = function(_, opts)
  local Icons = require("lazyvim.config").icons
  local A = {
    "mode",
    LazyVim.lualine.root_dir({
      -- color = { fg = nil, gui="italic,bold" },
      color = { fg = nil, gui = "bold" },
      icon = "󱉭",
    }),
  }
  local B = {
    {
      "filetype",
      icon_only = true,
      separator = "",
      padding = {
        left = 1,
        right = 0,
      },
    },
    { LazyVim.lualine.pretty_path({ filename_hl = "@markup" }) },
  }
  local C = {
    {
      "diagnostics",
      symbols = {
        error = Icons.diagnostics.Error,
        warn = Icons.diagnostics.Warn,
        info = Icons.diagnostics.Info,
        hint = Icons.diagnostics.Hint,
      },
    },
    {
      function()
        return require("nvim-navic").get_location()
      end,
      cond = function()
        return not LazyVim.has("barbecue") and package.loaded["nvim-navic"] and require("nvim-navic").is_available()
      end,
    },
  }
  local Y = {
    {
      function()
        return require("noice").api.status.mode.get()
      end,
      cond = function()
        return package.loaded["noice"] and require("noice").api.status.mode.has()
      end,
      color = LazyVim.ui.fg("Constant"),
    },
    {
      require("lazy.status").updates,
      cond = require("lazy.status").has_updates,
      color = LazyVim.ui.fg("Special"),
    },
    {
      "diff",
      symbols = {
        added = Icons.git.added .. " ",
        modified = Icons.git.modified .. " ",
        removed = Icons.git.removed .. " ",
      },
      source = function()
        if vim.b.minidiff_summary then
          local summary = vim.b.minidiff_summary
          return {
            added = summary.add,
            modified = summary.change,
            removed = summary.delete,
          }
        else
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end
      end,
    },
  }
  if LazyVim.has("codeium.nvim") then
    table.insert(Y, 2, LazyVim.lualine.cmp_source("codeium"))
  elseif LazyVim.has("copilot.lua") then
    table.insert(Y, 2, LazyVim.lualine.cmp_source("copilot"))
  end
  local Z = {
    {
      function()
        return require("noice").api.status.command.get()
      end,
      cond = function()
        return package.loaded["noice"] and require("noice").api.status.command.has()
      end,
    },
    {
      "progress",
      separator = " ",
      padding = {
        left = 1,
        right = 0,
      },
    },
    {
      "location",
      padding = {
        left = 0,
        right = 1,
      },
    },
  }

  if vim.g.neovide or not os.getenv("TMUX") then
    table.insert(B, 1, "branch")
  end

  if opts.sections then
    opts.sections.lualine_a = A
    opts.sections.lualine_b = B
    opts.sections.lualine_c = C
    opts.sections.lualine_x = {}
    opts.sections.lualine_y = Y
    opts.sections.lualine_z = Z
  end

  require("lualine").setup({
    extensions = { "neo-tree", "lazy", "oil" },
    options = {
      theme = "auto",
      globalstatus = vim.opt.laststatus:get() == 3,
      disabled_filetypes = {
        statusline = {
          "dashboard",
          "alpha",
        },
      },
    },
    sections = {
      lualine_a = A,
      lualine_b = B,
      lualine_c = C,
      lualine_x = {},
      lualine_y = Y,
      lualine_z = Z,
    },
  })
end

return M
