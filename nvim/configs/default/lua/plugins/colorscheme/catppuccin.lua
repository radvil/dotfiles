local custom_hls = function(colors)
  local palette = {
    dark = "#1E1E2E",
    light = "#ffffff",
    sky = "#51AFEF",
    pink = "#ff007c",
    yellow = "#ffc777",
  }

  local Hls = {
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
      -- bg = colors.base,
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
    WinSeparator = { fg = vim.g.neo_transparent and colors.surface1 or colors.crust },
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

  -- Floating panels
  if not vim.g.neo_transparent then
    Hls.FloatBorder = {
      bg = colors.mantle,
      fg = colors.mantle,
    }
    Hls.FloatTitle = {
      bg = colors.mantle,
      fg = colors.maroon,
    }
    Hls.NormalFloat = {
      bg = colors.mantle,
    }
  end

  return Hls
end

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 9999,
  -- lazy = false,
  lazy = not string.match(vim.g.neo_colorscheme, "catppuccin"),
  opts = {
    flavour = "auto",
    term_colors = true,
    default_integrations = true,
    transparent_background = false,
    background = { light = "latte", dark = "frappe" },
    dim_inactive = { enabled = true, shade = "dark", percentage = 0.15 },
    color_overrides = {},
    integrations = {
      flash = false,
      nvimtree = false,
      -- navic = { custom_bg = "lualine" },
      navic = false,
      indent_blankline = { colored_indent_levels = true },
      native_lsp = { inlay_hints = { background = true } },
      telescope = {
        style = "nvchad",
      },
    },
  },
  ---@param opts CatppuccinOptions
  config = function(_, opts)
    local transparent = vim.g.neo_transparent
    opts.transparent_background = transparent
    opts.dim_inactive.enabled = vim.g.neo_diminactive
    opts.custom_highlights = custom_hls
    require("catppuccin").setup(opts)
  end,
}
