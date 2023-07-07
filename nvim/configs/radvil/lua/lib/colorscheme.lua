return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 10000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      ---@type string
      flavour = "mocha",
      transparent_background = false,
      no_italic = false,
      no_bold = false,
      no_underline = true,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        percentage = 0.15,
        shade = "dark",
      },
      integrations = {
        alpha = true,
        treesitter = true,
        coc_nvim = false,
        lsp_trouble = true,
        cmp = true,
        lsp_saga = false,
        leap = true,
        gitgutter = false,
        gitsigns = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        which_key = true,
        dashboard = false,
        bufferline = true,
        markdown = true,
        lightspeed = false,
        ts_rainbow2 = false,
        hop = false,
        notify = true,
        telekasten = false,
        symbols_outline = false,
        mini = true,
        noice = true,
        neotree = true,
        nvimtree = false,
        navic = {
          enabled = true,
        },
        dap = {
          enabled = false,
          enable_ui = false,
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
      },
    })
  end

}
