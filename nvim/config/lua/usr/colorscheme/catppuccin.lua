---@type LazySpec
local M = {}
M[1] = "catppuccin/nvim"
M.name = "catppuccin"

M.opts = {
  ---@type "latte" | "frappe" | "macchiato" | "mocha"
  flavour = rvim.theme.variant,
  transparent_background = rvim.theme.transbg,
  term_colors = true,
  dim_inactive = {
    enabled = false,
    percentage = 0.15,
    shade = "dark",
  },
  background = {
    light = "latte",
    dark = "mocha",
  },
  styles = {
    conditionals = { "italic" },
    comments = { "italic" },
  },
  integrations = {
    treesitter = true,
    coc_nvim = false,
    lsp_trouble = true,
    cmp = true,
    lsp_saga = false,
    leap = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    which_key = true,
    dashboard = false,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = false,
    ts_rainbow = false,
    hop = true,
    notify = true,
    telekasten = false,
    symbols_outline = false,
    mini = false,
    navic = false,
    noice = false,
    fidget = false,
    neotree = true,
    nvimtree = {
      enabled = false,
      transparent_panel = rvim.theme.transbg,
      show_root = true,
    },
    dap = {
      enabled = false,
      enable_ui = false,
    },
    indent_blankline = {
      enabled = false,
      colored_indent_levels = false,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        information = { "italic" },
        warnings = { "italic" },
        errors = { "italic" },
        hints = { "italic" },
      },
      underlines = {
        information = { "underline" },
        warnings = { "underline" },
        errors = { "underline" },
        hints = { "underline" },
      },
    },
  },
}

if rvim.theme.colorscheme == "catppuccin" then
  M.priority = 999
  M.lazy = false
  M.init = function()
    vim.cmd("colorscheme catppuccin")
  end
end

return M
