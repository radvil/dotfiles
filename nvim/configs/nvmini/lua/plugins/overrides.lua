---@diagnostic disable: need-check-nil

return {
  { "rcarriga/nvim-notify", enabled = false },
  { "folke/noice.nvim", enabled = false },
  -- { "williamboman/mason.nvim", enabled = false },
  {
    "radvil2/windows.nvim",
    optional = true,
    opts = {
      animation = { enable = true },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      options = {
        globalstatus = true,
        theme = function()
          local O = require("catppuccin").options
          local X = require("catppuccin.palettes").get_palette("mocha")
          local transparent_bg = O.transparent_background and "NONE" or X.mantle
          local catppuccin = {}

          catppuccin.normal = {
            a = { bg = X.blue, fg = X.mantle, gui = "bold" },
            b = { bg = X.surface0, fg = X.text },
            c = { bg = transparent_bg, fg = X.subtext0 },
          }

          catppuccin.insert = {
            a = { bg = X.green, fg = X.base, gui = "bold" },
            b = { bg = X.surface0, fg = X.green },
          }

          catppuccin.terminal = {
            a = { bg = X.green, fg = X.base, gui = "bold" },
            b = { bg = X.surface0, fg = X.green },
          }

          catppuccin.command = {
            a = { bg = X.peach, fg = X.base, gui = "bold" },
            b = { bg = X.surface0, fg = X.peach },
          }

          catppuccin.visual = {
            a = { bg = X.mauve, fg = X.base, gui = "bold" },
            b = { bg = X.surface0, fg = X.mauve },
          }

          catppuccin.replace = {
            a = { bg = X.red, fg = X.base, gui = "bold" },
            b = { bg = X.surface0, fg = X.red },
          }

          catppuccin.inactive = {
            a = { bg = X.mantle, fg = X.blue },
            b = { bg = X.mantle, fg = X.surface0, gui = "bold" },
            c = { bg = X.mantle, fg = X.overlay0 },
          }

          return catppuccin
        end,
      },
    },
  },

  {
    "folke/noice.nvim",
    optional = true,
    opts = {
      notify = { enabled = true },
      smartmove = { enabled = true },
      cmdline = {
        enabled = true,
        view = "cmdline",
      },
      popup_menu = {
        enabled = false,
      },
      views = {
        cmdline_popup = {
          position = {
            col = "50%",
            row = "20%",
          },
        },
        virtualtext = {
          hl_group = "FlashCurrent",
        },
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      source_selector = {
        winbar = true,
      },
    },
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        ["angular.json"] = {
          icon = "",
          color = "#f38ba8",
          name = "AngularJson",
        },
        ["service.ts"] = {
          icon = "",
          color = "#EBBA0B",
          name = "AngularService",
        },
        ["component.ts"] = {
          icon = "",
          color = "#549FDD",
          name = "AngularComponent",
        },
        ["cmp.ts"] = {
          icon = "",
          color = "#f38ba8",
          name = "AngularCmp",
        },
        ["module.ts"] = {
          icon = "",
          color = "#CD1053",
          name = "AngularModule",
        },
        ["routes.ts"] = {
          icon = "",
          color = "#6DD390",
          name = "AngularRoutes",
        },
        ["pipe.ts"] = {
          icon = "",
          color = "#62B2C6",
          name = "AngularPipe",
        },
        ["interface.ts"] = {
          icon = "ﯤ",
          color = "#448BDE",
          name = "TypeScriptInterface",
        },
        ["store.ts"] = {
          icon = "",
          color = "#AE61E0",
          name = "AngularStore",
        },
        ["actions.ts"] = {
          icon = "",
          color = "#D52F2F",
          name = "StoreActions",
        },
        ["selectors.ts"] = {
          icon = "",
          color = "#EBBA0B",
          name = "StoreSelectors",
        },
        ["effects.ts"] = {
          icon = "",
          color = "#448BDE",
          name = "StoreEffects",
        },
      },
    },
  },
}
