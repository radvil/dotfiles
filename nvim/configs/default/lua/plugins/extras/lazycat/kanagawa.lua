local overrides = function(colors)
  local transparent = vim.g.neo_transparent
  local theme = colors.theme
  local palette = {
    light = "#ffffff",
    sky = "#51AFEF",
    pink = "#ff007c",
    yellow = "#ffc777",
  }

  local Hi = {
    IblIndent = { fg = theme.ui.bg_p2 },
    StatusLine = { bold = false, bg = theme.ui.bg_m3, fg = theme.vcs.changed },
    WinSeparator = { fg = transparent and theme.ui.nontext or theme.ui.bg_p2 },

    FlashCurrent = { fg = palette.dark, bg = palette.yellow, bold = true },
    FlashLabel = { fg = palette.light, bg = palette.pink, bold = true },
    FlashMatch = { fg = palette.light, bg = palette.sky },

    -- Telescope preview panel
    TelescopeTitle = { fg = theme.ui.special, bold = true },
    TelescopePromptTitle = { fg = theme.ui.bg_m3, bg = theme.vcs.changed },
    TelescopePreviewTitle = { fg = theme.ui.bg_m3, bg = theme.diag.hint },
    TelescopePreviewBorder = { bg = theme.ui.bg_m3, fg = theme.ui.bg_m3 },
    TelescopePreviewNormal = { bg = theme.ui.bg_m3 },
    TelescopeResultsTitle = { fg = theme.ui.bg_m3, bg = theme.syn.special3 },
  }

  -- Floating panels
  Hi.FloatBorder = { bg = "none", fg = theme.vcs.changed }
  Hi.FloatTitle = { bg = theme.vcs.changed, fg = theme.ui.bg_m3 }
  Hi.NormalFloat = { bg = "none", fg = theme.vcs.changed }

  if not transparent then
    --- borderless telescope
    Hi.TelescopePromptBorder = { fg = theme.vcs.changed, bg = theme.ui.bg }
    Hi.TelescopePromptNormal = { bg = theme.ui.bg }
    Hi.TelescopePromptPrefix = { bg = theme.ui.bg }
    Hi.TelescopeResultsNormal = { bg = theme.ui.bg }
    Hi.TelescopeResultsBorder = { bg = theme.ui.bg, fg = theme.syn.special3 }
  else
    -- Diagnostics virt text
    local makeDiagnosticColor = function(color)
      local c = require("kanagawa.lib.color")
      return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
    end
    Hi.DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint)
    Hi.DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info)
    Hi.DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning)
    Hi.DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error)

    -- Telescope Panels
    Hi.TelescopePromptBorder = { bg = "NONE", fg = theme.vcs.changed }
    Hi.TelescopeResultsBorder = { bg = "NONE", fg = theme.syn.special3 }
  end
  return Hi
end

return {
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  lazy = not string.match(vim.g.neo_colorscheme, "kanagawa"),
  opts = {
    -- theme = "wave", "wave" | "dragon" | "lotus"
    background = {
      --- @type "wave" | "dragon" | "lotus"
      dark = "wave",
      light = "lotus",
    },
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,
    dimInactive = false,
    terminalColors = true,
    colors = {
      palette = {},
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    ---@return table<string, string>
  },
  config = function(_, opts)
    opts.transparent = vim.g.neo_transparent
    opts.dimInactive = vim.g.neo_diminactive
    opts.overrides = overrides
    require("kanagawa").setup(opts)
  end,
}
