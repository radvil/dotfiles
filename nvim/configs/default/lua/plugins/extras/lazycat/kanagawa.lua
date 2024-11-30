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
    overrides = function(colors)
      local theme = colors.theme
      local Schema = {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        StatusLine = {
          bold = false,
          bg = theme.ui.bg_m3,
          -- fg = theme.ui.fg_dim,
          fg = theme.vcs.changed,
        },
        --- dark completion (popup) menu
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
        IblIndent = { fg = theme.ui.bg_p2 },
        WinSeparator = { fg = theme.ui.bg_p1 },
      }

      if not vim.g.neo_transparent then
        --- borderless telescope
        Schema.TelescopeTitle = { fg = theme.ui.special, bold = true }
        Schema.TelescopePromptNormal = { bg = theme.ui.bg_p1 }
        Schema.TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 }
        Schema.TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 }
        Schema.TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 }
        Schema.TelescopePreviewNormal = { bg = theme.ui.bg_dim }
        Schema.TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim }
      else
        local makeDiagnosticColor = function(color)
          local c = require("kanagawa.lib.color")
          return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end
        Schema.DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint)
        Schema.DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info)
        Schema.DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning)
        Schema.DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error)
      end
      return Schema
    end,
  },
  config = function(_, opts)
    local transparent = vim.g.neo_transparent
    opts.transparent = transparent
    opts.dimInactive = true
    require("kanagawa").setup(opts)
  end,
}
