local palette = {
  dark = "#1E1E2E",
  light = "#ffffff",
  sky = "#51AFEF",
  pink = "#ff007c",
  yellow = "#ffc777",
}

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 99999,
  config = function(_, opts)
    ---@type CatppuccinOptions
    local defaults = {
      flavour = "auto",
      term_colors = true,
      transparent_background = vim.g.neo_transparent,
      default_integrations = true,
      integrations = {
        flash = false,
        nvimtree = false,
        mini = { enabled = true },
        navic = {
          enabled = true,
          custom_bg = "lualine",
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
          style = vim.g.neo_transparent and "classic" or "nvchad",
        },
      },
      custom_highlights = function(colors)
        local hl_groups = {
          NeoBufferLineOffset = {
            bg = colors.mantle,
            fg = colors.blue,
            bold = true,
            italic = true,
          },
          Folded = {
            bg = colors.mantle,
            fg = colors.maroon,
          },
          StatusLineNC = { bg = colors.crust },
          StatusLine = {
            bold = false,
            bg = colors.base,
            fg = colors.rosewater,
          },
          FlashCurrent = {
            fg = palette.dark,
            bg = palette.yellow,
            style = { "bold" },
          },
          FlashMatch = {
            fg = palette.light,
            bg = palette.sky,
          },
          FlashLabel = {
            fg = palette.light,
            bg = palette.pink,
            style = { "bold" },
          },
          IncSearch = { bg = colors.maroon, fg = colors.crust },
          WinSeparator = { fg = vim.g.neo_transparent and colors.surface1 or colors.mantle },
          MiniIndentscopeSymbol = { fg = colors.flamingo },
          NavicText = { fg = colors.subtext0, bold = false },
          NavicSeparator = { fg = colors.surface1 },
          NeoTreeIndentMarker = { fg = colors.surface0 },
          NeoTreeGitModified = { fg = colors.rosewater },
          NeoTreeGitUntracked = { fg = colors.peach },
          NeoTreeGitRenamed = { fg = colors.pink },
          NeoTreeTabInactive = { bg = colors.base },
          NeoTreeTabActive = {
            bg = colors.surface0,
            fg = colors.text,
            bold = false,
          },
          NeoTreeTabSeparatorInactive = {
            bg = colors.base,
            fg = colors.base,
          },
          NeoTreeTabSeparatorActive = {
            bg = colors.surface0,
            fg = colors.peach,
          },
          NeoTreeTitlebar = {
            bg = colors.blue,
            fg = colors.crust,
            bold = true,
          },
          NeoTreeWinSeparator = { link = "WinSeparator" },
          NvimTreeIndentMarker = { link = "NeoTreeIndentMarker" },
          NvimTreeGitDirty = { link = "NeoTreeGitModified" },
          NvimTreeWinSeparator = { link = "WinSeparator" },
          SymbolsOffsetFill = {
            bg = colors.blue,
            fg = colors.mantle,
            bold = true,
          },
          SymbolsOutlineConnector = { link = "NeoTreeIndentMarker" },
          GitSignsUntracked = { fg = colors.blue },
          GitSignsTopDelete = { fg = colors.maroon },
          MiniDiffSignAdd = { link = "GitSignsAdd" },
          MiniDiffSignChange = { link = "GitSignsChange" },
          MiniDiffSignDelete = { link = "GitSignsDelete" },
          NoicePopupmenuBorder = { fg = colors.peach },
          NoiceCmdlinePopupBorder = { fg = colors.peach },
          NoiceCmdlinePopupTitle = { fg = colors.subtext0 },
          NoiceCmdlineIcon = { fg = colors.subtext0 },
          InclineActive = { bg = colors.surface0, fg = colors.rosewater },
          InclineInActive = { bg = colors.mantle, fg = colors.surface1 },
        }
        if vim.g.neo_winborder == "none" then
          hl_groups.TelescopePromptBorder = {
            bg = colors.crust,
            fg = colors.crust,
          }
          hl_groups.TelescopePromptNormal = { bg = colors.crust }
          hl_groups.TelescopePromptTitle = {
            bold = true,
            bg = colors.maroon,
            fg = colors.crust,
          }
          hl_groups.TelescopeResultsTitle = {
            -- these should set to invisible
            bg = colors.crust,
            fg = colors.crust,
          }
          hl_groups.TelescopePreviewTitle = {
            bold = true,
            bg = colors.blue,
            fg = colors.crust,
          }
          hl_groups.TelescopeResultsBorder = {
            bg = colors.crust,
            fg = colors.crust,
          }
          hl_groups.TelescopePromptPrefix = { bg = colors.crust }
          hl_groups.TelescopeResultsNormal = { bg = colors.crust }
        end
        return hl_groups
      end,
    }

    opts = vim.tbl_deep_extend("force", opts or {}, defaults)
    require("catppuccin").setup(opts)
  end,
}
