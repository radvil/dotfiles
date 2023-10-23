return {
  "loctvl842/monokai-pro.nvim",
  priority = 998,
  lazy = false,
  config = function(_, opts)
    local Prefer = require("preferences")
    local NeoDefaults = {
      ---@type "classic" | "octagon" | "pro" | "machine" | "ristretto" | "spectrum"
      filter = "pro",
      inc_search = "background",
      terminal_colors = true,
      devicons = true,
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
          underline_fill = false,
          bold = false,
        },
        indent_blankline = {
          context_highlight = "pro",
          context_start_underline = false,
        },
      },
      override = function()
        return {
          LazyNormal = { link = "Normal" },
          LspInlayHint = { link = "Comment" },
          ZenBg = { bg = Prefer.palette.bg },
          Visual = {
            bg = "#55435b",
          },
          TelescopeSelectionCaret = {
            link = "Visual",
          },
          TelescopeMatching = {
            fg = Prefer.palette.yellow,
          },
          FlashCurrent = {
            fg = Prefer.palette.bg,
            bg = Prefer.palette.yellow,
            bold = true,
          },
          FlashMatch = {
            fg = Prefer.palette.bg2,
            bg = Prefer.palette.blue2,
          },
          FlashLabel = {
            fg = Prefer.palette.fg,
            bg = Prefer.palette.pink,
            bold = true,
          },
        }
      end,
    }

    opts = vim.tbl_deep_extend("force", opts or {}, NeoDefaults)

    if Prefer.transparent then
      opts.transparent_background = true
      opts.background_clear = {
        "toggleterm",
        "float_win",
        "telescope",
        "which-key",
        "telescope",
        "neo-tree",
        "renamer",
        "notify",
        "mason",
        "cmp_menu",
        "lsp_info",
        "noice",
      }
    end

    require("monokai-pro").setup(opts)
  end,
}
