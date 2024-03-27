return {
  "tokyonight.nvim",
  optional = true,
  opts = function()
    local transparent = vim.g.neo_transparent
    return {
      on_colors = function(colors)
        colors.statusline = "#181826"
        colors.subtext1 = "#bac2de"
        colors.subtext0 = "#a6adc8"
        colors.surface1 = "#45475a"
        colors.surface0 = "#313244"
      end,
      on_highlights = function(hl, c)
        hl.Folded = {
          bg = transparent and c.statusline or c.bg_dark,
        }
        hl.StatusLineNC = {
          bg = c.bg_dark,
        }
        hl.WinSeparator = {
          fg = transparent and c.fg_gutter or c.statusline,
        }
        hl.NeoTreeTabInactive = {
          bg = c.bg_highlight,
          fg = c.fg_dark,
        }
        hl.NeoTreeTabActive = {
          bg = transparent and c.none or c.bg_dark,
          fg = c.blue,
        }
        hl.NeoTreeTabSeparatorInactive = {
          bg = c.bg_highlight,
          fg = c.bg_dark,
        }
        hl.NeoTreeTabSeparatorActive = {
          bg = transparent and c.none or c.bg_dark,
          fg = c.blue,
        }
        hl.NavicText = { fg = c.subtext0, bold = false }
        hl.NavicSeparator = { fg = c.surface1 }

        if not transparent then
          hl.StatusLine = {
            bg = c.bg_dark,
            fg = c.blue,
          }
          hl.TelescopePromptBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopePromptNormal = {
            bg = c.bg_dark,
          }
          hl.TelescopePromptTitle = {
            bold = true,
            bg = c.blue1,
            fg = c.bg_dark,
          }
          hl.TelescopePromptPrefix = {
            bg = c.bg_dark,
          }
          hl.TelescopeResultsTitle = {
            bg = c.purple,
          }
          hl.TelescopeResultsNormal = {
            bg = c.bg_dark,
          }
          hl.TelescopeResultsBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
        end
      end,
    }
  end,
}
