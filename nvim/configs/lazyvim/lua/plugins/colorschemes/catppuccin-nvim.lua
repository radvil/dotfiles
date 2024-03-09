return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,

  config = function()
    local Prefer = require("preferences")
    ---@type CatppuccinOptions
    local opts = {
      ---@type "macchiato" | "mocha" | "frappe"
      flavour = vim.g.neovide and "macchiato" or "mocha",
      transparent_background = Prefer.transparent,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        percentage = 0.13,
        shade = "dark",
      },
      integrations = {
        alpha = true,
        barbar = false,
        treesitter = true,
        dropbar = false,
        dashboard = true,
        lsp_trouble = true,
        cmp = true,
        gitsigns = true,
        which_key = true,
        markdown = true,
        ts_rainbow2 = true,
        notify = true,
        mini = true,
        noice = true,
        neotree = true,
        nvimtree = false,
        harpoon = true,
        mason = true,
        illuminate = true,
        navic = {
          enabled = true,
          custom_bg = Prefer.transparent and "NONE" or "lualine",
        },
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        native_lsp = {
          enabled = true,
          inlay_hints = {
            background = true,
          },
        },
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        barbecue = {
          dim_dirname = true,
          bold_basename = false,
          dim_context = true,
          alt_background = false,
        },
      },
      color_overrides = {
        mocha = {
          surface0 = Prefer.palette.bg2,
        },
      },
      custom_highlights = function(C)
        local hls = {
          TermCursor = { bg = C.sky },
          CursorLine = { bg = C.surface0 },
          IncSearch = {
            bg = C.maroon,
            fg = C.crust,
          },
          WinSeparator = {
            fg = C.surface1,
          },
          MiniIndentscopeSymbol = {
            fg = C.flamingo,
          },
          NavicText = {
            fg = C.rosewater,
          },
          FlashCurrent = {
            fg = Prefer.palette.bg,
            bg = Prefer.palette.yellow,
            style = { "bold" },
          },
          FlashMatch = {
            fg = Prefer.palette.bg2,
            bg = Prefer.palette.blue2,
          },
          FlashLabel = {
            fg = Prefer.palette.fg,
            bg = Prefer.palette.pink,
            style = { "bold" },
          },
          NeoTreeIndentMarker = {
            fg = C.surface0,
          },
          NeoTreeGitModified = {
            fg = C.rosewater,
          },
        }

        if not Prefer.transparent then
          hls.WinSeparator = {
            fg = C.crust,
          }
          hls.StatusLineNC = {
            bg = C.crust,
          }
          hls.StatusLine = {
            bg = C.crust,
            fg = C.rosewater,
          }
          hls.TreesitterContext = {
            bg = C.surface0,
          }
          hls.TelescopePromptBorder = {
            bg = C.crust,
            fg = C.crust,
          }
          hls.TelescopePromptNormal = {
            bg = C.crust,
          }
          hls.TelescopePromptTitle = {
            bold = true,
            bg = C.peach,
            fg = C.crust,
          }
          hls.TelescopePromptPrefix = {
            bg = C.crust,
          }
          hls.TelescopeResultsTitle = {
            bg = C.yellow,
          }
          hls.TelescopeResultsNormal = {
            bg = C.crust,
          }
          hls.TelescopeResultsBorder = {
            bg = C.crust,
            fg = C.crust,
          }
        end

        return hls
      end,
    }
    require("catppuccin").setup(opts)
  end,
}
